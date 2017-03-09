//===-- SparcS64fxPass.cpp - SXAR1/2 prefixer ---------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// [S64fx] This places SXAR1/2 prefix instructions of S64fx.
//===----------------------------------------------------------------------===//

// [S64fx] This file is new for S64fx.

#include "Sparc.h"
#include "SparcSubtarget.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/Target/TargetInstrInfo.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Target/TargetRegisterInfo.h"
#include "llvm/Support/Debug.h"
#include "llvm/MC/MCFixup.h"

using namespace llvm;

#define DEBUG_TYPE "sxar-prefixer"

namespace llvm {

  bool S64fxUsesOldAsm;

  // [S64fx] Sets the operation actions of vector instructions.  It
  // resets the all as Expand first.

  void SparcTargetLowering::setS64fxFPOperationActions(MVT vt) {
    assert(Subtarget->isACE());
    assert(!(Subtarget->isACE1() && Subtarget->isACE2()));
    assert((vt == MVT::v2f32) || (vt == MVT::v2f64)
           || (vt == MVT::v4f32) || (vt == MVT::v4f64));

    if (vt == MVT::v2f32) {
      addRegisterClass(MVT::v2f32, &SP::V2FPRegsRegClass);
    } else if (vt == MVT::v2f64) {
      addRegisterClass(MVT::v2f64, &SP::V2DFPRegsRegClass);
    } else if (vt == MVT::v4f32) {
      addRegisterClass(MVT::v4f32, &SP::V4FPRegsRegClass);
    } else if (vt == MVT::v4f64) {
      addRegisterClass(MVT::v4f64, &SP::V4DFPRegsRegClass);
    }

    //setCondCodeAction(ISD::SETO, vt, Expand);
    //setCondCodeAction(ISD::SETUO, vt, Expand);
    //setCondCodeAction(ISD::SETUEQ, vt, Expand);
    //setCondCodeAction(ISD::SETONE, vt, Expand);

    for (unsigned op = 0; op < ISD::BUILTIN_OP_END; op++) {
      setOperationAction(op, vt, Expand);
    }

    for (MVT memvt : MVT::vector_valuetypes()) {
      setTruncStoreAction(vt, memvt, Expand);
      setLoadExtAction(ISD::EXTLOAD, vt, memvt, Expand);
    }

    LegalizeAction IRRELEVANT = Legal;

    // Use Custom action to load/store to slightly change the
    // behavior for unaligned access.  See the custom code.

    setOperationAction(ISD::LOAD, vt, Custom);
    setOperationAction(ISD::STORE, vt, Custom);

    // MEMO: Setting both BUILD_VECTOR and VECTOR_SHUFFLE as Expand
    // will make expansion loops.

    setOperationAction(ISD::BUILD_VECTOR, vt, Legal);
    setOperationAction(ISD::INSERT_VECTOR_ELT, vt, Legal);
    setOperationAction(ISD::EXTRACT_VECTOR_ELT, vt, Legal);
    setOperationAction(ISD::SCALAR_TO_VECTOR, vt, Expand);
    setOperationAction(ISD::VECTOR_SHUFFLE, vt, Expand);

    // Let Expand SELECT_CC to SETCC-VSELECT for vectors.

    setOperationAction(ISD::SELECT_CC, vt, Expand);
    setOperationAction(ISD::SETCC, vt, Legal);
    setOperationAction(ISD::VSELECT, vt, Legal);
    setOperationAction(ISD::SELECT, vt, IRRELEVANT);

    setOperationAction(ISD::BITCAST, vt, Expand);

    setOperationAction(ISD::FP_TO_SINT, vt, Expand);
    setOperationAction(ISD::SINT_TO_FP, vt, Expand);
    setOperationAction(ISD::FP_TO_UINT, vt, Expand);
    setOperationAction(ISD::UINT_TO_FP, vt, Expand);

    setOperationAction(ISD::FADD, vt, Legal);
    setOperationAction(ISD::FSUB, vt, Legal);
    setOperationAction(ISD::FMUL, vt, Legal);
    setOperationAction(ISD::FMA, vt, Legal);
    setOperationAction(ISD::FABS, vt, Legal);
    setOperationAction(ISD::FNEG, vt, Legal);

    setOperationAction(ISD::FDIV, vt, Expand);
    setOperationAction(ISD::FSQRT, vt, Expand);

    setOperationAction(ISD::FREM, vt, Expand);
    setOperationAction(ISD::FCOPYSIGN, vt, Expand);

    setOperationAction(ISD::FRINT, vt, Expand);
    setOperationAction(ISD::FFLOOR, vt, Expand);
    setOperationAction(ISD::FCEIL, vt, Expand);
    setOperationAction(ISD::FTRUNC, vt, Expand);
    setOperationAction(ISD::FNEARBYINT, vt, Expand);
    setOperationAction(ISD::FROUND, vt, Expand);

    setOperationAction(ISD::FLOG, vt, Expand);
    setOperationAction(ISD::FLOG2, vt, Expand);
    setOperationAction(ISD::FLOG10, vt, Expand);
    setOperationAction(ISD::FEXP, vt, Expand);
    setOperationAction(ISD::FEXP2, vt, Expand);
    setOperationAction(ISD::FPOW, vt, Expand);
    setOperationAction(ISD::FPOWI, vt, Expand);

    setOperationAction(ISD::FSIN, vt, Expand);
    setOperationAction(ISD::FCOS, vt, Expand);
    setOperationAction(ISD::FSINCOS, vt, Expand);

    if (vt == MVT::v2f32 || vt == MVT::v4f32) {
      setOperationAction(ISD::FP_ROUND, vt, Legal);
    }
    if (vt == MVT::v2f64 || vt == MVT::v4f64) {
      setOperationAction(ISD::FP_EXTEND, vt, Legal);
    }

    setOperationAction(ISD::INTRINSIC_WO_CHAIN, MVT::Other, Custom);
  }

