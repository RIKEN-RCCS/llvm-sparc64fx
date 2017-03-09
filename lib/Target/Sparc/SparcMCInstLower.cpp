//===-- SparcMCInstLower.cpp - Convert Sparc MachineInstr to MCInst -------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains code to lower Sparc MachineInstrs to their corresponding
// MCInst records.
//
//===----------------------------------------------------------------------===//

#include "Sparc.h"
#include "MCTargetDesc/SparcMCExpr.h"
#include "llvm/CodeGen/AsmPrinter.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineOperand.h"
#include "llvm/IR/Mangler.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCContext.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCInst.h"

using namespace llvm;


static MCOperand LowerSymbolOperand(const MachineInstr *MI,
                                    const MachineOperand &MO,
                                    AsmPrinter &AP) {

  SparcMCExpr::VariantKind Kind =
    (SparcMCExpr::VariantKind)MO.getTargetFlags();
  const MCSymbol *Symbol = nullptr;

  switch(MO.getType()) {
  default: llvm_unreachable("Unknown type in LowerSymbolOperand");
  case MachineOperand::MO_MachineBasicBlock:
    Symbol = MO.getMBB()->getSymbol();
    break;

  case MachineOperand::MO_GlobalAddress:
    Symbol = AP.getSymbol(MO.getGlobal());
    break;

  case MachineOperand::MO_BlockAddress:
    Symbol = AP.GetBlockAddressSymbol(MO.getBlockAddress());
    break;

  case MachineOperand::MO_ExternalSymbol:
    Symbol = AP.GetExternalSymbolSymbol(MO.getSymbolName());
    break;

  case MachineOperand::MO_ConstantPoolIndex:
    Symbol = AP.GetCPISymbol(MO.getIndex());
    break;
  }

  const MCSymbolRefExpr *MCSym = MCSymbolRefExpr::create(Symbol,
                                                         AP.OutContext);
  const SparcMCExpr *expr = SparcMCExpr::create(Kind, MCSym,
                                                AP.OutContext);
  return MCOperand::createExpr(expr);
}

static MCOperand LowerOperand(const MachineInstr *MI,
                              const MachineOperand &MO,
                              AsmPrinter &AP) {
  switch(MO.getType()) {
  default: llvm_unreachable("unknown operand type"); break;
  case MachineOperand::MO_Register:
    if (MO.isImplicit())
      break;
    return MCOperand::createReg(MO.getReg());

  case MachineOperand::MO_Immediate:
    return MCOperand::createImm(MO.getImm());

  case MachineOperand::MO_MachineBasicBlock:
  case MachineOperand::MO_GlobalAddress:
  case MachineOperand::MO_BlockAddress:
  case MachineOperand::MO_ExternalSymbol:
  case MachineOperand::MO_ConstantPoolIndex:
    return LowerSymbolOperand(MI, MO, AP);

  case MachineOperand::MO_RegisterMask:   break;

  }
  return MCOperand();
}

// [S64fx] Lowers S64fx instructions, which are preceeded by
// SXAR1/SXAR2 prefixes.  It embeds the successor instructions as
// arguments in SXAR1/SXAR2 , because encoding needs them.  It adds an
// opcode as an immediate value and four operands (fills with invalid
// operands when less than four).  Thus, it assumes the number of the
// operands of the real instructions is four or less.

static void lowerS64fxMachineInstr(const MachineInstr* mi, MCInst& outmi,
                                   AsmPrinter& ap) {
  assert((mi->getOpcode() == SP::SXAR1 || mi->getOpcode() == SP::SXAR2)
         && mi->isBundled());
  outmi.setOpcode(mi->getOpcode());
  auto s = mi->getIterator();
  auto e = mi->getParent()->instr_end();
  int ninstructions = ((mi->getOpcode() == SP::SXAR1) ? 1 : 2);
  // Embed the real instructions as an SXAR operand.
  for (int i = 0; i < ninstructions; i++) {
    assert(s != e);
    ++s;
    const MachineInstr& mi0 = (*s);
    assert(mi0.getOpcode() != SP::SXAR1 && mi0.getOpcode() != SP::SXAR2);
    assert(mi0.isBundledWithPred());
    MCInst mcinst0;
    LowerSparcMachineInstrToMCInst(&mi0, mcinst0, ap);
    MCOperand opc = MCOperand::createImm(mcinst0.getOpcode());
    outmi.addOperand(opc);
    assert(mcinst0.getNumOperands() <= SPARC_S64FX_SXAR_EMBEDDED_OPERANDS);
    for (unsigned i = 0; i < SPARC_S64FX_SXAR_EMBEDDED_OPERANDS; ++i) {
      if (i < mcinst0.getNumOperands()) {
        outmi.addOperand(mcinst0.getOperand(i));
      } else {
        // Add invalid operands up to four slots.
        outmi.addOperand(MCOperand());
      }
    }
    assert(!(i == (ninstructions - 1)) || !mi0.isBundledWithSucc());
  }
}

void llvm::LowerSparcMachineInstrToMCInst(const MachineInstr *MI,
                                          MCInst &OutMI,
                                          AsmPrinter &AP)
{
  // [S64fx] Switch to special handling of SXAR instructions.
  if (MI->getOpcode() == SP::SXAR1 || MI->getOpcode() == SP::SXAR2) {
    lowerS64fxMachineInstr(MI, OutMI, AP);
  } else {
  OutMI.setOpcode(MI->getOpcode());

  for (unsigned i = 0, e = MI->getNumOperands(); i != e; ++i) {
    const MachineOperand &MO = MI->getOperand(i);
    MCOperand MCOp = LowerOperand(MI, MO, AP);

    if (MCOp.isValid())
      OutMI.addOperand(MCOp);
  }
  }
}
