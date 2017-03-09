//===-- SparcMCCodeEmitter.cpp - Convert Sparc code to machine code -------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements the SparcMCCodeEmitter class.
//
//===----------------------------------------------------------------------===//

#include "SparcMCExpr.h"
#include "MCTargetDesc/SparcFixupKinds.h"
#include "SparcMCTargetDesc.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/MC/MCCodeEmitter.h"
#include "llvm/MC/MCContext.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/Support/EndianStream.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

#define DEBUG_TYPE "mccodeemitter"

STATISTIC(MCNumEmitted, "Number of MC instructions emitted");

namespace {
class SparcMCCodeEmitter : public MCCodeEmitter {
  SparcMCCodeEmitter(const SparcMCCodeEmitter &) = delete;
  void operator=(const SparcMCCodeEmitter &) = delete;
  MCContext &Ctx;

public:
  SparcMCCodeEmitter(MCContext &ctx): Ctx(ctx) {}

  ~SparcMCCodeEmitter() override {}

  void encodeInstruction(const MCInst &MI, raw_ostream &OS,
                         SmallVectorImpl<MCFixup> &Fixups,
                         const MCSubtargetInfo &STI) const override;

  // getBinaryCodeForInstr - TableGen'erated function for getting the
  // binary encoding for an instruction.
  uint64_t getBinaryCodeForInstr(const MCInst &MI,
                                 SmallVectorImpl<MCFixup> &Fixups,
                                 const MCSubtargetInfo &STI) const;

  /// getMachineOpValue - Return binary encoding of operand. If the machine
  /// operand requires relocation, record the relocation and return zero.
  unsigned getMachineOpValue(const MCInst &MI, const MCOperand &MO,
                             SmallVectorImpl<MCFixup> &Fixups,
                             const MCSubtargetInfo &STI) const;

  unsigned getCallTargetOpValue(const MCInst &MI, unsigned OpNo,
                             SmallVectorImpl<MCFixup> &Fixups,
                             const MCSubtargetInfo &STI) const;
  unsigned getBranchTargetOpValue(const MCInst &MI, unsigned OpNo,
                             SmallVectorImpl<MCFixup> &Fixups,
                             const MCSubtargetInfo &STI) const;
  unsigned getBranchPredTargetOpValue(const MCInst &MI, unsigned OpNo,
                                      SmallVectorImpl<MCFixup> &Fixups,
                                      const MCSubtargetInfo &STI) const;
  unsigned getBranchOnRegTargetOpValue(const MCInst &MI, unsigned OpNo,
                                       SmallVectorImpl<MCFixup> &Fixups,
                                       const MCSubtargetInfo &STI) const;
  /*[S64fx]*/
  unsigned encodeSXARInstr(const MCInst& mi,
                           const MCSubtargetInfo& sti) const;

};
} // end anonymous namespace

MCCodeEmitter *llvm::createSparcMCCodeEmitter(const MCInstrInfo &MCII,
                                              const MCRegisterInfo &MRI,
                                              MCContext &Ctx) {
  return new SparcMCCodeEmitter(Ctx);
}

// [S64fx] Returns the encoding of the SXAR1/SXAR2 instructions.  It
// takes the fields from the real instructions, which are embedded in
// the passed SXAR instruction.  The bit encoding of SXAR1/SXAR2 are:
// op{31-30} sxar1/2{29} f_simd{28} f_urd{27-25} op2{24-22}
// f_urs1{21-19} f_urs2{18-16} f_urs3{15-13} s_simd{12} s_urd{11-9}
// s_urs1{8-6} s_urs2{5-3} s_urs3{2-0}.