  // [S64fx] Makes v2i1/v4i1 legal VTs by addRegisterClass().
  // Otherwise, SETCC on vectors are scalarized at the
  // type-legalization phase.  It is really necessary to do so; See
  // TargetLoweringBase:: computeRegisterProperties().

  void SparcTargetLowering::setS64fxI1OperationActions(MVT vt) {
    assert(Subtarget->isACE());
    assert(!(Subtarget->isACE1() && Subtarget->isACE2()));
    assert((vt == MVT::v2i1) || (vt == MVT::v4i1));

    if (vt == MVT::v2i1) {
      addRegisterClass(vt, &SP::V2FPRegsRegClass);
    } else if (vt == MVT::v4i1) {
      addRegisterClass(vt, &SP::V4FPRegsRegClass);
    }

    for (unsigned op = 0; op < ISD::BUILTIN_OP_END; op++) {
      setOperationAction(op, vt, Expand);
    }

    for (MVT memvt : MVT::vector_valuetypes()) {
      setTruncStoreAction(vt, memvt, Expand);
      setLoadExtAction(ISD::SEXTLOAD, vt, memvt, Expand);
      setLoadExtAction(ISD::ZEXTLOAD, vt, memvt, Expand);
      setLoadExtAction(ISD::EXTLOAD, vt, memvt, Expand);
    }

    LegalizeAction IRRELEVANT = Legal;

    setOperationAction(ISD::LOAD, vt, Expand);
    setOperationAction(ISD::STORE, vt, Expand);

    setOperationAction(ISD::BUILD_VECTOR, vt, Custom);
    setOperationAction(ISD::INSERT_VECTOR_ELT, vt, Custom);
    setOperationAction(ISD::EXTRACT_VECTOR_ELT, vt, Custom);
    setOperationAction(ISD::SCALAR_TO_VECTOR, vt, Expand);
    setOperationAction(ISD::VECTOR_SHUFFLE, vt, Expand);

    setOperationAction(ISD::SETCC, vt, Legal);
    setOperationAction(ISD::SELECT, vt, Expand);
    setOperationAction(ISD::VSELECT, vt, Legal);
    setOperationAction(ISD::SELECT_CC, vt, IRRELEVANT);
  }

}

// [S64fx] Returns the SIMD width of the instruction (0, 1, 2, 4),
// where 0 is for non-extened instructions, 1 for exteneded scalar
// instructions, and 2 and 4 for the SIMD width.  See the TD file for
// the TSFlags bits definition.

static int getS64fxSIMDWidth(const MachineInstr& mi) {
  const MCInstrDesc& d = mi.getDesc();
  int v = ((d.TSFlags >> 2) & 1);
  int simd = ((d.TSFlags >> 0) & 3);
  assert(simd != 3);
  assert(!(simd != 0) || v != 0);
  return ((v == 0) ? 0 : ((simd == 0) ? 1 : (simd * 2)));
}

struct SparcS64fxPrefixer : public MachineFunctionPass {
  TargetMachine &TM;
  const SparcSubtarget *Subtarget;
  static char ID;

  SparcS64fxPrefixer(TargetMachine &tm)
    : MachineFunctionPass(ID), TM(tm) {}

  const char *getPassName() const override {
    return "SPARC64-FX SXAR Prefixer";
  }

  bool runOnMachineFunction(MachineFunction &F) override;

  /*bool runOnMachineBasicBlock(MachineBasicBlock &MBB);*/
};

char SparcS64fxPrefixer::ID = 0;

