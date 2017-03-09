//===-- SparcSchedS64fx.td - Describe the Sparc Itineries ----*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

/*AHO*/ //def S64fxModel : ProcessorModel {

def S64fxModel : SchedMachineModel {
  let MicroOpBufferSize = 0;
  let IssueWidth = 2;
  let LoadLatency = 3;
  let MispredictPenalty = 9;
  let CompleteModel = 1;
}

// Define each kind of processor resource and number available.

// Modeling each pipeline as a ProcResource using the BufferSize = 0 since
// Cortex-S64fx is in-order.

def S64fxUnitALU    : ProcResource<2> { let BufferSize = 0; }
def S64fxUnitMAC    : ProcResource<1> { let BufferSize = 0; }
def S64fxUnitDiv    : ProcResource<1> { let BufferSize = 0; }
def S64fxUnitLdSt   : ProcResource<1> { let BufferSize = 0; }
def S64fxUnitB      : ProcResource<1> { let BufferSize = 0; }
def S64fxUnitFPALU  : ProcResource<1> { let BufferSize = 0; }
def S64fxUnitFPMDS  : ProcResource<1> { let BufferSize = 0; }

// Subtarget-specific SchedWrite types which both map the ProcResources and
// set the latency.

def M1UnitA  : ProcResource<2>;
def M1UnitC  : ProcResource<1>;

//let SchedModel = S64fxModel in {
//  def M1UnitALU  : ProcResGroup<[M1UnitA, M1UnitC]>;
//}
