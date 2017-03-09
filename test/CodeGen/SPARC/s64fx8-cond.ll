; RUN: llc -march=sparcv9 -mcpu=s64fx8 -fp-contract=fast < %s | FileCheck %s

;; Tests for S64fx8 (SPARC64 VIIIfx)

declare float @consumef32(float, float, float) nounwind readonly

;;;
;;; Test Conditional Moves
;;;

; CHECK-LABEL: @conditional_moves0:
; CHECK: fcmplted %f4, %f6, %f4
; CHECK: retl
; CHECK: fselmovd %f0, %f2, %f4, %f0

define double @conditional_moves0(double %a, double %b, double %c, double %d) {
  %cc0 = fcmp fast olt double %c, %d
  %v0 = select i1 %cc0, double %a, double %b
  ret double %v0
}

; CHECK-LABEL: @conditional_moves1:
; CHECK: fcmpltes %f4, %f6, %f4
; CHECK: fselmovs %f0, %f2, %f4, %f0
; CHECK: retl

define float @conditional_moves1(float %a, float %b, float %c, float %d) {
  %cc0 = fcmp fast olt float %c, %d
  %v0 = select i1 %cc0, float %a, float %b
  ret float %v0
}

; CHECK-LABEL: @conditional_moves2:
; CHECK: fcmplted,s %f4, %f6, %f4
; CHECK: fselmovd,s %f0, %f2, %f4, %f0
; CHECK: retl

define <2 x double> @conditional_moves2(<2 x double> %a, <2 x double> %b, <2 x double> %c, <2 x double> %d) {
  %cc0 = fcmp fast olt <2 x double> %c, %d
  %v0 = select <2 x i1> %cc0, <2 x double> %a, <2 x double> %b
  ret <2 x double> %v0
}

; CHECK-LABEL: @conditional_moves3:
; CHECK: fcmpltes,s %f4, %f6, %f4
; CHECK: fselmovs,s %f0, %f2, %f4, %f0
; CHECK: retl

define <2 x float> @conditional_moves3(<2 x float> %a, <2 x float> %b, <2 x float> %c, <2 x float> %d) {
  %cc0 = fcmp fast olt <2 x float> %c, %d
  %v0 = select <2 x i1> %cc0, <2 x float> %a, <2 x float> %b
  ret <2 x float> %v0
}

;;;
;;; Conditional Moves with Integer Condtions
;;;

define double @select_by_integer0(i8 %v0, i8 %v1, double %v2, double %v3) {
  %icmp = icmp ne i8 %v1, %v0
  %v4 = select i1 %icmp, double %v3, double %v2
  ret double %v4
}

define float @select_by_integer1(i8 %v0, i8 %v1, float %v2, float %v3) {
  %icmp = icmp ne i8 %v1, %v0
  %v4 = select i1 %icmp, float %v3, float %v2
  ret float %v4
}
