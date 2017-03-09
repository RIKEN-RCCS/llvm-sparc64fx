//===-- SparcTargetTransformInfo.h - Sparc specific TTI pass ----------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

// [S64fx] This file is new for S64fx.

#include "Sparc.h"
#include "SparcTargetMachine.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/CodeGen/BasicTTIImpl.h"
#include "llvm/Target/TargetLowering.h"

#define DEBUG_TYPE "sparctti"

namespace llvm {

struct SparcTTIImpl : public BasicTTIImplBase<SparcTTIImpl> {
  typedef BasicTTIImplBase<SparcTTIImpl> BaseT;
  typedef TargetTransformInfo TTI;
  friend BaseT;

  const SparcSubtarget *ST;
  const SparcTargetLowering *TLI;

  const SparcSubtarget *getST() const {return ST;}
  const SparcTargetLowering *getTLI() const {return TLI;}

  explicit SparcTTIImpl(const SparcTargetMachine *TM, const Function &F)
    : BaseT(TM, F.getParent()->getDataLayout()), ST(TM->getSubtargetImpl(F)),
      TLI(ST->getTargetLowering()) {}

  SparcTTIImpl(const SparcTTIImpl &Arg)
    : BaseT(static_cast<const BaseT &>(Arg)), ST(Arg.ST), TLI(Arg.TLI) {}

  SparcTTIImpl(SparcTTIImpl &&Arg)
    : BaseT(std::move(static_cast<BaseT &>(Arg))), ST(std::move(Arg.ST)),
      TLI(std::move(Arg.TLI)) {}

  // Scalar TTI Implementations

  //int getIntImmCost(const APInt &Imm, Type *Ty);
  //int getIntImmCost(unsigned Opcode, unsigned Idx, const APInt &Imm,
  //Type *Ty);
  //int getIntImmCost(Intrinsic::ID IID, unsigned Idx, const APInt &Imm,
  //Type *Ty);

  //TTI::PopcntSupportKind getPopcntSupport(unsigned TyWidth);
  //void getUnrollingPreferences(Loop *L, TTI::UnrollingPreferences &UP);

  // Vector TTI Implementations

  unsigned getNumberOfRegisters(bool Vector) const;
  unsigned getRegisterBitWidth(bool Vector) const;
  unsigned getMaxInterleaveFactor(unsigned VF) const;
  int getArithmeticInstrCost(
    unsigned Opcode, Type *Ty,
    TTI::OperandValueKind Opd1Info = TTI::OK_AnyValue,
    TTI::OperandValueKind Opd2Info = TTI::OK_AnyValue,
    TTI::OperandValueProperties Opd1PropInfo = TTI::OP_None,
    TTI::OperandValueProperties Opd2PropInfo = TTI::OP_None);
  int getVectorInstrCost(unsigned Opcode, Type *Val, unsigned Index) const;
  //int getShuffleCost(TTI::ShuffleKind Kind, Type *Tp, int Index,
  //Type *SubTp);
  //int getCastInstrCost(unsigned Opcode, Type *Dst, Type *Src);
  //int getCmpSelInstrCost(unsigned Opcode, Type *ValTy, Type *CondTy);
};
}