unsigned SparcMCCodeEmitter::
encodeSXARInstr(const MCInst& mi, const MCSubtargetInfo& sti) const {
  unsigned bits;
  bits = ((0U << 30) | (7U << 22));
  bits |= (((mi.getOpcode() == SP::SXAR1) ? 0 : 1) << 29);
  int ninstructions = ((mi.getOpcode() == SP::SXAR1) ? 1 : 2);
  assert(mi.getNumOperands() == (unsigned)(ninstructions * (1 + SPARC_S64FX_SXAR_EMBEDDED_OPERANDS)));
  for (int i = 0; i < ninstructions; i++) {
    MCInst mci0;
    // Reconstruct the real instruction.
    for (int j = 0; j < SPARC_S64FX_SXAR_EMBEDDED_OPERANDS; j++) {
      const MCOperand &mo = mi.getOperand((5 * i) + j);
      if (j == 0) {
        mci0.setOpcode((unsigned)mo.getImm());
      } else {
        if (mo.isValid()) {
          mci0.addOperand(mo);
        }
      }
    }
    SmallVector<MCFixup, 4> fixups;
    uint64_t mibits = getBinaryCodeForInstr(mci0, fixups, sti);
    unsigned hibits = (unsigned)(mibits >> 32);
    unsigned simd = (((hibits >> 12) & 3) == 0 ? 0 : 1);
    unsigned urd = (hibits >> 9) & 7;
    unsigned urs1 = (hibits >> 6) & 7;
    unsigned urs2 = (hibits >> 3) & 7;
    unsigned urs3 = (hibits >> 0) & 7;
    if (i == 0) {
      bits |= (simd << 28);
      bits |= (urd << 25);
      bits |= (urs1 << 19);
      bits |= (urs2 << 16);
      bits |= (urs3 << 13);
    } else {
      bits |= (simd << 12);
      bits |= (urd << 9);
      bits |= (urs1 << 6);
      bits |= (urs2 << 3);
      bits |= (urs3 << 0);
    }
  }
  return bits;
}

void SparcMCCodeEmitter::encodeInstruction(const MCInst &MI, raw_ostream &OS,
                                           SmallVectorImpl<MCFixup> &Fixups,
                                           const MCSubtargetInfo &STI) const {
  unsigned Bits;
  if (MI.getOpcode() != SP::SXAR1 && MI.getOpcode() != SP::SXAR2) {
    Bits = getBinaryCodeForInstr(MI, Fixups, STI);
  } else {
    Bits = encodeSXARInstr(MI, STI);
  }
  if (Ctx.getAsmInfo()->isLittleEndian()) {
    // Output the bits in little-endian byte order.
    support::endian::Writer<support::little>(OS).write<uint32_t>(Bits);
  } else {
    // Output the bits in big-endian byte order.
    support::endian::Writer<support::big>(OS).write<uint32_t>(Bits);
  }
  unsigned tlsOpNo = 0;
  switch (MI.getOpcode()) {
  default: break;
  case SP::TLS_CALL:   tlsOpNo = 1; break;
  case SP::TLS_ADDrr:
  case SP::TLS_ADDXrr:
  case SP::TLS_LDrr:
  case SP::TLS_LDXrr:  tlsOpNo = 3; break;
  }
  if (tlsOpNo != 0) {
    const MCOperand &MO = MI.getOperand(tlsOpNo);
    uint64_t op = getMachineOpValue(MI, MO, Fixups, STI);
    assert(op == 0 && "Unexpected operand value!");
    (void)op; // suppress warning.
  }

  ++MCNumEmitted;  // Keep track of the # of mi's emitted.
}


unsigned SparcMCCodeEmitter::
getMachineOpValue(const MCInst &MI, const MCOperand &MO,
                  SmallVectorImpl<MCFixup> &Fixups,
                  const MCSubtargetInfo &STI) const {

  if (MO.isReg())
    return Ctx.getRegisterInfo()->getEncodingValue(MO.getReg());

  if (MO.isImm())
    return MO.getImm();

  assert(MO.isExpr());
  const MCExpr *Expr = MO.getExpr();
  if (const SparcMCExpr *SExpr = dyn_cast<SparcMCExpr>(Expr)) {
    MCFixupKind Kind = (MCFixupKind)SExpr->getFixupKind();
    Fixups.push_back(MCFixup::create(0, Expr, Kind));
    return 0;
  }

  int64_t Res;
  if (Expr->evaluateAsAbsolute(Res))
    return Res;

  llvm_unreachable("Unhandled expression!");
  return 0;
}

