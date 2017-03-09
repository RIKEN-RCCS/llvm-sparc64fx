; RUN: llc -march=sparcv9 -mcpu=s64fx8 -fp-contract=fast < %s | FileCheck %s

;; Tests for S64fx8 (SPARC64 VIIIfx)

declare float @consumef32(float, float, float) nounwind readonly

;;;
;;; Test Single-Float Arguments
;;;

; CHECK-LABEL: f32iargs:
; CHECK: fmovs %f5, %f4
; CHECK: fmovs %f3, %f2
; CHECK: fmovs %f1, %f0
; CHECK: sxar1
; CHECK: fmadds %f2, %f0, %f4, %f0
; CHECK: retl
; CHECK: nop

define float @f32iargs(float %i0, float %i1, float %i2) nounwind readnone {
  %mul = fmul fast float %i1, %i0
  %add = fadd fast float %mul, %i2
  ret float %add
}

; CHECK-LABEL: f32oargs:
; CHECK: fmovs %f5, %f4
; CHECK: fmovs %f3, %f2
; CHECK: fmovs %f1, %f0
; CHECK: sxar2
; CHECK: fmuls %f2, %f0, %f0
; CHECK: fadds %f0, %f2, %f2
; CHECK: sxar1
; CHECK: fadds %f2, %f4, %f4
; CHECK: fmovs %f0, %f1
; CHECK: fmovs %f2, %f3
; CHECK: fmovs %f4, %f5
; CHECK: call consumef32
; CHECK: nop

define float @f32oargs(float %i0, float %i1, float %i2) nounwind readnone {
  %v0 = fmul fast float %i1, %i0
  %v1 = fadd fast float %v0, %i1
  %v2 = fadd fast float %v1, %i2
  %v3 = call float @consumef32(float %v0, float %v1, float %v2)
  %v4 = fadd fast float %v3, %v3
  ret float %v4
}
