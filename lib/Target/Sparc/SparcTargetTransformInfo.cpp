//===-- SparcTargetTransformInfo.cpp - Sparc specific TTI pass ----------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "Sparc.h"
#include "SparcTargetMachine.h"
#include "SparcTargetTransformInfo.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/CodeGen/BasicTTIImpl.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/Support/Debug.h"
#include "llvm/Target/CostTable.h"
#include "llvm/Target/TargetLowering.h"

#define DEBUG_TYPE "sparctti"

namespace llvm {

// [S64fx] It returns 256 for the scalar registers, although S64fx has
// 256 for floats but 64 for integers.

unsigned SparcTTIImpl::getNumberOfRegisters(bool Vector) const {
  assert(ST != 0);
  if (Vector) {
    if (ST->isACE()) {
      return 128;
    } else {
      return 0;
    }
  } else {
    if (ST->isACE()) {
      return 256;
    } else {
      return 32;
    }
  }
}

unsigned SparcTTIImpl::getRegisterBitWidth(bool Vector) const {
  assert(ST != 0);
  if (Vector) {
    if (ST->isACE2()) {
      return 256;
    } else if (ST->isACE1()) {
      return 128;
    } else if (ST->isV9()) {
      return 0;
    } else {
      return 0;
    }
  } else {
    if (ST->isV9()) {
      return 64;
    } else {
      return 32;
    }
  }
}

// [S64fx] It returns a larger number for S64fx for its many
// registers for preferring unrolling.

unsigned SparcTTIImpl::getMaxInterleaveFactor(unsigned VF) const {
  assert(ST != 0);
  if (ST->isACE()) {
    return 8;
  } else if (VF == 1) {
    return 1;
  } else {
    return 2;
  }
}

int SparcTTIImpl::
getArithmeticInstrCost(
                       unsigned Opcode, Type *Ty,
                       TTI::OperandValueKind Opd1Info,
                       TTI::OperandValueKind Opd2Info,
                       TTI::OperandValueProperties Opd1PropInfo,
                       TTI::OperandValueProperties Opd2PropInfo) {
  /*AHO*/
  return 10;
}

int SparcTTIImpl::
getVectorInstrCost(unsigned Opcode, Type *Val, unsigned Index) const {
  /*AHO*/
  return 0;
}

//int getShuffleCost(TTI::ShuffleKind Kind, Type *Tp, int Index,
//Type *SubTp);
//int getCastInstrCost(unsigned Opcode, Type *Dst, Type *Src);
//int getCmpSelInstrCost(unsigned Opcode, Type *ValTy, Type *CondTy);
}