unsigned SparcMCCodeEmitter::
getCallTargetOpValue(const MCInst &MI, unsigned OpNo,
                     SmallVectorImpl<MCFixup> &Fixups,
                     const MCSubtargetInfo &STI) const {
  const MCOperand &MO = MI.getOperand(OpNo);
  if (MO.isReg() || MO.isImm())
    return getMachineOpValue(MI, MO, Fixups, STI);

  if (MI.getOpcode() == SP::TLS_CALL) {
    // No fixups for __tls_get_addr. Will emit for fixups for tls_symbol in
    // encodeInstruction.
#ifndef NDEBUG
    // Verify that the callee is actually __tls_get_addr.
    const SparcMCExpr *SExpr = dyn_cast<SparcMCExpr>(MO.getExpr());
    assert(SExpr && SExpr->getSubExpr()->getKind() == MCExpr::SymbolRef &&
           "Unexpected expression in TLS_CALL");
    const MCSymbolRefExpr *SymExpr = cast<MCSymbolRefExpr>(SExpr->getSubExpr());
    assert(SymExpr->getSymbol().getName() == "__tls_get_addr" &&
           "Unexpected function for TLS_CALL");
#endif
    return 0;
  }

  MCFixupKind fixupKind = (MCFixupKind)Sparc::fixup_sparc_call30;

  if (const SparcMCExpr *SExpr = dyn_cast<SparcMCExpr>(MO.getExpr())) {
    if (SExpr->getKind() == SparcMCExpr::VK_Sparc_WPLT30)
      fixupKind = (MCFixupKind)Sparc::fixup_sparc_wplt30;
  }

  Fixups.push_back(MCFixup::create(0, MO.getExpr(), fixupKind));

  return 0;
}

unsigned SparcMCCodeEmitter::
getBranchTargetOpValue(const MCInst &MI, unsigned OpNo,
                  SmallVectorImpl<MCFixup> &Fixups,
                  const MCSubtargetInfo &STI) const {
  const MCOperand &MO = MI.getOperand(OpNo);
  if (MO.isReg() || MO.isImm())
    return getMachineOpValue(MI, MO, Fixups, STI);

  Fixups.push_back(MCFixup::create(0, MO.getExpr(),
                                   (MCFixupKind)Sparc::fixup_sparc_br22));
  return 0;
}

unsigned SparcMCCodeEmitter::
getBranchPredTargetOpValue(const MCInst &MI, unsigned OpNo,
                           SmallVectorImpl<MCFixup> &Fixups,
                           const MCSubtargetInfo &STI) const {
  const MCOperand &MO = MI.getOperand(OpNo);
  if (MO.isReg() || MO.isImm())
    return getMachineOpValue(MI, MO, Fixups, STI);

  Fixups.push_back(MCFixup::create(0, MO.getExpr(),
                                   (MCFixupKind)Sparc::fixup_sparc_br19));
  return 0;
}
unsigned SparcMCCodeEmitter::
getBranchOnRegTargetOpValue(const MCInst &MI, unsigned OpNo,
                           SmallVectorImpl<MCFixup> &Fixups,
                           const MCSubtargetInfo &STI) const {
  const MCOperand &MO = MI.getOperand(OpNo);
  if (MO.isReg() || MO.isImm())
    return getMachineOpValue(MI, MO, Fixups, STI);

  Fixups.push_back(MCFixup::create(0, MO.getExpr(),
                                   (MCFixupKind)Sparc::fixup_sparc_br16_2));
  Fixups.push_back(MCFixup::create(0, MO.getExpr(),
                                   (MCFixupKind)Sparc::fixup_sparc_br16_14));

  return 0;
}



#include "SparcGenMCCodeEmitter.inc"