namespace llvm {

FunctionPass *createS64fxPrefixPass(TargetMachine& tm) {
  return (new SparcS64fxPrefixer(tm));
}

// [S64fx] Returns true if an instruction needs prefixing by SXAR,
// which use the new instructions or the extended registers.

bool hasS64fxXARBits(const MachineInstr& mi, const MachineFunction& mf) {
  const SparcSubtarget* subtarget = &mf.getSubtarget<SparcSubtarget>();
  const MCInstrDesc& d = mi.getDesc();
  if (!subtarget->isACE()) {
    return false;
  } else if (d.isPseudo()) {
    return false;
  } else {
    bool xar;
    xar = false;
    xar |= (getS64fxSIMDWidth(mi) != 0);
    if (!xar) {
      const TargetRegisterInfo* tri = subtarget->getRegisterInfo();
      for (auto i = mi.operands_begin(); i < mi.operands_end(); ++i) {
        const MachineOperand& mo = *i;
        if (mo.isReg()) {
          uint16_t enc = tri->getEncodingValue(mo.getReg());
          assert(enc < 256);
          xar |= (enc >= 32);
          if (xar) {
            break;
          }
        }
      }
    }
    unsigned opc = mi.getOpcode();
    assert(!(opc == SP::CALLrr || opc == SP::CALLri) || !xar);
    return xar;
  }
}

}

// Fixes the instructions by adding the SXAR prefix instruction.
// It also fixes the prologue/epilogue by adding the SSM instruction
// for 4-SIMD.  It assumes the first block as prologue, and the last
// block as epilogue.

bool SparcS64fxPrefixer::runOnMachineFunction(MachineFunction& mf) {
  const SparcSubtarget* subtarget = &mf.getSubtarget<SparcSubtarget>();
  const TargetInstrInfo *tii = subtarget->getInstrInfo();
  if (!subtarget->isACE()) {
    return false;
  }

  bool modified;
  modified = false;

  // Add the SXAR prefix instruction.  Note bundle_iterator does not
  // define +-operator.

  for (MachineBasicBlock& mbb : mf) {
    for (auto i = mbb.begin(); i != mbb.end(); ++i) {
      MachineInstr& mi0 = *i;
      bool xar0 = hasS64fxXARBits(mi0, mf);
      if (xar0) {
        DebugLoc dl = mbb.findDebugLoc(i);
        bool xar2;
        ++i;
        if (i != mbb.end()) {
          MachineInstr& mi1 = *i;
          xar2 = hasS64fxXARBits(mi1, mf);
        } else {
          xar2 = false;
        }
        --i;
        if (xar2 == 0) {
          BuildMI(mbb, i, dl, tii->get(SP::SXAR1));
          mi0.bundleWithPred();
        } else {
          BuildMI(mbb, i, dl, tii->get(SP::SXAR2));
          mi0.bundleWithPred();
          mi0.bundleWithSucc();
        }
        modified = true;
      }
    }
  }

  // Fix the SIMD mode if 4-SIMD.

  int simdw;
  simdw = 0;
  for (MachineBasicBlock& mbb : mf) {
    for (auto i = mbb.begin(); i != mbb.end(); ++i) {
      MachineInstr& mi0 = *i;
      if (simdw == 0) {
        simdw = getS64fxSIMDWidth(mi0);
      } else {
        assert(simdw == getS64fxSIMDWidth(mi0));
      }
    }
  }

  if (simdw == 4) {
    assert(subtarget->isACE2());
    modified = true;

    // Fix the prologue.

    MachineBasicBlock& mbb0 = mf.front();
    MachineInstr& mi0 = mbb0.back();
    DebugLoc dl0 = mbb0.findDebugLoc(mi0);
    BuildMI(mbb0, mi0, dl0, tii->get(SP::SSM)).addImm(1);

    // Fix the epilogue.

    MachineBasicBlock& mbb1 = mf.back();
    MachineInstr& mi1 = mbb0.front();
    DebugLoc dl1 = mbb1.findDebugLoc(mi1);
    BuildMI(mbb1, mi1, dl1, tii->get(SP::SSM)).addImm(0);

    // Fix calls.

    for (MachineBasicBlock& mbb : mf) {
      for (auto i = mbb.begin(); i != mbb.end(); ++i) {
        MachineInstr& mi = *i;
        if (mi.isCall()) {
          // SP::CALL, SP::CALLrr, SP::CALLri, SP::TLS_CALL.
          DebugLoc dl2 = mbb.findDebugLoc(i);
          BuildMI(mbb, mbb.front(), dl2, tii->get(SP::SSM)).addImm(0);
          BuildMI(mbb, mbb.back(), dl2, tii->get(SP::SSM)).addImm(1);
        }
      }
    }
  }

  return modified;
}
