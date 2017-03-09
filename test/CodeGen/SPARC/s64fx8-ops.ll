; RUN: llc < %s -march=sparcv9 -mcpu=s64fx8 -fp-contract=fast | FileCheck %s

;; Tests for S64fx8 (SPARC64 VIIIfx)

@gv2f64 = common global [130 x <2 x double>] zeroinitializer, align 8
@gv2f32 = common global [130 x <2 x float>] zeroinitializer, align 4

declare double @llvm.sqrt.f64(double) nounwind readonly
declare float @llvm.sqrt.f32(float) nounwind readonly
declare <2 x double> @consume_v2f64(<2 x double> %i0) nounwind readnone
declare <2 x float> @consume_v2f32(<2 x float> %i0) nounwind readnone

;;;
;;; Test Scalar Constant Generation (0.0)
;;;

; CHECK-LABEL: scalar_constants:
; CHECK: fzero %f0
; CHECK: fzeros %f2
; CHECK: retl

define double @scalar_constants() nounwind readnone {
  %v0 = call double @llvm.sqrt.f64(double 0.0)
  %v1 = fadd fast double %v0, 1.0

  %v2 = call float @llvm.sqrt.f32(float 0.0)
  %v3 = fadd fast float %v2, 1.0

  %v4 = fpext float %v3 to double
  %v5 = fadd fast double %v1, %v4
  ret double %v5
}

; CHECK-LABEL: scalar_constants_others:
; CHECK: ldd [%o0+%l44(.LCPI0_0)], %f4
; CHECK: ld [%o0+%l44(.LCPI0_1)], %f6
; CHECK: retl

define double @scalar_constants_others(double %i0, float %i1) nounwind readnone {
  %v0 = fadd fast double %i0, 2.0
  %v1 = fadd fast float %i1, 3.0
  %v2 = fpext float %v1 to double
  %v3 = fadd fast double %v0, %v2
  ret double %v3
}

;;;
;;; Test Scalar FMA Generation
;;;

; CHECK-LABEL: scalar_fma:
; CHECK: fmaddd %f0, %f2, %f4, %f0
; CHECK: fmadds %f6, %f8, %f10, %f2
; CHECK: retl

define double @scalar_fma(double %d0, double %d1, double %d2, float %f0, float %f1, float %f2) nounwind readnone {
  %v0 = fmul fast double %d0, %d1
  %v1 = fadd fast double %v0, %d2
  %v2 = fmul fast float %f0, %f1
  %v3 = fadd fast float %v2, %f2
  %v4 = fpext float %v3 to double
  %v5 = fadd fast double %v1, %v4
  ret double %v5
}

;;;
;;; Test Build Vector (FP/DP)
;;;

; CHECK-LABEL: build_vector_constants:
; CHECK: fzero,s %f0
; CHECK: fzeros,s %f0
; CHECK: ldd [%i0+%l44(.LCPI0_0)], %f0
; CHECK: fmovd %f0, %f256
; CHECK: ld [%i0+%l44(.LCPI0_1)], %f0
; CHECK: fmovs %f0, %f256
; CHECK: ret

define <2 x double> @build_vector_constants(<2 x double> %i0, <2 x float> %i1) nounwind readnone {
  %v0 = call <2 x double> @consume_v2f64(<2 x double> <double 0.0, double 0.0>)
  %v1 = call <2 x float> @consume_v2f32(<2 x float> <float 0.0, float 0.0>)
  %v2 = call <2 x double> @consume_v2f64(<2 x double> <double 2.0, double 2.0>)
  %v3 = call <2 x float> @consume_v2f32(<2 x float> <float 2.0, float 2.0>)
  ret <2 x double> %v0
}

;;;
;;; Test Vector Ops Generation
;;;

; CHECK-LABEL: vector_ops:
; CHECK: faddd,s
; CHECK: fsubd,s
; CHECK: fmuld,s
; CHECK: fdivd
; CHECK: fdivd
; CHECK: fadds,s
; CHECK: fsubs,s
; CHECK: fmuls,s
; CHECK: fdivs
; CHECK: fdivs
; CHECK: ret

define void @vector_ops(<2 x double> %d0, <2 x double> %d1, <2 x float> %f0, <2 x float> %f1) nounwind readnone {
  %a0 = fadd fast <2 x double> %d0, %d1
  %a1 = fsub fast <2 x double> <double 0.0, double 0.0>, %a0
  %a2 = fsub fast <2 x double> %d0, %d1
  %a3 = fmul fast <2 x double> %a1, %a2
  %a4 = fdiv fast <2 x double> %a3, %d0

  %b0 = fadd fast <2 x float> %f0, %f1
  %b1 = fsub fast <2 x float> <float 0.0, float 0.0>, %b0
  %b2 = fsub fast <2 x float> %f0, %f1
  %b3 = fmul fast <2 x float> %b1, %b2
  %b4 = fdiv fast <2 x float> %b3, %f0

  %v8 = call <2 x double> @consume_v2f64(<2 x double> %a4)
  %v9 = call <2 x float> @consume_v2f32(<2 x float> %b4)
  ret void
}

; CHECK-LABEL: vector_fma:
; CHECK: fmaddd,s %f0, %f2, %f4, %f0 /*v2*/
; CHECK: fmadds,s %f6, %f8, %f10, %f2 /*v2*/

define void @vector_fma(<2 x double> %d0, <2 x double> %d1, <2 x double> %d2, <2 x float> %f0, <2 x float> %f1, <2 x float> %f2) nounwind readnone {
  %v0 = fmul fast <2 x double> %d0, %d1
  %v1 = fadd fast <2 x double> %v0, %d2
  %v2 = fmul fast <2 x float> %f0, %f1
  %v3 = fadd fast <2 x float> %v2, %f2
  %v4 = call <2 x double> @consume_v2f64(<2 x double> %v1)
  %v5 = call <2 x float> @consume_v2f32(<2 x float> %v3)
  ret void
}

;;;
;;; Test fcmp Generation
;;;

define double @scalar_cmp(double %a, double %b, double %c) nounwind readnone {
  %cc = fcmp ogt double %b, 0.0
  %v0 = fadd double %b, %c
  %v1 = select i1 %cc, double %v0, double %a
  ret double %v1
}

;;;
;;; Test Unaligned Load/Store Generation
;;;

define void @unaligned_load() nounwind readnone {
  %v0 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 0), align 8
  %v1 = call <2 x double> @consume_v2f64(<2 x double> %v0)
  store volatile <2 x double> %v1, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 0), align 8

  %v2 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 0), align 4
  %v3 = call <2 x float> @consume_v2f32(<2 x float> %v2)
  store volatile <2 x float> %v3, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 0), align 4

  ret void
}
