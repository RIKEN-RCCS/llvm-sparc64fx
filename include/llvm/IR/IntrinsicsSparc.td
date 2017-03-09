//==- IntrinsicsSparc.td - Sparc intrinsics                 -*- tablegen -*-==//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines SPARC specific intrinsics.
//
//===----------------------------------------------------------------------===//

// [S64fx] Intrinsics of Fujitsu SPARC64fx.  Fujitsu's instrisics
// names are prefixed with "_fjsp_" and suffixed with datatypes like
// "_v2r8".

let TargetPrefix = "sparc" in {  // All intrinsics start with "llvm.sparc.".

  def int_sparc_rcpa_f32 :
    Intrinsic<[llvm_float_ty], [llvm_float_ty], [IntrNoMem]>;
  def int_sparc_rcpa_f64 :
    Intrinsic<[llvm_double_ty], [llvm_double_ty], [IntrNoMem]>;
  def int_sparc_rcpa_v2f32 :
    Intrinsic<[llvm_v2f32_ty], [llvm_v2f32_ty], [IntrNoMem]>;
  def int_sparc_rcpa_v2f64 :
    Intrinsic<[llvm_v2f64_ty], [llvm_v2f64_ty], [IntrNoMem]>;
  def int_sparc_rcpa_v4f32 :
    Intrinsic<[llvm_v4f32_ty], [llvm_v4f32_ty], [IntrNoMem]>;
  def int_sparc_rcpa_v4f64 :
    Intrinsic<[llvm_v4f64_ty], [llvm_v4f64_ty], [IntrNoMem]>;

  def int_sparc_rsqrta_f32 :
    Intrinsic<[llvm_float_ty], [llvm_float_ty], [IntrNoMem]>;
  def int_sparc_rsqrta_f64 :
    Intrinsic<[llvm_double_ty], [llvm_double_ty], [IntrNoMem]>;
  def int_sparc_rsqrta_v2f32 :
    Intrinsic<[llvm_v2f32_ty], [llvm_v2f32_ty], [IntrNoMem]>;
  def int_sparc_rsqrta_v2f64 :
    Intrinsic<[llvm_v2f64_ty], [llvm_v2f64_ty], [IntrNoMem]>;
  def int_sparc_rsqrta_v4f32 :
    Intrinsic<[llvm_v4f32_ty], [llvm_v4f32_ty], [IntrNoMem]>;
  def int_sparc_rsqrta_v4f64 :
    Intrinsic<[llvm_v4f64_ty], [llvm_v4f64_ty], [IntrNoMem]>;

  def int_sparc_load_v2r8 :
    Intrinsic<[llvm_v2f64_ty], [llvm_ptr_ty], [IntrReadMem]>;
  def int_sparc_loadh_v2r8 :
    Intrinsic<[llvm_v2f64_ty], [llvm_v2f64_ty, llvm_ptr_ty], [IntrReadMem]>;
  def int_sparc_loadl_v2r8 :
    Intrinsic<[llvm_v2f64_ty], [llvm_v2f64_ty, llvm_ptr_ty], [IntrReadMem]>;
  def int_sparc_store_v2r8 :
    Intrinsic<[], [llvm_ptr_ty], []>;
  def int_sparc_storeh_v2r8 :
    Intrinsic<[], [llvm_ptr_ty, llvm_v2f64_ty], []>;
  def int_sparc_storel_v2r8 :
    Intrinsic<[], [llvm_ptr_ty, llvm_v2f64_ty], []>;
}
