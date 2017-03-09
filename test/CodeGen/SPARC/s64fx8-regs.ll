; RUN: llc < %s -march=sparcv9 -mcpu=s64fx8 | FileCheck %s

;; Tests for S64fx8 (SPARC64 VIIIfx)

@gi32 = common global [64 x i32] zeroinitializer, align 16
@gf64 = common global [260 x double] zeroinitializer, align 16
@gf32 = common global [260 x float] zeroinitializer, align 16
@gv2f32 = common global [130 x <2 x float>] zeroinitializer, align 16
@gv2f64 = common global [130 x <2 x double>] zeroinitializer, align 16
declare double @llvm.sqrt.f64(double) nounwind readonly
declare float @llvm.sqrt.f32(float) nounwind readonly

;; #!/bin/ksh
;; for i in `seq 0 63`; do
;;  echo "  %$i = load volatile i32, i32* getelementptr inbounds ([32 x i32], [32 x i32]* @gi32, i64 0, i64 $i), align 4"
;; done
;; for i in `seq 0 63`; do
;;   echo "  store volatile i32 %$i, i32* getelementptr inbounds ([32 x i32], [32 x i32]* @gi32, i64 0, i64 $i), align 4"
;; done

;; #!/bin/ksh
;; for i in `seq 0 259`; do
;;   echo "  %v$i = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @g1, i64 0, i64 $i), align 8"
;; done
;; for i in `seq 0 259`; do
;;   echo "  store volatile double %v$i, double* getelementptr inbounds ([260 x double], [260 x double]* @g1, i64 0, i64 $i), align 8"
;; done

;;;
;;; *** Test the Extended Scalar Integer Registers ***
;;;

; CHECK-LABEL: use_64_i32_regs:
; CHECK-NOT: %g0
; CHECK-NOT: %g6
; CHECK-NOT: %g7
; CHECK-NOT: %o6
; CHECK-NOT: %i6
; CHECK-NOT: %i7
; CHECK: %xg31
; CHECK: ret

define void @use_64_i32_regs() {
  %v0 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 0), align 4
  %v1 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 1), align 4
  %v2 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 2), align 4
  %v3 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 3), align 4
  %v4 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 4), align 4
  %v5 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 5), align 4
  %v6 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 6), align 4
  %v7 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 7), align 4
  %v8 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 8), align 4
  %v9 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 9), align 4
  %v10 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 10), align 4
  %v11 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 11), align 4
  %v12 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 12), align 4
  %v13 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 13), align 4
  %v14 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 14), align 4
  %v15 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 15), align 4
  %v16 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 16), align 4
  %v17 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 17), align 4
  %v18 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 18), align 4
  %v19 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 19), align 4
  %v20 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 20), align 4
  %v21 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 21), align 4
  %v22 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 22), align 4
  %v23 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 23), align 4
  %v24 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 24), align 4
  %v25 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 25), align 4
  %v26 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 26), align 4
  %v27 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 27), align 4
  %v28 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 28), align 4
  %v29 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 29), align 4
  %v30 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 30), align 4
  %v31 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 31), align 4
  %v32 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 32), align 4
  %v33 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 33), align 4
  %v34 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 34), align 4
  %v35 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 35), align 4
  %v36 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 36), align 4
  %v37 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 37), align 4
  %v38 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 38), align 4
  %v39 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 39), align 4
  %v40 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 40), align 4
  %v41 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 41), align 4
  %v42 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 42), align 4
  %v43 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 43), align 4
  %v44 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 44), align 4
  %v45 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 45), align 4
  %v46 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 46), align 4
  %v47 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 47), align 4
  %v48 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 48), align 4
  %v49 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 49), align 4
  %v50 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 50), align 4
  %v51 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 51), align 4
  %v52 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 52), align 4
  %v53 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 53), align 4
  %v54 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 54), align 4
  %v55 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 55), align 4
  %v56 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 56), align 4
  %v57 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 57), align 4
  %v58 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 58), align 4
  %v59 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 59), align 4
  %v60 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 60), align 4
  %v61 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 61), align 4
  %v62 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 62), align 4
  %v63 = load volatile i32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 63), align 4
  store volatile i32 %v0, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 0), align 4
  store volatile i32 %v1, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 1), align 4
  store volatile i32 %v2, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 2), align 4
  store volatile i32 %v3, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 3), align 4
  store volatile i32 %v4, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 4), align 4
  store volatile i32 %v5, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 5), align 4
  store volatile i32 %v6, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 6), align 4
  store volatile i32 %v7, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 7), align 4
  store volatile i32 %v8, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 8), align 4
  store volatile i32 %v9, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 9), align 4
  store volatile i32 %v10, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 10), align 4
  store volatile i32 %v11, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 11), align 4
  store volatile i32 %v12, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 12), align 4
  store volatile i32 %v13, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 13), align 4
  store volatile i32 %v14, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 14), align 4
  store volatile i32 %v15, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 15), align 4
  store volatile i32 %v16, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 16), align 4
  store volatile i32 %v17, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 17), align 4
  store volatile i32 %v18, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 18), align 4
  store volatile i32 %v19, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 19), align 4
  store volatile i32 %v20, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 20), align 4
  store volatile i32 %v21, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 21), align 4
  store volatile i32 %v22, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 22), align 4
  store volatile i32 %v23, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 23), align 4
  store volatile i32 %v24, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 24), align 4
  store volatile i32 %v25, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 25), align 4
  store volatile i32 %v26, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 26), align 4
  store volatile i32 %v27, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 27), align 4
  store volatile i32 %v28, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 28), align 4
  store volatile i32 %v29, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 29), align 4
  store volatile i32 %v30, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 30), align 4
  store volatile i32 %v31, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 31), align 4
  store volatile i32 %v32, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 32), align 4
  store volatile i32 %v33, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 33), align 4
  store volatile i32 %v34, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 34), align 4
  store volatile i32 %v35, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 35), align 4
  store volatile i32 %v36, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 36), align 4
  store volatile i32 %v37, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 37), align 4
  store volatile i32 %v38, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 38), align 4
  store volatile i32 %v39, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 39), align 4
  store volatile i32 %v40, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 40), align 4
  store volatile i32 %v41, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 41), align 4
  store volatile i32 %v42, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 42), align 4
  store volatile i32 %v43, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 43), align 4
  store volatile i32 %v44, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 44), align 4
  store volatile i32 %v45, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 45), align 4
  store volatile i32 %v46, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 46), align 4
  store volatile i32 %v47, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 47), align 4
  store volatile i32 %v48, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 48), align 4
  store volatile i32 %v49, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 49), align 4
  store volatile i32 %v50, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 50), align 4
  store volatile i32 %v51, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 51), align 4
  store volatile i32 %v52, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 52), align 4
  store volatile i32 %v53, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 53), align 4
  store volatile i32 %v54, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 54), align 4
  store volatile i32 %v55, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 55), align 4
  store volatile i32 %v56, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 56), align 4
  store volatile i32 %v57, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 57), align 4
  store volatile i32 %v58, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 58), align 4
  store volatile i32 %v59, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 59), align 4
  store volatile i32 %v60, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 60), align 4
  store volatile i32 %v61, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 61), align 4
  store volatile i32 %v62, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 62), align 4
  store volatile i32 %v63, i32* getelementptr inbounds ([64 x i32], [64 x i32]* @gi32, i64 0, i64 63), align 4

  ret void
}

;;;
;;; *** Test the Extended Scalar DP Registers ***
;;;

; CHECK-LABEL: use_260_dp_regs:
; CHECK-NOT: %g0
; CHECK-NOT: %g6
; CHECK-NOT: %g7
; CHECK-NOT: %o6
; CHECK-NOT: %i6
; CHECK-NOT: %i7
; CHECK: %f510
; CHECK: ret

define double @use_260_dp_regs(double %i) nounwind readnone {
  %v0 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 0), align 8
  %v1 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 1), align 8
  %v2 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 2), align 8
  %v3 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 3), align 8
  %v4 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 4), align 8
  %v5 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 5), align 8
  %v6 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 6), align 8
  %v7 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 7), align 8
  %v8 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 8), align 8
  %v9 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 9), align 8
  %v10 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 10), align 8
  %v11 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 11), align 8
  %v12 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 12), align 8
  %v13 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 13), align 8
  %v14 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 14), align 8
  %v15 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 15), align 8
  %v16 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 16), align 8
  %v17 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 17), align 8
  %v18 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 18), align 8
  %v19 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 19), align 8
  %v20 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 20), align 8
  %v21 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 21), align 8
  %v22 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 22), align 8
  %v23 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 23), align 8
  %v24 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 24), align 8
  %v25 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 25), align 8
  %v26 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 26), align 8
  %v27 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 27), align 8
  %v28 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 28), align 8
  %v29 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 29), align 8
  %v30 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 30), align 8
  %v31 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 31), align 8
  %v32 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 32), align 8
  %v33 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 33), align 8
  %v34 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 34), align 8
  %v35 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 35), align 8
  %v36 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 36), align 8
  %v37 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 37), align 8
  %v38 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 38), align 8
  %v39 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 39), align 8
  %v40 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 40), align 8
  %v41 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 41), align 8
  %v42 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 42), align 8
  %v43 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 43), align 8
  %v44 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 44), align 8
  %v45 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 45), align 8
  %v46 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 46), align 8
  %v47 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 47), align 8
  %v48 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 48), align 8
  %v49 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 49), align 8
  %v50 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 50), align 8
  %v51 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 51), align 8
  %v52 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 52), align 8
  %v53 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 53), align 8
  %v54 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 54), align 8
  %v55 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 55), align 8
  %v56 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 56), align 8
  %v57 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 57), align 8
  %v58 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 58), align 8
  %v59 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 59), align 8
  %v60 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 60), align 8
  %v61 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 61), align 8
  %v62 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 62), align 8
  %v63 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 63), align 8
  %v64 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 64), align 8
  %v65 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 65), align 8
  %v66 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 66), align 8
  %v67 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 67), align 8
  %v68 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 68), align 8
  %v69 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 69), align 8
  %v70 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 70), align 8
  %v71 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 71), align 8
  %v72 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 72), align 8
  %v73 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 73), align 8
  %v74 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 74), align 8
  %v75 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 75), align 8
  %v76 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 76), align 8
  %v77 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 77), align 8
  %v78 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 78), align 8
  %v79 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 79), align 8
  %v80 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 80), align 8
  %v81 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 81), align 8
  %v82 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 82), align 8
  %v83 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 83), align 8
  %v84 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 84), align 8
  %v85 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 85), align 8
  %v86 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 86), align 8
  %v87 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 87), align 8
  %v88 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 88), align 8
  %v89 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 89), align 8
  %v90 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 90), align 8
  %v91 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 91), align 8
  %v92 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 92), align 8
  %v93 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 93), align 8
  %v94 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 94), align 8
  %v95 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 95), align 8
  %v96 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 96), align 8
  %v97 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 97), align 8
  %v98 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 98), align 8
  %v99 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 99), align 8
  %v100 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 100), align 8
  %v101 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 101), align 8
  %v102 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 102), align 8
  %v103 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 103), align 8
  %v104 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 104), align 8
  %v105 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 105), align 8
  %v106 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 106), align 8
  %v107 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 107), align 8
  %v108 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 108), align 8
  %v109 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 109), align 8
  %v110 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 110), align 8
  %v111 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 111), align 8
  %v112 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 112), align 8
  %v113 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 113), align 8
  %v114 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 114), align 8
  %v115 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 115), align 8
  %v116 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 116), align 8
  %v117 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 117), align 8
  %v118 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 118), align 8
  %v119 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 119), align 8
  %v120 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 120), align 8
  %v121 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 121), align 8
  %v122 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 122), align 8
  %v123 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 123), align 8
  %v124 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 124), align 8
  %v125 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 125), align 8
  %v126 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 126), align 8
  %v127 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 127), align 8
  %v128 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 128), align 8
  %v129 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 129), align 8
  %v130 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 130), align 8
  %v131 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 131), align 8
  %v132 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 132), align 8
  %v133 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 133), align 8
  %v134 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 134), align 8
  %v135 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 135), align 8
  %v136 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 136), align 8
  %v137 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 137), align 8
  %v138 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 138), align 8
  %v139 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 139), align 8
  %v140 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 140), align 8
  %v141 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 141), align 8
  %v142 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 142), align 8
  %v143 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 143), align 8
  %v144 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 144), align 8
  %v145 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 145), align 8
  %v146 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 146), align 8
  %v147 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 147), align 8
  %v148 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 148), align 8
  %v149 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 149), align 8
  %v150 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 150), align 8
  %v151 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 151), align 8
  %v152 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 152), align 8
  %v153 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 153), align 8
  %v154 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 154), align 8
  %v155 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 155), align 8
  %v156 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 156), align 8
  %v157 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 157), align 8
  %v158 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 158), align 8
  %v159 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 159), align 8
  %v160 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 160), align 8
  %v161 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 161), align 8
  %v162 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 162), align 8
  %v163 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 163), align 8
  %v164 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 164), align 8
  %v165 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 165), align 8
  %v166 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 166), align 8
  %v167 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 167), align 8
  %v168 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 168), align 8
  %v169 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 169), align 8
  %v170 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 170), align 8
  %v171 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 171), align 8
  %v172 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 172), align 8
  %v173 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 173), align 8
  %v174 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 174), align 8
  %v175 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 175), align 8
  %v176 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 176), align 8
  %v177 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 177), align 8
  %v178 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 178), align 8
  %v179 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 179), align 8
  %v180 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 180), align 8
  %v181 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 181), align 8
  %v182 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 182), align 8
  %v183 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 183), align 8
  %v184 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 184), align 8
  %v185 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 185), align 8
  %v186 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 186), align 8
  %v187 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 187), align 8
  %v188 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 188), align 8
  %v189 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 189), align 8
  %v190 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 190), align 8
  %v191 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 191), align 8
  %v192 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 192), align 8
  %v193 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 193), align 8
  %v194 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 194), align 8
  %v195 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 195), align 8
  %v196 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 196), align 8
  %v197 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 197), align 8
  %v198 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 198), align 8
  %v199 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 199), align 8
  %v200 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 200), align 8
  %v201 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 201), align 8
  %v202 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 202), align 8
  %v203 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 203), align 8
  %v204 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 204), align 8
  %v205 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 205), align 8
  %v206 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 206), align 8
  %v207 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 207), align 8
  %v208 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 208), align 8
  %v209 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 209), align 8
  %v210 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 210), align 8
  %v211 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 211), align 8
  %v212 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 212), align 8
  %v213 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 213), align 8
  %v214 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 214), align 8
  %v215 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 215), align 8
  %v216 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 216), align 8
  %v217 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 217), align 8
  %v218 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 218), align 8
  %v219 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 219), align 8
  %v220 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 220), align 8
  %v221 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 221), align 8
  %v222 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 222), align 8
  %v223 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 223), align 8
  %v224 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 224), align 8
  %v225 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 225), align 8
  %v226 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 226), align 8
  %v227 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 227), align 8
  %v228 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 228), align 8
  %v229 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 229), align 8
  %v230 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 230), align 8
  %v231 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 231), align 8
  %v232 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 232), align 8
  %v233 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 233), align 8
  %v234 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 234), align 8
  %v235 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 235), align 8
  %v236 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 236), align 8
  %v237 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 237), align 8
  %v238 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 238), align 8
  %v239 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 239), align 8
  %v240 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 240), align 8
  %v241 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 241), align 8
  %v242 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 242), align 8
  %v243 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 243), align 8
  %v244 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 244), align 8
  %v245 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 245), align 8
  %v246 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 246), align 8
  %v247 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 247), align 8
  %v248 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 248), align 8
  %v249 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 249), align 8
  %v250 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 250), align 8
  %v251 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 251), align 8
  %v252 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 252), align 8
  %v253 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 253), align 8
  %v254 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 254), align 8
  %v255 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 255), align 8
  %v256 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 256), align 8
  %v257 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 257), align 8
  %v258 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 258), align 8
  %v259 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 259), align 8

  store volatile double %v0, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 0), align 8
  store volatile double %v1, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 1), align 8
  store volatile double %v2, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 2), align 8
  store volatile double %v3, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 3), align 8
  store volatile double %v4, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 4), align 8
  store volatile double %v5, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 5), align 8
  store volatile double %v6, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 6), align 8
  store volatile double %v7, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 7), align 8
  store volatile double %v8, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 8), align 8
  store volatile double %v9, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 9), align 8
  store volatile double %v10, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 10), align 8
  store volatile double %v11, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 11), align 8
  store volatile double %v12, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 12), align 8
  store volatile double %v13, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 13), align 8
  store volatile double %v14, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 14), align 8
  store volatile double %v15, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 15), align 8
  store volatile double %v16, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 16), align 8
  store volatile double %v17, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 17), align 8
  store volatile double %v18, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 18), align 8
  store volatile double %v19, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 19), align 8
  store volatile double %v20, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 20), align 8
  store volatile double %v21, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 21), align 8
  store volatile double %v22, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 22), align 8
  store volatile double %v23, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 23), align 8
  store volatile double %v24, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 24), align 8
  store volatile double %v25, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 25), align 8
  store volatile double %v26, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 26), align 8
  store volatile double %v27, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 27), align 8
  store volatile double %v28, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 28), align 8
  store volatile double %v29, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 29), align 8
  store volatile double %v30, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 30), align 8
  store volatile double %v31, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 31), align 8
  store volatile double %v32, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 32), align 8
  store volatile double %v33, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 33), align 8
  store volatile double %v34, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 34), align 8
  store volatile double %v35, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 35), align 8
  store volatile double %v36, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 36), align 8
  store volatile double %v37, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 37), align 8
  store volatile double %v38, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 38), align 8
  store volatile double %v39, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 39), align 8
  store volatile double %v40, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 40), align 8
  store volatile double %v41, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 41), align 8
  store volatile double %v42, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 42), align 8
  store volatile double %v43, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 43), align 8
  store volatile double %v44, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 44), align 8
  store volatile double %v45, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 45), align 8
  store volatile double %v46, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 46), align 8
  store volatile double %v47, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 47), align 8
  store volatile double %v48, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 48), align 8
  store volatile double %v49, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 49), align 8
  store volatile double %v50, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 50), align 8
  store volatile double %v51, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 51), align 8
  store volatile double %v52, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 52), align 8
  store volatile double %v53, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 53), align 8
  store volatile double %v54, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 54), align 8
  store volatile double %v55, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 55), align 8
  store volatile double %v56, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 56), align 8
  store volatile double %v57, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 57), align 8
  store volatile double %v58, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 58), align 8
  store volatile double %v59, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 59), align 8
  store volatile double %v60, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 60), align 8
  store volatile double %v61, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 61), align 8
  store volatile double %v62, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 62), align 8
  store volatile double %v63, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 63), align 8
  store volatile double %v64, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 64), align 8
  store volatile double %v65, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 65), align 8
  store volatile double %v66, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 66), align 8
  store volatile double %v67, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 67), align 8
  store volatile double %v68, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 68), align 8
  store volatile double %v69, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 69), align 8
  store volatile double %v70, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 70), align 8
  store volatile double %v71, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 71), align 8
  store volatile double %v72, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 72), align 8
  store volatile double %v73, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 73), align 8
  store volatile double %v74, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 74), align 8
  store volatile double %v75, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 75), align 8
  store volatile double %v76, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 76), align 8
  store volatile double %v77, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 77), align 8
  store volatile double %v78, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 78), align 8
  store volatile double %v79, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 79), align 8
  store volatile double %v80, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 80), align 8
  store volatile double %v81, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 81), align 8
  store volatile double %v82, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 82), align 8
  store volatile double %v83, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 83), align 8
  store volatile double %v84, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 84), align 8
  store volatile double %v85, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 85), align 8
  store volatile double %v86, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 86), align 8
  store volatile double %v87, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 87), align 8
  store volatile double %v88, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 88), align 8
  store volatile double %v89, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 89), align 8
  store volatile double %v90, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 90), align 8
  store volatile double %v91, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 91), align 8
  store volatile double %v92, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 92), align 8
  store volatile double %v93, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 93), align 8
  store volatile double %v94, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 94), align 8
  store volatile double %v95, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 95), align 8
  store volatile double %v96, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 96), align 8
  store volatile double %v97, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 97), align 8
  store volatile double %v98, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 98), align 8
  store volatile double %v99, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 99), align 8
  store volatile double %v100, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 100), align 8
  store volatile double %v101, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 101), align 8
  store volatile double %v102, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 102), align 8
  store volatile double %v103, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 103), align 8
  store volatile double %v104, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 104), align 8
  store volatile double %v105, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 105), align 8
  store volatile double %v106, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 106), align 8
  store volatile double %v107, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 107), align 8
  store volatile double %v108, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 108), align 8
  store volatile double %v109, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 109), align 8
  store volatile double %v110, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 110), align 8
  store volatile double %v111, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 111), align 8
  store volatile double %v112, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 112), align 8
  store volatile double %v113, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 113), align 8
  store volatile double %v114, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 114), align 8
  store volatile double %v115, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 115), align 8
  store volatile double %v116, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 116), align 8
  store volatile double %v117, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 117), align 8
  store volatile double %v118, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 118), align 8
  store volatile double %v119, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 119), align 8
  store volatile double %v120, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 120), align 8
  store volatile double %v121, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 121), align 8
  store volatile double %v122, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 122), align 8
  store volatile double %v123, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 123), align 8
  store volatile double %v124, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 124), align 8
  store volatile double %v125, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 125), align 8
  store volatile double %v126, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 126), align 8
  store volatile double %v127, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 127), align 8
  store volatile double %v128, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 128), align 8
  store volatile double %v129, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 129), align 8
  store volatile double %v130, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 130), align 8
  store volatile double %v131, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 131), align 8
  store volatile double %v132, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 132), align 8
  store volatile double %v133, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 133), align 8
  store volatile double %v134, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 134), align 8
  store volatile double %v135, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 135), align 8
  store volatile double %v136, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 136), align 8
  store volatile double %v137, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 137), align 8
  store volatile double %v138, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 138), align 8
  store volatile double %v139, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 139), align 8
  store volatile double %v140, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 140), align 8
  store volatile double %v141, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 141), align 8
  store volatile double %v142, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 142), align 8
  store volatile double %v143, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 143), align 8
  store volatile double %v144, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 144), align 8
  store volatile double %v145, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 145), align 8
  store volatile double %v146, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 146), align 8
  store volatile double %v147, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 147), align 8
  store volatile double %v148, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 148), align 8
  store volatile double %v149, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 149), align 8
  store volatile double %v150, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 150), align 8
  store volatile double %v151, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 151), align 8
  store volatile double %v152, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 152), align 8
  store volatile double %v153, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 153), align 8
  store volatile double %v154, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 154), align 8
  store volatile double %v155, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 155), align 8
  store volatile double %v156, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 156), align 8
  store volatile double %v157, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 157), align 8
  store volatile double %v158, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 158), align 8
  store volatile double %v159, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 159), align 8
  store volatile double %v160, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 160), align 8
  store volatile double %v161, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 161), align 8
  store volatile double %v162, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 162), align 8
  store volatile double %v163, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 163), align 8
  store volatile double %v164, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 164), align 8
  store volatile double %v165, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 165), align 8
  store volatile double %v166, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 166), align 8
  store volatile double %v167, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 167), align 8
  store volatile double %v168, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 168), align 8
  store volatile double %v169, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 169), align 8
  store volatile double %v170, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 170), align 8
  store volatile double %v171, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 171), align 8
  store volatile double %v172, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 172), align 8
  store volatile double %v173, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 173), align 8
  store volatile double %v174, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 174), align 8
  store volatile double %v175, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 175), align 8
  store volatile double %v176, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 176), align 8
  store volatile double %v177, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 177), align 8
  store volatile double %v178, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 178), align 8
  store volatile double %v179, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 179), align 8
  store volatile double %v180, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 180), align 8
  store volatile double %v181, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 181), align 8
  store volatile double %v182, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 182), align 8
  store volatile double %v183, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 183), align 8
  store volatile double %v184, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 184), align 8
  store volatile double %v185, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 185), align 8
  store volatile double %v186, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 186), align 8
  store volatile double %v187, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 187), align 8
  store volatile double %v188, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 188), align 8
  store volatile double %v189, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 189), align 8
  store volatile double %v190, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 190), align 8
  store volatile double %v191, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 191), align 8
  store volatile double %v192, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 192), align 8
  store volatile double %v193, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 193), align 8
  store volatile double %v194, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 194), align 8
  store volatile double %v195, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 195), align 8
  store volatile double %v196, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 196), align 8
  store volatile double %v197, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 197), align 8
  store volatile double %v198, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 198), align 8
  store volatile double %v199, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 199), align 8
  store volatile double %v200, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 200), align 8
  store volatile double %v201, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 201), align 8
  store volatile double %v202, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 202), align 8
  store volatile double %v203, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 203), align 8
  store volatile double %v204, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 204), align 8
  store volatile double %v205, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 205), align 8
  store volatile double %v206, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 206), align 8
  store volatile double %v207, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 207), align 8
  store volatile double %v208, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 208), align 8
  store volatile double %v209, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 209), align 8
  store volatile double %v210, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 210), align 8
  store volatile double %v211, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 211), align 8
  store volatile double %v212, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 212), align 8
  store volatile double %v213, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 213), align 8
  store volatile double %v214, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 214), align 8
  store volatile double %v215, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 215), align 8
  store volatile double %v216, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 216), align 8
  store volatile double %v217, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 217), align 8
  store volatile double %v218, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 218), align 8
  store volatile double %v219, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 219), align 8
  store volatile double %v220, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 220), align 8
  store volatile double %v221, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 221), align 8
  store volatile double %v222, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 222), align 8
  store volatile double %v223, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 223), align 8
  store volatile double %v224, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 224), align 8
  store volatile double %v225, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 225), align 8
  store volatile double %v226, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 226), align 8
  store volatile double %v227, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 227), align 8
  store volatile double %v228, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 228), align 8
  store volatile double %v229, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 229), align 8
  store volatile double %v230, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 230), align 8
  store volatile double %v231, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 231), align 8
  store volatile double %v232, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 232), align 8
  store volatile double %v233, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 233), align 8
  store volatile double %v234, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 234), align 8
  store volatile double %v235, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 235), align 8
  store volatile double %v236, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 236), align 8
  store volatile double %v237, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 237), align 8
  store volatile double %v238, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 238), align 8
  store volatile double %v239, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 239), align 8
  store volatile double %v240, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 240), align 8
  store volatile double %v241, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 241), align 8
  store volatile double %v242, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 242), align 8
  store volatile double %v243, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 243), align 8
  store volatile double %v244, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 244), align 8
  store volatile double %v245, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 245), align 8
  store volatile double %v246, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 246), align 8
  store volatile double %v247, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 247), align 8
  store volatile double %v248, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 248), align 8
  store volatile double %v249, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 249), align 8
  store volatile double %v250, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 250), align 8
  store volatile double %v251, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 251), align 8
  store volatile double %v252, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 252), align 8
  store volatile double %v253, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 253), align 8
  store volatile double %v254, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 254), align 8
  store volatile double %v255, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 255), align 8
  store volatile double %v256, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 256), align 8
  store volatile double %v257, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 257), align 8
  store volatile double %v258, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 258), align 8
  store volatile double %v259, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 259), align 8

  ret double %i
}

;;;
;;; *** Test the Extended Scalar FP Registers ***
;;;

; CHECK-LABEL: use_260_fp_regs:
; CHECK: %f508
; CHECK: %f510
; CHECK: retl

define float @use_260_fp_regs(float %i) nounwind readnone {
  %v0 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 0), align 8
  %v1 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 1), align 8
  %v2 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 2), align 8
  %v3 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 3), align 8
  %v4 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 4), align 8
  %v5 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 5), align 8
  %v6 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 6), align 8
  %v7 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 7), align 8
  %v8 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 8), align 8
  %v9 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 9), align 8
  %v10 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 10), align 8
  %v11 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 11), align 8
  %v12 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 12), align 8
  %v13 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 13), align 8
  %v14 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 14), align 8
  %v15 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 15), align 8
  %v16 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 16), align 8
  %v17 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 17), align 8
  %v18 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 18), align 8
  %v19 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 19), align 8
  %v20 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 20), align 8
  %v21 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 21), align 8
  %v22 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 22), align 8
  %v23 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 23), align 8
  %v24 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 24), align 8
  %v25 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 25), align 8
  %v26 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 26), align 8
  %v27 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 27), align 8
  %v28 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 28), align 8
  %v29 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 29), align 8
  %v30 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 30), align 8
  %v31 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 31), align 8
  %v32 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 32), align 8
  %v33 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 33), align 8
  %v34 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 34), align 8
  %v35 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 35), align 8
  %v36 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 36), align 8
  %v37 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 37), align 8
  %v38 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 38), align 8
  %v39 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 39), align 8
  %v40 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 40), align 8
  %v41 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 41), align 8
  %v42 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 42), align 8
  %v43 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 43), align 8
  %v44 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 44), align 8
  %v45 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 45), align 8
  %v46 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 46), align 8
  %v47 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 47), align 8
  %v48 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 48), align 8
  %v49 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 49), align 8
  %v50 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 50), align 8
  %v51 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 51), align 8
  %v52 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 52), align 8
  %v53 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 53), align 8
  %v54 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 54), align 8
  %v55 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 55), align 8
  %v56 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 56), align 8
  %v57 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 57), align 8
  %v58 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 58), align 8
  %v59 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 59), align 8
  %v60 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 60), align 8
  %v61 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 61), align 8
  %v62 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 62), align 8
  %v63 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 63), align 8
  %v64 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 64), align 8
  %v65 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 65), align 8
  %v66 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 66), align 8
  %v67 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 67), align 8
  %v68 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 68), align 8
  %v69 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 69), align 8
  %v70 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 70), align 8
  %v71 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 71), align 8
  %v72 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 72), align 8
  %v73 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 73), align 8
  %v74 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 74), align 8
  %v75 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 75), align 8
  %v76 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 76), align 8
  %v77 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 77), align 8
  %v78 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 78), align 8
  %v79 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 79), align 8
  %v80 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 80), align 8
  %v81 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 81), align 8
  %v82 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 82), align 8
  %v83 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 83), align 8
  %v84 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 84), align 8
  %v85 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 85), align 8
  %v86 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 86), align 8
  %v87 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 87), align 8
  %v88 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 88), align 8
  %v89 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 89), align 8
  %v90 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 90), align 8
  %v91 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 91), align 8
  %v92 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 92), align 8
  %v93 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 93), align 8
  %v94 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 94), align 8
  %v95 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 95), align 8
  %v96 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 96), align 8
  %v97 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 97), align 8
  %v98 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 98), align 8
  %v99 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 99), align 8
  %v100 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 100), align 8
  %v101 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 101), align 8
  %v102 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 102), align 8
  %v103 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 103), align 8
  %v104 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 104), align 8
  %v105 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 105), align 8
  %v106 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 106), align 8
  %v107 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 107), align 8
  %v108 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 108), align 8
  %v109 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 109), align 8
  %v110 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 110), align 8
  %v111 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 111), align 8
  %v112 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 112), align 8
  %v113 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 113), align 8
  %v114 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 114), align 8
  %v115 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 115), align 8
  %v116 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 116), align 8
  %v117 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 117), align 8
  %v118 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 118), align 8
  %v119 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 119), align 8
  %v120 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 120), align 8
  %v121 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 121), align 8
  %v122 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 122), align 8
  %v123 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 123), align 8
  %v124 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 124), align 8
  %v125 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 125), align 8
  %v126 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 126), align 8
  %v127 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 127), align 8
  %v128 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 128), align 8
  %v129 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 129), align 8
  %v130 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 130), align 8
  %v131 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 131), align 8
  %v132 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 132), align 8
  %v133 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 133), align 8
  %v134 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 134), align 8
  %v135 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 135), align 8
  %v136 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 136), align 8
  %v137 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 137), align 8
  %v138 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 138), align 8
  %v139 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 139), align 8
  %v140 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 140), align 8
  %v141 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 141), align 8
  %v142 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 142), align 8
  %v143 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 143), align 8
  %v144 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 144), align 8
  %v145 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 145), align 8
  %v146 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 146), align 8
  %v147 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 147), align 8
  %v148 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 148), align 8
  %v149 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 149), align 8
  %v150 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 150), align 8
  %v151 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 151), align 8
  %v152 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 152), align 8
  %v153 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 153), align 8
  %v154 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 154), align 8
  %v155 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 155), align 8
  %v156 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 156), align 8
  %v157 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 157), align 8
  %v158 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 158), align 8
  %v159 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 159), align 8
  %v160 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 160), align 8
  %v161 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 161), align 8
  %v162 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 162), align 8
  %v163 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 163), align 8
  %v164 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 164), align 8
  %v165 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 165), align 8
  %v166 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 166), align 8
  %v167 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 167), align 8
  %v168 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 168), align 8
  %v169 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 169), align 8
  %v170 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 170), align 8
  %v171 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 171), align 8
  %v172 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 172), align 8
  %v173 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 173), align 8
  %v174 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 174), align 8
  %v175 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 175), align 8
  %v176 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 176), align 8
  %v177 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 177), align 8
  %v178 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 178), align 8
  %v179 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 179), align 8
  %v180 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 180), align 8
  %v181 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 181), align 8
  %v182 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 182), align 8
  %v183 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 183), align 8
  %v184 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 184), align 8
  %v185 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 185), align 8
  %v186 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 186), align 8
  %v187 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 187), align 8
  %v188 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 188), align 8
  %v189 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 189), align 8
  %v190 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 190), align 8
  %v191 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 191), align 8
  %v192 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 192), align 8
  %v193 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 193), align 8
  %v194 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 194), align 8
  %v195 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 195), align 8
  %v196 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 196), align 8
  %v197 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 197), align 8
  %v198 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 198), align 8
  %v199 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 199), align 8
  %v200 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 200), align 8
  %v201 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 201), align 8
  %v202 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 202), align 8
  %v203 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 203), align 8
  %v204 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 204), align 8
  %v205 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 205), align 8
  %v206 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 206), align 8
  %v207 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 207), align 8
  %v208 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 208), align 8
  %v209 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 209), align 8
  %v210 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 210), align 8
  %v211 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 211), align 8
  %v212 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 212), align 8
  %v213 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 213), align 8
  %v214 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 214), align 8
  %v215 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 215), align 8
  %v216 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 216), align 8
  %v217 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 217), align 8
  %v218 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 218), align 8
  %v219 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 219), align 8
  %v220 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 220), align 8
  %v221 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 221), align 8
  %v222 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 222), align 8
  %v223 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 223), align 8
  %v224 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 224), align 8
  %v225 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 225), align 8
  %v226 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 226), align 8
  %v227 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 227), align 8
  %v228 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 228), align 8
  %v229 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 229), align 8
  %v230 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 230), align 8
  %v231 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 231), align 8
  %v232 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 232), align 8
  %v233 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 233), align 8
  %v234 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 234), align 8
  %v235 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 235), align 8
  %v236 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 236), align 8
  %v237 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 237), align 8
  %v238 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 238), align 8
  %v239 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 239), align 8
  %v240 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 240), align 8
  %v241 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 241), align 8
  %v242 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 242), align 8
  %v243 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 243), align 8
  %v244 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 244), align 8
  %v245 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 245), align 8
  %v246 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 246), align 8
  %v247 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 247), align 8
  %v248 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 248), align 8
  %v249 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 249), align 8
  %v250 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 250), align 8
  %v251 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 251), align 8
  %v252 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 252), align 8
  %v253 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 253), align 8
  %v254 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 254), align 8
  %v255 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 255), align 8
  %v256 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 256), align 8
  %v257 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 257), align 8
  %v258 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 258), align 8
  %v259 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 259), align 8

  store volatile float %v0, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 0), align 8
  store volatile float %v1, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 1), align 8
  store volatile float %v2, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 2), align 8
  store volatile float %v3, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 3), align 8
  store volatile float %v4, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 4), align 8
  store volatile float %v5, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 5), align 8
  store volatile float %v6, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 6), align 8
  store volatile float %v7, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 7), align 8
  store volatile float %v8, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 8), align 8
  store volatile float %v9, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 9), align 8
  store volatile float %v10, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 10), align 8
  store volatile float %v11, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 11), align 8
  store volatile float %v12, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 12), align 8
  store volatile float %v13, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 13), align 8
  store volatile float %v14, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 14), align 8
  store volatile float %v15, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 15), align 8
  store volatile float %v16, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 16), align 8
  store volatile float %v17, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 17), align 8
  store volatile float %v18, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 18), align 8
  store volatile float %v19, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 19), align 8
  store volatile float %v20, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 20), align 8
  store volatile float %v21, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 21), align 8
  store volatile float %v22, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 22), align 8
  store volatile float %v23, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 23), align 8
  store volatile float %v24, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 24), align 8
  store volatile float %v25, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 25), align 8
  store volatile float %v26, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 26), align 8
  store volatile float %v27, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 27), align 8
  store volatile float %v28, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 28), align 8
  store volatile float %v29, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 29), align 8
  store volatile float %v30, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 30), align 8
  store volatile float %v31, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 31), align 8
  store volatile float %v32, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 32), align 8
  store volatile float %v33, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 33), align 8
  store volatile float %v34, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 34), align 8
  store volatile float %v35, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 35), align 8
  store volatile float %v36, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 36), align 8
  store volatile float %v37, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 37), align 8
  store volatile float %v38, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 38), align 8
  store volatile float %v39, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 39), align 8
  store volatile float %v40, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 40), align 8
  store volatile float %v41, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 41), align 8
  store volatile float %v42, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 42), align 8
  store volatile float %v43, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 43), align 8
  store volatile float %v44, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 44), align 8
  store volatile float %v45, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 45), align 8
  store volatile float %v46, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 46), align 8
  store volatile float %v47, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 47), align 8
  store volatile float %v48, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 48), align 8
  store volatile float %v49, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 49), align 8
  store volatile float %v50, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 50), align 8
  store volatile float %v51, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 51), align 8
  store volatile float %v52, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 52), align 8
  store volatile float %v53, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 53), align 8
  store volatile float %v54, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 54), align 8
  store volatile float %v55, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 55), align 8
  store volatile float %v56, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 56), align 8
  store volatile float %v57, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 57), align 8
  store volatile float %v58, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 58), align 8
  store volatile float %v59, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 59), align 8
  store volatile float %v60, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 60), align 8
  store volatile float %v61, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 61), align 8
  store volatile float %v62, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 62), align 8
  store volatile float %v63, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 63), align 8
  store volatile float %v64, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 64), align 8
  store volatile float %v65, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 65), align 8
  store volatile float %v66, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 66), align 8
  store volatile float %v67, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 67), align 8
  store volatile float %v68, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 68), align 8
  store volatile float %v69, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 69), align 8
  store volatile float %v70, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 70), align 8
  store volatile float %v71, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 71), align 8
  store volatile float %v72, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 72), align 8
  store volatile float %v73, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 73), align 8
  store volatile float %v74, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 74), align 8
  store volatile float %v75, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 75), align 8
  store volatile float %v76, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 76), align 8
  store volatile float %v77, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 77), align 8
  store volatile float %v78, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 78), align 8
  store volatile float %v79, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 79), align 8
  store volatile float %v80, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 80), align 8
  store volatile float %v81, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 81), align 8
  store volatile float %v82, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 82), align 8
  store volatile float %v83, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 83), align 8
  store volatile float %v84, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 84), align 8
  store volatile float %v85, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 85), align 8
  store volatile float %v86, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 86), align 8
  store volatile float %v87, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 87), align 8
  store volatile float %v88, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 88), align 8
  store volatile float %v89, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 89), align 8
  store volatile float %v90, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 90), align 8
  store volatile float %v91, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 91), align 8
  store volatile float %v92, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 92), align 8
  store volatile float %v93, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 93), align 8
  store volatile float %v94, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 94), align 8
  store volatile float %v95, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 95), align 8
  store volatile float %v96, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 96), align 8
  store volatile float %v97, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 97), align 8
  store volatile float %v98, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 98), align 8
  store volatile float %v99, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 99), align 8
  store volatile float %v100, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 100), align 8
  store volatile float %v101, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 101), align 8
  store volatile float %v102, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 102), align 8
  store volatile float %v103, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 103), align 8
  store volatile float %v104, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 104), align 8
  store volatile float %v105, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 105), align 8
  store volatile float %v106, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 106), align 8
  store volatile float %v107, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 107), align 8
  store volatile float %v108, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 108), align 8
  store volatile float %v109, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 109), align 8
  store volatile float %v110, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 110), align 8
  store volatile float %v111, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 111), align 8
  store volatile float %v112, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 112), align 8
  store volatile float %v113, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 113), align 8
  store volatile float %v114, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 114), align 8
  store volatile float %v115, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 115), align 8
  store volatile float %v116, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 116), align 8
  store volatile float %v117, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 117), align 8
  store volatile float %v118, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 118), align 8
  store volatile float %v119, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 119), align 8
  store volatile float %v120, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 120), align 8
  store volatile float %v121, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 121), align 8
  store volatile float %v122, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 122), align 8
  store volatile float %v123, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 123), align 8
  store volatile float %v124, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 124), align 8
  store volatile float %v125, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 125), align 8
  store volatile float %v126, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 126), align 8
  store volatile float %v127, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 127), align 8
  store volatile float %v128, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 128), align 8
  store volatile float %v129, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 129), align 8
  store volatile float %v130, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 130), align 8
  store volatile float %v131, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 131), align 8
  store volatile float %v132, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 132), align 8
  store volatile float %v133, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 133), align 8
  store volatile float %v134, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 134), align 8
  store volatile float %v135, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 135), align 8
  store volatile float %v136, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 136), align 8
  store volatile float %v137, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 137), align 8
  store volatile float %v138, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 138), align 8
  store volatile float %v139, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 139), align 8
  store volatile float %v140, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 140), align 8
  store volatile float %v141, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 141), align 8
  store volatile float %v142, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 142), align 8
  store volatile float %v143, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 143), align 8
  store volatile float %v144, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 144), align 8
  store volatile float %v145, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 145), align 8
  store volatile float %v146, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 146), align 8
  store volatile float %v147, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 147), align 8
  store volatile float %v148, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 148), align 8
  store volatile float %v149, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 149), align 8
  store volatile float %v150, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 150), align 8
  store volatile float %v151, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 151), align 8
  store volatile float %v152, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 152), align 8
  store volatile float %v153, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 153), align 8
  store volatile float %v154, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 154), align 8
  store volatile float %v155, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 155), align 8
  store volatile float %v156, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 156), align 8
  store volatile float %v157, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 157), align 8
  store volatile float %v158, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 158), align 8
  store volatile float %v159, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 159), align 8
  store volatile float %v160, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 160), align 8
  store volatile float %v161, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 161), align 8
  store volatile float %v162, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 162), align 8
  store volatile float %v163, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 163), align 8
  store volatile float %v164, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 164), align 8
  store volatile float %v165, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 165), align 8
  store volatile float %v166, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 166), align 8
  store volatile float %v167, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 167), align 8
  store volatile float %v168, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 168), align 8
  store volatile float %v169, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 169), align 8
  store volatile float %v170, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 170), align 8
  store volatile float %v171, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 171), align 8
  store volatile float %v172, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 172), align 8
  store volatile float %v173, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 173), align 8
  store volatile float %v174, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 174), align 8
  store volatile float %v175, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 175), align 8
  store volatile float %v176, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 176), align 8
  store volatile float %v177, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 177), align 8
  store volatile float %v178, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 178), align 8
  store volatile float %v179, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 179), align 8
  store volatile float %v180, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 180), align 8
  store volatile float %v181, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 181), align 8
  store volatile float %v182, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 182), align 8
  store volatile float %v183, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 183), align 8
  store volatile float %v184, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 184), align 8
  store volatile float %v185, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 185), align 8
  store volatile float %v186, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 186), align 8
  store volatile float %v187, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 187), align 8
  store volatile float %v188, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 188), align 8
  store volatile float %v189, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 189), align 8
  store volatile float %v190, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 190), align 8
  store volatile float %v191, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 191), align 8
  store volatile float %v192, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 192), align 8
  store volatile float %v193, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 193), align 8
  store volatile float %v194, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 194), align 8
  store volatile float %v195, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 195), align 8
  store volatile float %v196, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 196), align 8
  store volatile float %v197, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 197), align 8
  store volatile float %v198, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 198), align 8
  store volatile float %v199, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 199), align 8
  store volatile float %v200, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 200), align 8
  store volatile float %v201, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 201), align 8
  store volatile float %v202, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 202), align 8
  store volatile float %v203, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 203), align 8
  store volatile float %v204, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 204), align 8
  store volatile float %v205, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 205), align 8
  store volatile float %v206, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 206), align 8
  store volatile float %v207, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 207), align 8
  store volatile float %v208, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 208), align 8
  store volatile float %v209, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 209), align 8
  store volatile float %v210, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 210), align 8
  store volatile float %v211, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 211), align 8
  store volatile float %v212, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 212), align 8
  store volatile float %v213, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 213), align 8
  store volatile float %v214, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 214), align 8
  store volatile float %v215, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 215), align 8
  store volatile float %v216, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 216), align 8
  store volatile float %v217, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 217), align 8
  store volatile float %v218, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 218), align 8
  store volatile float %v219, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 219), align 8
  store volatile float %v220, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 220), align 8
  store volatile float %v221, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 221), align 8
  store volatile float %v222, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 222), align 8
  store volatile float %v223, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 223), align 8
  store volatile float %v224, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 224), align 8
  store volatile float %v225, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 225), align 8
  store volatile float %v226, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 226), align 8
  store volatile float %v227, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 227), align 8
  store volatile float %v228, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 228), align 8
  store volatile float %v229, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 229), align 8
  store volatile float %v230, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 230), align 8
  store volatile float %v231, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 231), align 8
  store volatile float %v232, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 232), align 8
  store volatile float %v233, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 233), align 8
  store volatile float %v234, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 234), align 8
  store volatile float %v235, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 235), align 8
  store volatile float %v236, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 236), align 8
  store volatile float %v237, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 237), align 8
  store volatile float %v238, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 238), align 8
  store volatile float %v239, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 239), align 8
  store volatile float %v240, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 240), align 8
  store volatile float %v241, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 241), align 8
  store volatile float %v242, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 242), align 8
  store volatile float %v243, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 243), align 8
  store volatile float %v244, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 244), align 8
  store volatile float %v245, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 245), align 8
  store volatile float %v246, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 246), align 8
  store volatile float %v247, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 247), align 8
  store volatile float %v248, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 248), align 8
  store volatile float %v249, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 249), align 8
  store volatile float %v250, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 250), align 8
  store volatile float %v251, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 251), align 8
  store volatile float %v252, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 252), align 8
  store volatile float %v253, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 253), align 8
  store volatile float %v254, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 254), align 8
  store volatile float %v255, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 255), align 8
  store volatile float %v256, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 256), align 8
  store volatile float %v257, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 257), align 8
  store volatile float %v258, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 258), align 8
  store volatile float %v259, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 259), align 8

  ret float %i
}

;;;
;;; *** Test if FSQRT (DP) Generates Results in Vector Element0 Registers ***
;;;

define double @sqrt_dp_lo_regs(double %i) nounwind readnone {
  %v0 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 0), align 8
  %v1 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 1), align 8
  %v2 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 2), align 8
  %v3 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 3), align 8
  %v4 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 4), align 8
  %v5 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 5), align 8
  %v6 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 6), align 8
  %v7 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 7), align 8
  %v8 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 8), align 8
  %v9 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 9), align 8
  %v10 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 10), align 8
  %v11 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 11), align 8
  %v12 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 12), align 8
  %v13 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 13), align 8
  %v14 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 14), align 8
  %v15 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 15), align 8
  %v16 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 16), align 8
  %v17 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 17), align 8
  %v18 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 18), align 8
  %v19 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 19), align 8
  %v20 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 20), align 8
  %v21 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 21), align 8
  %v22 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 22), align 8
  %v23 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 23), align 8
  %v24 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 24), align 8
  %v25 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 25), align 8
  %v26 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 26), align 8
  %v27 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 27), align 8
  %v28 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 28), align 8
  %v29 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 29), align 8
  %v30 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 30), align 8
  %v31 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 31), align 8
  %v32 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 32), align 8
  %v33 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 33), align 8
  %v34 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 34), align 8
  %v35 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 35), align 8
  %v36 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 36), align 8
  %v37 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 37), align 8
  %v38 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 38), align 8
  %v39 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 39), align 8
  %v40 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 40), align 8
  %v41 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 41), align 8
  %v42 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 42), align 8
  %v43 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 43), align 8
  %v44 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 44), align 8
  %v45 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 45), align 8
  %v46 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 46), align 8
  %v47 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 47), align 8
  %v48 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 48), align 8
  %v49 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 49), align 8
  %v50 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 50), align 8
  %v51 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 51), align 8
  %v52 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 52), align 8
  %v53 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 53), align 8
  %v54 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 54), align 8
  %v55 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 55), align 8
  %v56 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 56), align 8
  %v57 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 57), align 8
  %v58 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 58), align 8
  %v59 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 59), align 8
  %v60 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 60), align 8
  %v61 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 61), align 8
  %v62 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 62), align 8
  %v63 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 63), align 8
  %v64 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 64), align 8
  %v65 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 65), align 8
  %v66 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 66), align 8
  %v67 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 67), align 8
  %v68 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 68), align 8
  %v69 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 69), align 8
  %v70 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 70), align 8
  %v71 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 71), align 8
  %v72 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 72), align 8
  %v73 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 73), align 8
  %v74 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 74), align 8
  %v75 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 75), align 8
  %v76 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 76), align 8
  %v77 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 77), align 8
  %v78 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 78), align 8
  %v79 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 79), align 8
  %v80 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 80), align 8
  %v81 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 81), align 8
  %v82 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 82), align 8
  %v83 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 83), align 8
  %v84 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 84), align 8
  %v85 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 85), align 8
  %v86 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 86), align 8
  %v87 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 87), align 8
  %v88 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 88), align 8
  %v89 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 89), align 8
  %v90 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 90), align 8
  %v91 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 91), align 8
  %v92 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 92), align 8
  %v93 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 93), align 8
  %v94 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 94), align 8
  %v95 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 95), align 8
  %v96 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 96), align 8
  %v97 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 97), align 8
  %v98 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 98), align 8
  %v99 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 99), align 8
  %v100 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 100), align 8
  %v101 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 101), align 8
  %v102 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 102), align 8
  %v103 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 103), align 8
  %v104 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 104), align 8
  %v105 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 105), align 8
  %v106 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 106), align 8
  %v107 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 107), align 8
  %v108 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 108), align 8
  %v109 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 109), align 8
  %v110 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 110), align 8
  %v111 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 111), align 8
  %v112 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 112), align 8
  %v113 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 113), align 8
  %v114 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 114), align 8
  %v115 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 115), align 8
  %v116 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 116), align 8
  %v117 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 117), align 8
  %v118 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 118), align 8
  %v119 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 119), align 8
  %v120 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 120), align 8
  %v121 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 121), align 8
  %v122 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 122), align 8
  %v123 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 123), align 8
  %v124 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 124), align 8
  %v125 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 125), align 8
  %v126 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 126), align 8
  %v127 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 127), align 8
  %v128 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 128), align 8
  %v129 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 129), align 8
  %v130 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 130), align 8
  %v131 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 131), align 8
  %v132 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 132), align 8
  %v133 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 133), align 8
  %v134 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 134), align 8
  %v135 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 135), align 8
  %v136 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 136), align 8
  %v137 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 137), align 8
  %v138 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 138), align 8
  %v139 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 139), align 8
  %v140 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 140), align 8
  %v141 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 141), align 8
  %v142 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 142), align 8
  %v143 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 143), align 8
  %v144 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 144), align 8
  %v145 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 145), align 8
  %v146 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 146), align 8
  %v147 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 147), align 8
  %v148 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 148), align 8
  %v149 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 149), align 8
  %v150 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 150), align 8
  %v151 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 151), align 8
  %v152 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 152), align 8
  %v153 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 153), align 8
  %v154 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 154), align 8
  %v155 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 155), align 8
  %v156 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 156), align 8
  %v157 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 157), align 8
  %v158 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 158), align 8
  %v159 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 159), align 8
  %v160 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 160), align 8
  %v161 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 161), align 8
  %v162 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 162), align 8
  %v163 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 163), align 8
  %v164 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 164), align 8
  %v165 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 165), align 8
  %v166 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 166), align 8
  %v167 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 167), align 8
  %v168 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 168), align 8
  %v169 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 169), align 8
  %v170 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 170), align 8
  %v171 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 171), align 8
  %v172 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 172), align 8
  %v173 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 173), align 8
  %v174 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 174), align 8
  %v175 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 175), align 8
  %v176 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 176), align 8
  %v177 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 177), align 8
  %v178 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 178), align 8
  %v179 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 179), align 8
  %v180 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 180), align 8
  %v181 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 181), align 8
  %v182 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 182), align 8
  %v183 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 183), align 8
  %v184 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 184), align 8
  %v185 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 185), align 8
  %v186 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 186), align 8
  %v187 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 187), align 8
  %v188 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 188), align 8
  %v189 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 189), align 8
  %v190 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 190), align 8
  %v191 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 191), align 8
  %v192 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 192), align 8
  %v193 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 193), align 8
  %v194 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 194), align 8
  %v195 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 195), align 8
  %v196 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 196), align 8
  %v197 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 197), align 8
  %v198 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 198), align 8
  %v199 = load volatile double, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 199), align 8

  %x0 = call double @llvm.sqrt.f64(double %v199)
  %x1 = fdiv double %v197, %v198
  %x2 = fadd double %x0, %x1

  store volatile double %v0, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 0), align 8
  store volatile double %v1, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 1), align 8
  store volatile double %v2, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 2), align 8
  store volatile double %v3, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 3), align 8
  store volatile double %v4, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 4), align 8
  store volatile double %v5, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 5), align 8
  store volatile double %v6, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 6), align 8
  store volatile double %v7, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 7), align 8
  store volatile double %v8, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 8), align 8
  store volatile double %v9, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 9), align 8
  store volatile double %v10, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 10), align 8
  store volatile double %v11, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 11), align 8
  store volatile double %v12, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 12), align 8
  store volatile double %v13, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 13), align 8
  store volatile double %v14, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 14), align 8
  store volatile double %v15, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 15), align 8
  store volatile double %v16, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 16), align 8
  store volatile double %v17, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 17), align 8
  store volatile double %v18, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 18), align 8
  store volatile double %v19, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 19), align 8
  store volatile double %v20, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 20), align 8
  store volatile double %v21, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 21), align 8
  store volatile double %v22, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 22), align 8
  store volatile double %v23, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 23), align 8
  store volatile double %v24, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 24), align 8
  store volatile double %v25, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 25), align 8
  store volatile double %v26, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 26), align 8
  store volatile double %v27, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 27), align 8
  store volatile double %v28, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 28), align 8
  store volatile double %v29, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 29), align 8
  store volatile double %v30, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 30), align 8
  store volatile double %v31, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 31), align 8
  store volatile double %v32, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 32), align 8
  store volatile double %v33, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 33), align 8
  store volatile double %v34, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 34), align 8
  store volatile double %v35, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 35), align 8
  store volatile double %v36, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 36), align 8
  store volatile double %v37, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 37), align 8
  store volatile double %v38, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 38), align 8
  store volatile double %v39, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 39), align 8
  store volatile double %v40, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 40), align 8
  store volatile double %v41, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 41), align 8
  store volatile double %v42, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 42), align 8
  store volatile double %v43, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 43), align 8
  store volatile double %v44, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 44), align 8
  store volatile double %v45, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 45), align 8
  store volatile double %v46, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 46), align 8
  store volatile double %v47, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 47), align 8
  store volatile double %v48, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 48), align 8
  store volatile double %v49, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 49), align 8
  store volatile double %v50, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 50), align 8
  store volatile double %v51, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 51), align 8
  store volatile double %v52, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 52), align 8
  store volatile double %v53, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 53), align 8
  store volatile double %v54, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 54), align 8
  store volatile double %v55, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 55), align 8
  store volatile double %v56, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 56), align 8
  store volatile double %v57, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 57), align 8
  store volatile double %v58, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 58), align 8
  store volatile double %v59, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 59), align 8
  store volatile double %v60, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 60), align 8
  store volatile double %v61, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 61), align 8
  store volatile double %v62, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 62), align 8
  store volatile double %v63, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 63), align 8
  store volatile double %v64, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 64), align 8
  store volatile double %v65, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 65), align 8
  store volatile double %v66, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 66), align 8
  store volatile double %v67, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 67), align 8
  store volatile double %v68, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 68), align 8
  store volatile double %v69, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 69), align 8
  store volatile double %v70, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 70), align 8
  store volatile double %v71, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 71), align 8
  store volatile double %v72, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 72), align 8
  store volatile double %v73, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 73), align 8
  store volatile double %v74, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 74), align 8
  store volatile double %v75, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 75), align 8
  store volatile double %v76, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 76), align 8
  store volatile double %v77, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 77), align 8
  store volatile double %v78, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 78), align 8
  store volatile double %v79, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 79), align 8
  store volatile double %v80, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 80), align 8
  store volatile double %v81, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 81), align 8
  store volatile double %v82, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 82), align 8
  store volatile double %v83, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 83), align 8
  store volatile double %v84, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 84), align 8
  store volatile double %v85, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 85), align 8
  store volatile double %v86, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 86), align 8
  store volatile double %v87, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 87), align 8
  store volatile double %v88, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 88), align 8
  store volatile double %v89, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 89), align 8
  store volatile double %v90, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 90), align 8
  store volatile double %v91, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 91), align 8
  store volatile double %v92, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 92), align 8
  store volatile double %v93, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 93), align 8
  store volatile double %v94, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 94), align 8
  store volatile double %v95, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 95), align 8
  store volatile double %v96, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 96), align 8
  store volatile double %v97, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 97), align 8
  store volatile double %v98, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 98), align 8
  store volatile double %v99, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 99), align 8
  store volatile double %v100, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 100), align 8
  store volatile double %v101, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 101), align 8
  store volatile double %v102, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 102), align 8
  store volatile double %v103, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 103), align 8
  store volatile double %v104, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 104), align 8
  store volatile double %v105, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 105), align 8
  store volatile double %v106, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 106), align 8
  store volatile double %v107, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 107), align 8
  store volatile double %v108, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 108), align 8
  store volatile double %v109, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 109), align 8
  store volatile double %v110, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 110), align 8
  store volatile double %v111, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 111), align 8
  store volatile double %v112, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 112), align 8
  store volatile double %v113, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 113), align 8
  store volatile double %v114, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 114), align 8
  store volatile double %v115, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 115), align 8
  store volatile double %v116, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 116), align 8
  store volatile double %v117, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 117), align 8
  store volatile double %v118, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 118), align 8
  store volatile double %v119, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 119), align 8
  store volatile double %v120, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 120), align 8
  store volatile double %v121, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 121), align 8
  store volatile double %v122, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 122), align 8
  store volatile double %v123, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 123), align 8
  store volatile double %v124, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 124), align 8
  store volatile double %v125, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 125), align 8
  store volatile double %v126, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 126), align 8
  store volatile double %v127, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 127), align 8
  store volatile double %v128, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 128), align 8
  store volatile double %v129, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 129), align 8
  store volatile double %v130, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 130), align 8
  store volatile double %v131, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 131), align 8
  store volatile double %v132, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 132), align 8
  store volatile double %v133, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 133), align 8
  store volatile double %v134, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 134), align 8
  store volatile double %v135, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 135), align 8
  store volatile double %v136, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 136), align 8
  store volatile double %v137, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 137), align 8
  store volatile double %v138, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 138), align 8
  store volatile double %v139, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 139), align 8
  store volatile double %v140, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 140), align 8
  store volatile double %v141, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 141), align 8
  store volatile double %v142, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 142), align 8
  store volatile double %v143, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 143), align 8
  store volatile double %v144, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 144), align 8
  store volatile double %v145, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 145), align 8
  store volatile double %v146, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 146), align 8
  store volatile double %v147, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 147), align 8
  store volatile double %v148, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 148), align 8
  store volatile double %v149, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 149), align 8
  store volatile double %v150, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 150), align 8
  store volatile double %v151, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 151), align 8
  store volatile double %v152, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 152), align 8
  store volatile double %v153, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 153), align 8
  store volatile double %v154, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 154), align 8
  store volatile double %v155, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 155), align 8
  store volatile double %v156, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 156), align 8
  store volatile double %v157, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 157), align 8
  store volatile double %v158, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 158), align 8
  store volatile double %v159, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 159), align 8
  store volatile double %v160, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 160), align 8
  store volatile double %v161, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 161), align 8
  store volatile double %v162, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 162), align 8
  store volatile double %v163, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 163), align 8
  store volatile double %v164, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 164), align 8
  store volatile double %v165, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 165), align 8
  store volatile double %v166, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 166), align 8
  store volatile double %v167, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 167), align 8
  store volatile double %v168, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 168), align 8
  store volatile double %v169, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 169), align 8
  store volatile double %v170, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 170), align 8
  store volatile double %v171, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 171), align 8
  store volatile double %v172, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 172), align 8
  store volatile double %v173, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 173), align 8
  store volatile double %v174, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 174), align 8
  store volatile double %v175, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 175), align 8
  store volatile double %v176, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 176), align 8
  store volatile double %v177, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 177), align 8
  store volatile double %v178, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 178), align 8
  store volatile double %v179, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 179), align 8
  store volatile double %v180, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 180), align 8
  store volatile double %v181, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 181), align 8
  store volatile double %v182, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 182), align 8
  store volatile double %v183, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 183), align 8
  store volatile double %v184, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 184), align 8
  store volatile double %v185, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 185), align 8
  store volatile double %v186, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 186), align 8
  store volatile double %v187, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 187), align 8
  store volatile double %v188, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 188), align 8
  store volatile double %v189, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 189), align 8
  store volatile double %v190, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 190), align 8
  store volatile double %v191, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 191), align 8
  store volatile double %v192, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 192), align 8
  store volatile double %v193, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 193), align 8
  store volatile double %v194, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 194), align 8
  store volatile double %v195, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 195), align 8
  store volatile double %v196, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 196), align 8
  store volatile double %v197, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 197), align 8
  store volatile double %v198, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 198), align 8
  store volatile double %v199, double* getelementptr inbounds ([260 x double], [260 x double]* @gf64, i64 0, i64 199), align 8

  ret double %x2
}

;;;
;;; *** Test if FSQRT (FP) Generates Results in Vector Element0 Registers ***
;;;

define float @sqrt_fp_lo_regs(float %i) nounwind readnone {
  %v0 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 0), align 8
  %v1 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 1), align 8
  %v2 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 2), align 8
  %v3 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 3), align 8
  %v4 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 4), align 8
  %v5 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 5), align 8
  %v6 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 6), align 8
  %v7 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 7), align 8
  %v8 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 8), align 8
  %v9 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 9), align 8
  %v10 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 10), align 8
  %v11 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 11), align 8
  %v12 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 12), align 8
  %v13 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 13), align 8
  %v14 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 14), align 8
  %v15 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 15), align 8
  %v16 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 16), align 8
  %v17 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 17), align 8
  %v18 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 18), align 8
  %v19 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 19), align 8
  %v20 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 20), align 8
  %v21 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 21), align 8
  %v22 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 22), align 8
  %v23 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 23), align 8
  %v24 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 24), align 8
  %v25 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 25), align 8
  %v26 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 26), align 8
  %v27 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 27), align 8
  %v28 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 28), align 8
  %v29 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 29), align 8
  %v30 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 30), align 8
  %v31 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 31), align 8
  %v32 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 32), align 8
  %v33 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 33), align 8
  %v34 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 34), align 8
  %v35 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 35), align 8
  %v36 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 36), align 8
  %v37 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 37), align 8
  %v38 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 38), align 8
  %v39 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 39), align 8
  %v40 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 40), align 8
  %v41 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 41), align 8
  %v42 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 42), align 8
  %v43 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 43), align 8
  %v44 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 44), align 8
  %v45 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 45), align 8
  %v46 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 46), align 8
  %v47 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 47), align 8
  %v48 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 48), align 8
  %v49 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 49), align 8
  %v50 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 50), align 8
  %v51 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 51), align 8
  %v52 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 52), align 8
  %v53 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 53), align 8
  %v54 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 54), align 8
  %v55 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 55), align 8
  %v56 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 56), align 8
  %v57 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 57), align 8
  %v58 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 58), align 8
  %v59 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 59), align 8
  %v60 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 60), align 8
  %v61 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 61), align 8
  %v62 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 62), align 8
  %v63 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 63), align 8
  %v64 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 64), align 8
  %v65 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 65), align 8
  %v66 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 66), align 8
  %v67 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 67), align 8
  %v68 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 68), align 8
  %v69 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 69), align 8
  %v70 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 70), align 8
  %v71 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 71), align 8
  %v72 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 72), align 8
  %v73 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 73), align 8
  %v74 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 74), align 8
  %v75 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 75), align 8
  %v76 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 76), align 8
  %v77 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 77), align 8
  %v78 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 78), align 8
  %v79 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 79), align 8
  %v80 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 80), align 8
  %v81 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 81), align 8
  %v82 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 82), align 8
  %v83 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 83), align 8
  %v84 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 84), align 8
  %v85 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 85), align 8
  %v86 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 86), align 8
  %v87 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 87), align 8
  %v88 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 88), align 8
  %v89 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 89), align 8
  %v90 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 90), align 8
  %v91 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 91), align 8
  %v92 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 92), align 8
  %v93 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 93), align 8
  %v94 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 94), align 8
  %v95 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 95), align 8
  %v96 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 96), align 8
  %v97 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 97), align 8
  %v98 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 98), align 8
  %v99 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 99), align 8
  %v100 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 100), align 8
  %v101 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 101), align 8
  %v102 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 102), align 8
  %v103 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 103), align 8
  %v104 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 104), align 8
  %v105 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 105), align 8
  %v106 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 106), align 8
  %v107 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 107), align 8
  %v108 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 108), align 8
  %v109 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 109), align 8
  %v110 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 110), align 8
  %v111 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 111), align 8
  %v112 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 112), align 8
  %v113 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 113), align 8
  %v114 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 114), align 8
  %v115 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 115), align 8
  %v116 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 116), align 8
  %v117 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 117), align 8
  %v118 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 118), align 8
  %v119 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 119), align 8
  %v120 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 120), align 8
  %v121 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 121), align 8
  %v122 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 122), align 8
  %v123 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 123), align 8
  %v124 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 124), align 8
  %v125 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 125), align 8
  %v126 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 126), align 8
  %v127 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 127), align 8
  %v128 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 128), align 8
  %v129 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 129), align 8
  %v130 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 130), align 8
  %v131 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 131), align 8
  %v132 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 132), align 8
  %v133 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 133), align 8
  %v134 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 134), align 8
  %v135 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 135), align 8
  %v136 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 136), align 8
  %v137 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 137), align 8
  %v138 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 138), align 8
  %v139 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 139), align 8
  %v140 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 140), align 8
  %v141 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 141), align 8
  %v142 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 142), align 8
  %v143 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 143), align 8
  %v144 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 144), align 8
  %v145 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 145), align 8
  %v146 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 146), align 8
  %v147 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 147), align 8
  %v148 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 148), align 8
  %v149 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 149), align 8
  %v150 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 150), align 8
  %v151 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 151), align 8
  %v152 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 152), align 8
  %v153 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 153), align 8
  %v154 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 154), align 8
  %v155 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 155), align 8
  %v156 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 156), align 8
  %v157 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 157), align 8
  %v158 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 158), align 8
  %v159 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 159), align 8
  %v160 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 160), align 8
  %v161 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 161), align 8
  %v162 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 162), align 8
  %v163 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 163), align 8
  %v164 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 164), align 8
  %v165 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 165), align 8
  %v166 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 166), align 8
  %v167 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 167), align 8
  %v168 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 168), align 8
  %v169 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 169), align 8
  %v170 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 170), align 8
  %v171 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 171), align 8
  %v172 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 172), align 8
  %v173 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 173), align 8
  %v174 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 174), align 8
  %v175 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 175), align 8
  %v176 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 176), align 8
  %v177 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 177), align 8
  %v178 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 178), align 8
  %v179 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 179), align 8
  %v180 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 180), align 8
  %v181 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 181), align 8
  %v182 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 182), align 8
  %v183 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 183), align 8
  %v184 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 184), align 8
  %v185 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 185), align 8
  %v186 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 186), align 8
  %v187 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 187), align 8
  %v188 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 188), align 8
  %v189 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 189), align 8
  %v190 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 190), align 8
  %v191 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 191), align 8
  %v192 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 192), align 8
  %v193 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 193), align 8
  %v194 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 194), align 8
  %v195 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 195), align 8
  %v196 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 196), align 8
  %v197 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 197), align 8
  %v198 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 198), align 8
  %v199 = load volatile float, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 199), align 8

  %x0 = call float @llvm.sqrt.f32(float %v199)
  %x1 = fdiv float %v197, %v198
  %x2 = fadd float %x0, %x1

  store volatile float %v0, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 0), align 8
  store volatile float %v1, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 1), align 8
  store volatile float %v2, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 2), align 8
  store volatile float %v3, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 3), align 8
  store volatile float %v4, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 4), align 8
  store volatile float %v5, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 5), align 8
  store volatile float %v6, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 6), align 8
  store volatile float %v7, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 7), align 8
  store volatile float %v8, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 8), align 8
  store volatile float %v9, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 9), align 8
  store volatile float %v10, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 10), align 8
  store volatile float %v11, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 11), align 8
  store volatile float %v12, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 12), align 8
  store volatile float %v13, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 13), align 8
  store volatile float %v14, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 14), align 8
  store volatile float %v15, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 15), align 8
  store volatile float %v16, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 16), align 8
  store volatile float %v17, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 17), align 8
  store volatile float %v18, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 18), align 8
  store volatile float %v19, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 19), align 8
  store volatile float %v20, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 20), align 8
  store volatile float %v21, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 21), align 8
  store volatile float %v22, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 22), align 8
  store volatile float %v23, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 23), align 8
  store volatile float %v24, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 24), align 8
  store volatile float %v25, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 25), align 8
  store volatile float %v26, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 26), align 8
  store volatile float %v27, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 27), align 8
  store volatile float %v28, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 28), align 8
  store volatile float %v29, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 29), align 8
  store volatile float %v30, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 30), align 8
  store volatile float %v31, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 31), align 8
  store volatile float %v32, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 32), align 8
  store volatile float %v33, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 33), align 8
  store volatile float %v34, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 34), align 8
  store volatile float %v35, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 35), align 8
  store volatile float %v36, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 36), align 8
  store volatile float %v37, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 37), align 8
  store volatile float %v38, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 38), align 8
  store volatile float %v39, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 39), align 8
  store volatile float %v40, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 40), align 8
  store volatile float %v41, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 41), align 8
  store volatile float %v42, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 42), align 8
  store volatile float %v43, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 43), align 8
  store volatile float %v44, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 44), align 8
  store volatile float %v45, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 45), align 8
  store volatile float %v46, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 46), align 8
  store volatile float %v47, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 47), align 8
  store volatile float %v48, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 48), align 8
  store volatile float %v49, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 49), align 8
  store volatile float %v50, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 50), align 8
  store volatile float %v51, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 51), align 8
  store volatile float %v52, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 52), align 8
  store volatile float %v53, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 53), align 8
  store volatile float %v54, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 54), align 8
  store volatile float %v55, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 55), align 8
  store volatile float %v56, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 56), align 8
  store volatile float %v57, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 57), align 8
  store volatile float %v58, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 58), align 8
  store volatile float %v59, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 59), align 8
  store volatile float %v60, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 60), align 8
  store volatile float %v61, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 61), align 8
  store volatile float %v62, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 62), align 8
  store volatile float %v63, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 63), align 8
  store volatile float %v64, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 64), align 8
  store volatile float %v65, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 65), align 8
  store volatile float %v66, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 66), align 8
  store volatile float %v67, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 67), align 8
  store volatile float %v68, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 68), align 8
  store volatile float %v69, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 69), align 8
  store volatile float %v70, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 70), align 8
  store volatile float %v71, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 71), align 8
  store volatile float %v72, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 72), align 8
  store volatile float %v73, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 73), align 8
  store volatile float %v74, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 74), align 8
  store volatile float %v75, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 75), align 8
  store volatile float %v76, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 76), align 8
  store volatile float %v77, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 77), align 8
  store volatile float %v78, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 78), align 8
  store volatile float %v79, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 79), align 8
  store volatile float %v80, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 80), align 8
  store volatile float %v81, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 81), align 8
  store volatile float %v82, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 82), align 8
  store volatile float %v83, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 83), align 8
  store volatile float %v84, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 84), align 8
  store volatile float %v85, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 85), align 8
  store volatile float %v86, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 86), align 8
  store volatile float %v87, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 87), align 8
  store volatile float %v88, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 88), align 8
  store volatile float %v89, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 89), align 8
  store volatile float %v90, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 90), align 8
  store volatile float %v91, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 91), align 8
  store volatile float %v92, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 92), align 8
  store volatile float %v93, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 93), align 8
  store volatile float %v94, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 94), align 8
  store volatile float %v95, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 95), align 8
  store volatile float %v96, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 96), align 8
  store volatile float %v97, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 97), align 8
  store volatile float %v98, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 98), align 8
  store volatile float %v99, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 99), align 8
  store volatile float %v100, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 100), align 8
  store volatile float %v101, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 101), align 8
  store volatile float %v102, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 102), align 8
  store volatile float %v103, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 103), align 8
  store volatile float %v104, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 104), align 8
  store volatile float %v105, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 105), align 8
  store volatile float %v106, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 106), align 8
  store volatile float %v107, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 107), align 8
  store volatile float %v108, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 108), align 8
  store volatile float %v109, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 109), align 8
  store volatile float %v110, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 110), align 8
  store volatile float %v111, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 111), align 8
  store volatile float %v112, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 112), align 8
  store volatile float %v113, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 113), align 8
  store volatile float %v114, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 114), align 8
  store volatile float %v115, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 115), align 8
  store volatile float %v116, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 116), align 8
  store volatile float %v117, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 117), align 8
  store volatile float %v118, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 118), align 8
  store volatile float %v119, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 119), align 8
  store volatile float %v120, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 120), align 8
  store volatile float %v121, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 121), align 8
  store volatile float %v122, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 122), align 8
  store volatile float %v123, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 123), align 8
  store volatile float %v124, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 124), align 8
  store volatile float %v125, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 125), align 8
  store volatile float %v126, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 126), align 8
  store volatile float %v127, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 127), align 8
  store volatile float %v128, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 128), align 8
  store volatile float %v129, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 129), align 8
  store volatile float %v130, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 130), align 8
  store volatile float %v131, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 131), align 8
  store volatile float %v132, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 132), align 8
  store volatile float %v133, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 133), align 8
  store volatile float %v134, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 134), align 8
  store volatile float %v135, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 135), align 8
  store volatile float %v136, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 136), align 8
  store volatile float %v137, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 137), align 8
  store volatile float %v138, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 138), align 8
  store volatile float %v139, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 139), align 8
  store volatile float %v140, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 140), align 8
  store volatile float %v141, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 141), align 8
  store volatile float %v142, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 142), align 8
  store volatile float %v143, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 143), align 8
  store volatile float %v144, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 144), align 8
  store volatile float %v145, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 145), align 8
  store volatile float %v146, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 146), align 8
  store volatile float %v147, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 147), align 8
  store volatile float %v148, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 148), align 8
  store volatile float %v149, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 149), align 8
  store volatile float %v150, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 150), align 8
  store volatile float %v151, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 151), align 8
  store volatile float %v152, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 152), align 8
  store volatile float %v153, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 153), align 8
  store volatile float %v154, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 154), align 8
  store volatile float %v155, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 155), align 8
  store volatile float %v156, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 156), align 8
  store volatile float %v157, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 157), align 8
  store volatile float %v158, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 158), align 8
  store volatile float %v159, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 159), align 8
  store volatile float %v160, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 160), align 8
  store volatile float %v161, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 161), align 8
  store volatile float %v162, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 162), align 8
  store volatile float %v163, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 163), align 8
  store volatile float %v164, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 164), align 8
  store volatile float %v165, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 165), align 8
  store volatile float %v166, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 166), align 8
  store volatile float %v167, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 167), align 8
  store volatile float %v168, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 168), align 8
  store volatile float %v169, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 169), align 8
  store volatile float %v170, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 170), align 8
  store volatile float %v171, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 171), align 8
  store volatile float %v172, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 172), align 8
  store volatile float %v173, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 173), align 8
  store volatile float %v174, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 174), align 8
  store volatile float %v175, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 175), align 8
  store volatile float %v176, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 176), align 8
  store volatile float %v177, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 177), align 8
  store volatile float %v178, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 178), align 8
  store volatile float %v179, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 179), align 8
  store volatile float %v180, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 180), align 8
  store volatile float %v181, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 181), align 8
  store volatile float %v182, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 182), align 8
  store volatile float %v183, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 183), align 8
  store volatile float %v184, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 184), align 8
  store volatile float %v185, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 185), align 8
  store volatile float %v186, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 186), align 8
  store volatile float %v187, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 187), align 8
  store volatile float %v188, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 188), align 8
  store volatile float %v189, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 189), align 8
  store volatile float %v190, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 190), align 8
  store volatile float %v191, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 191), align 8
  store volatile float %v192, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 192), align 8
  store volatile float %v193, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 193), align 8
  store volatile float %v194, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 194), align 8
  store volatile float %v195, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 195), align 8
  store volatile float %v196, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 196), align 8
  store volatile float %v197, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 197), align 8
  store volatile float %v198, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 198), align 8
  store volatile float %v199, float* getelementptr inbounds ([260 x float], [260 x float]* @gf32, i64 0, i64 199), align 8

  ret float %x2
}

;;;
;;; Test the Vector DP Registers
;;;

; CHECK-LABEL: use_130_v2f64_regs:
; CHECK: ldd,s [%o0+2032], %f254 /*v2*/
; CHECK: std,s %f254, [%o0+2032] /*v2*/
; CHECK: retl

define void @use_130_v2f64_regs() nounwind readnone {
  %v0 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 0), align 8
  %v1 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 1), align 8
  %v2 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 2), align 8
  %v3 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 3), align 8
  %v4 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 4), align 8
  %v5 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 5), align 8
  %v6 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 6), align 8
  %v7 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 7), align 8
  %v8 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 8), align 8
  %v9 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 9), align 8
  %v10 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 10), align 8
  %v11 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 11), align 8
  %v12 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 12), align 8
  %v13 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 13), align 8
  %v14 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 14), align 8
  %v15 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 15), align 8
  %v16 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 16), align 8
  %v17 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 17), align 8
  %v18 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 18), align 8
  %v19 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 19), align 8
  %v20 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 20), align 8
  %v21 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 21), align 8
  %v22 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 22), align 8
  %v23 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 23), align 8
  %v24 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 24), align 8
  %v25 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 25), align 8
  %v26 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 26), align 8
  %v27 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 27), align 8
  %v28 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 28), align 8
  %v29 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 29), align 8
  %v30 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 30), align 8
  %v31 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 31), align 8
  %v32 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 32), align 8
  %v33 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 33), align 8
  %v34 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 34), align 8
  %v35 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 35), align 8
  %v36 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 36), align 8
  %v37 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 37), align 8
  %v38 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 38), align 8
  %v39 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 39), align 8
  %v40 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 40), align 8
  %v41 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 41), align 8
  %v42 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 42), align 8
  %v43 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 43), align 8
  %v44 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 44), align 8
  %v45 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 45), align 8
  %v46 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 46), align 8
  %v47 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 47), align 8
  %v48 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 48), align 8
  %v49 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 49), align 8
  %v50 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 50), align 8
  %v51 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 51), align 8
  %v52 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 52), align 8
  %v53 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 53), align 8
  %v54 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 54), align 8
  %v55 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 55), align 8
  %v56 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 56), align 8
  %v57 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 57), align 8
  %v58 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 58), align 8
  %v59 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 59), align 8
  %v60 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 60), align 8
  %v61 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 61), align 8
  %v62 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 62), align 8
  %v63 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 63), align 8
  %v64 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 64), align 8
  %v65 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 65), align 8
  %v66 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 66), align 8
  %v67 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 67), align 8
  %v68 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 68), align 8
  %v69 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 69), align 8
  %v70 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 70), align 8
  %v71 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 71), align 8
  %v72 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 72), align 8
  %v73 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 73), align 8
  %v74 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 74), align 8
  %v75 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 75), align 8
  %v76 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 76), align 8
  %v77 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 77), align 8
  %v78 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 78), align 8
  %v79 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 79), align 8
  %v80 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 80), align 8
  %v81 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 81), align 8
  %v82 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 82), align 8
  %v83 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 83), align 8
  %v84 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 84), align 8
  %v85 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 85), align 8
  %v86 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 86), align 8
  %v87 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 87), align 8
  %v88 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 88), align 8
  %v89 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 89), align 8
  %v90 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 90), align 8
  %v91 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 91), align 8
  %v92 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 92), align 8
  %v93 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 93), align 8
  %v94 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 94), align 8
  %v95 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 95), align 8
  %v96 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 96), align 8
  %v97 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 97), align 8
  %v98 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 98), align 8
  %v99 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 99), align 8
  %v100 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 100), align 8
  %v101 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 101), align 8
  %v102 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 102), align 8
  %v103 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 103), align 8
  %v104 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 104), align 8
  %v105 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 105), align 8
  %v106 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 106), align 8
  %v107 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 107), align 8
  %v108 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 108), align 8
  %v109 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 109), align 8
  %v110 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 110), align 8
  %v111 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 111), align 8
  %v112 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 112), align 8
  %v113 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 113), align 8
  %v114 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 114), align 8
  %v115 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 115), align 8
  %v116 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 116), align 8
  %v117 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 117), align 8
  %v118 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 118), align 8
  %v119 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 119), align 8
  %v120 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 120), align 8
  %v121 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 121), align 8
  %v122 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 122), align 8
  %v123 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 123), align 8
  %v124 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 124), align 8
  %v125 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 125), align 8
  %v126 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 126), align 8
  %v127 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 127), align 8
  %v128 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 128), align 8
  %v129 = load volatile <2 x double>, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 129), align 8

  store volatile <2 x double> %v0, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 0), align 8
  store volatile <2 x double> %v1, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 1), align 8
  store volatile <2 x double> %v2, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 2), align 8
  store volatile <2 x double> %v3, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 3), align 8
  store volatile <2 x double> %v4, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 4), align 8
  store volatile <2 x double> %v5, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 5), align 8
  store volatile <2 x double> %v6, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 6), align 8
  store volatile <2 x double> %v7, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 7), align 8
  store volatile <2 x double> %v8, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 8), align 8
  store volatile <2 x double> %v9, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 9), align 8
  store volatile <2 x double> %v10, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 10), align 8
  store volatile <2 x double> %v11, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 11), align 8
  store volatile <2 x double> %v12, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 12), align 8
  store volatile <2 x double> %v13, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 13), align 8
  store volatile <2 x double> %v14, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 14), align 8
  store volatile <2 x double> %v15, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 15), align 8
  store volatile <2 x double> %v16, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 16), align 8
  store volatile <2 x double> %v17, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 17), align 8
  store volatile <2 x double> %v18, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 18), align 8
  store volatile <2 x double> %v19, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 19), align 8
  store volatile <2 x double> %v20, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 20), align 8
  store volatile <2 x double> %v21, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 21), align 8
  store volatile <2 x double> %v22, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 22), align 8
  store volatile <2 x double> %v23, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 23), align 8
  store volatile <2 x double> %v24, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 24), align 8
  store volatile <2 x double> %v25, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 25), align 8
  store volatile <2 x double> %v26, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 26), align 8
  store volatile <2 x double> %v27, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 27), align 8
  store volatile <2 x double> %v28, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 28), align 8
  store volatile <2 x double> %v29, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 29), align 8
  store volatile <2 x double> %v30, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 30), align 8
  store volatile <2 x double> %v31, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 31), align 8
  store volatile <2 x double> %v32, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 32), align 8
  store volatile <2 x double> %v33, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 33), align 8
  store volatile <2 x double> %v34, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 34), align 8
  store volatile <2 x double> %v35, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 35), align 8
  store volatile <2 x double> %v36, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 36), align 8
  store volatile <2 x double> %v37, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 37), align 8
  store volatile <2 x double> %v38, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 38), align 8
  store volatile <2 x double> %v39, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 39), align 8
  store volatile <2 x double> %v40, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 40), align 8
  store volatile <2 x double> %v41, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 41), align 8
  store volatile <2 x double> %v42, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 42), align 8
  store volatile <2 x double> %v43, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 43), align 8
  store volatile <2 x double> %v44, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 44), align 8
  store volatile <2 x double> %v45, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 45), align 8
  store volatile <2 x double> %v46, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 46), align 8
  store volatile <2 x double> %v47, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 47), align 8
  store volatile <2 x double> %v48, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 48), align 8
  store volatile <2 x double> %v49, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 49), align 8
  store volatile <2 x double> %v50, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 50), align 8
  store volatile <2 x double> %v51, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 51), align 8
  store volatile <2 x double> %v52, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 52), align 8
  store volatile <2 x double> %v53, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 53), align 8
  store volatile <2 x double> %v54, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 54), align 8
  store volatile <2 x double> %v55, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 55), align 8
  store volatile <2 x double> %v56, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 56), align 8
  store volatile <2 x double> %v57, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 57), align 8
  store volatile <2 x double> %v58, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 58), align 8
  store volatile <2 x double> %v59, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 59), align 8
  store volatile <2 x double> %v60, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 60), align 8
  store volatile <2 x double> %v61, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 61), align 8
  store volatile <2 x double> %v62, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 62), align 8
  store volatile <2 x double> %v63, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 63), align 8
  store volatile <2 x double> %v64, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 64), align 8
  store volatile <2 x double> %v65, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 65), align 8
  store volatile <2 x double> %v66, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 66), align 8
  store volatile <2 x double> %v67, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 67), align 8
  store volatile <2 x double> %v68, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 68), align 8
  store volatile <2 x double> %v69, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 69), align 8
  store volatile <2 x double> %v70, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 70), align 8
  store volatile <2 x double> %v71, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 71), align 8
  store volatile <2 x double> %v72, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 72), align 8
  store volatile <2 x double> %v73, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 73), align 8
  store volatile <2 x double> %v74, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 74), align 8
  store volatile <2 x double> %v75, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 75), align 8
  store volatile <2 x double> %v76, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 76), align 8
  store volatile <2 x double> %v77, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 77), align 8
  store volatile <2 x double> %v78, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 78), align 8
  store volatile <2 x double> %v79, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 79), align 8
  store volatile <2 x double> %v80, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 80), align 8
  store volatile <2 x double> %v81, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 81), align 8
  store volatile <2 x double> %v82, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 82), align 8
  store volatile <2 x double> %v83, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 83), align 8
  store volatile <2 x double> %v84, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 84), align 8
  store volatile <2 x double> %v85, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 85), align 8
  store volatile <2 x double> %v86, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 86), align 8
  store volatile <2 x double> %v87, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 87), align 8
  store volatile <2 x double> %v88, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 88), align 8
  store volatile <2 x double> %v89, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 89), align 8
  store volatile <2 x double> %v90, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 90), align 8
  store volatile <2 x double> %v91, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 91), align 8
  store volatile <2 x double> %v92, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 92), align 8
  store volatile <2 x double> %v93, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 93), align 8
  store volatile <2 x double> %v94, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 94), align 8
  store volatile <2 x double> %v95, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 95), align 8
  store volatile <2 x double> %v96, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 96), align 8
  store volatile <2 x double> %v97, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 97), align 8
  store volatile <2 x double> %v98, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 98), align 8
  store volatile <2 x double> %v99, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 99), align 8
  store volatile <2 x double> %v100, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 100), align 8
  store volatile <2 x double> %v101, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 101), align 8
  store volatile <2 x double> %v102, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 102), align 8
  store volatile <2 x double> %v103, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 103), align 8
  store volatile <2 x double> %v104, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 104), align 8
  store volatile <2 x double> %v105, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 105), align 8
  store volatile <2 x double> %v106, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 106), align 8
  store volatile <2 x double> %v107, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 107), align 8
  store volatile <2 x double> %v108, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 108), align 8
  store volatile <2 x double> %v109, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 109), align 8
  store volatile <2 x double> %v110, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 110), align 8
  store volatile <2 x double> %v111, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 111), align 8
  store volatile <2 x double> %v112, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 112), align 8
  store volatile <2 x double> %v113, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 113), align 8
  store volatile <2 x double> %v114, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 114), align 8
  store volatile <2 x double> %v115, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 115), align 8
  store volatile <2 x double> %v116, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 116), align 8
  store volatile <2 x double> %v117, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 117), align 8
  store volatile <2 x double> %v118, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 118), align 8
  store volatile <2 x double> %v119, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 119), align 8
  store volatile <2 x double> %v120, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 120), align 8
  store volatile <2 x double> %v121, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 121), align 8
  store volatile <2 x double> %v122, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 122), align 8
  store volatile <2 x double> %v123, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 123), align 8
  store volatile <2 x double> %v124, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 124), align 8
  store volatile <2 x double> %v125, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 125), align 8
  store volatile <2 x double> %v126, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 126), align 8
  store volatile <2 x double> %v127, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 127), align 8
  store volatile <2 x double> %v128, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 128), align 8
  store volatile <2 x double> %v129, <2 x double>* getelementptr inbounds ([130 x <2 x double>], [130 x <2 x double>]* @gv2f64, i64 0, i64 129), align 8

  ret void
}

;;;
;;; Test the Vector FP Registers
;;;

; CHECK-LABEL: use_130_v2f32_regs:
; CHECK: ldf,s [%o0+1016], %f254 /*v2*/
; CHECK: stf,s %f254, [%o0+1016] /*v2*/
; CHECK: retl

define void @use_130_v2f32_regs() nounwind readnone {
  %v0 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 0), align 8
  %v1 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 1), align 8
  %v2 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 2), align 8
  %v3 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 3), align 8
  %v4 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 4), align 8
  %v5 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 5), align 8
  %v6 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 6), align 8
  %v7 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 7), align 8
  %v8 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 8), align 8
  %v9 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 9), align 8
  %v10 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 10), align 8
  %v11 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 11), align 8
  %v12 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 12), align 8
  %v13 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 13), align 8
  %v14 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 14), align 8
  %v15 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 15), align 8
  %v16 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 16), align 8
  %v17 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 17), align 8
  %v18 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 18), align 8
  %v19 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 19), align 8
  %v20 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 20), align 8
  %v21 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 21), align 8
  %v22 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 22), align 8
  %v23 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 23), align 8
  %v24 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 24), align 8
  %v25 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 25), align 8
  %v26 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 26), align 8
  %v27 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 27), align 8
  %v28 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 28), align 8
  %v29 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 29), align 8
  %v30 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 30), align 8
  %v31 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 31), align 8
  %v32 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 32), align 8
  %v33 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 33), align 8
  %v34 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 34), align 8
  %v35 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 35), align 8
  %v36 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 36), align 8
  %v37 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 37), align 8
  %v38 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 38), align 8
  %v39 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 39), align 8
  %v40 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 40), align 8
  %v41 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 41), align 8
  %v42 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 42), align 8
  %v43 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 43), align 8
  %v44 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 44), align 8
  %v45 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 45), align 8
  %v46 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 46), align 8
  %v47 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 47), align 8
  %v48 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 48), align 8
  %v49 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 49), align 8
  %v50 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 50), align 8
  %v51 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 51), align 8
  %v52 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 52), align 8
  %v53 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 53), align 8
  %v54 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 54), align 8
  %v55 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 55), align 8
  %v56 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 56), align 8
  %v57 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 57), align 8
  %v58 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 58), align 8
  %v59 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 59), align 8
  %v60 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 60), align 8
  %v61 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 61), align 8
  %v62 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 62), align 8
  %v63 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 63), align 8
  %v64 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 64), align 8
  %v65 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 65), align 8
  %v66 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 66), align 8
  %v67 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 67), align 8
  %v68 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 68), align 8
  %v69 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 69), align 8
  %v70 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 70), align 8
  %v71 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 71), align 8
  %v72 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 72), align 8
  %v73 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 73), align 8
  %v74 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 74), align 8
  %v75 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 75), align 8
  %v76 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 76), align 8
  %v77 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 77), align 8
  %v78 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 78), align 8
  %v79 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 79), align 8
  %v80 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 80), align 8
  %v81 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 81), align 8
  %v82 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 82), align 8
  %v83 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 83), align 8
  %v84 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 84), align 8
  %v85 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 85), align 8
  %v86 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 86), align 8
  %v87 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 87), align 8
  %v88 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 88), align 8
  %v89 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 89), align 8
  %v90 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 90), align 8
  %v91 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 91), align 8
  %v92 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 92), align 8
  %v93 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 93), align 8
  %v94 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 94), align 8
  %v95 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 95), align 8
  %v96 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 96), align 8
  %v97 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 97), align 8
  %v98 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 98), align 8
  %v99 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 99), align 8
  %v100 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 100), align 8
  %v101 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 101), align 8
  %v102 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 102), align 8
  %v103 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 103), align 8
  %v104 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 104), align 8
  %v105 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 105), align 8
  %v106 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 106), align 8
  %v107 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 107), align 8
  %v108 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 108), align 8
  %v109 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 109), align 8
  %v110 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 110), align 8
  %v111 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 111), align 8
  %v112 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 112), align 8
  %v113 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 113), align 8
  %v114 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 114), align 8
  %v115 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 115), align 8
  %v116 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 116), align 8
  %v117 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 117), align 8
  %v118 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 118), align 8
  %v119 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 119), align 8
  %v120 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 120), align 8
  %v121 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 121), align 8
  %v122 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 122), align 8
  %v123 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 123), align 8
  %v124 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 124), align 8
  %v125 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 125), align 8
  %v126 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 126), align 8
  %v127 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 127), align 8
  %v128 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 128), align 8
  %v129 = load volatile <2 x float>, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 129), align 8

  store volatile <2 x float> %v0, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 0), align 8
  store volatile <2 x float> %v1, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 1), align 8
  store volatile <2 x float> %v2, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 2), align 8
  store volatile <2 x float> %v3, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 3), align 8
  store volatile <2 x float> %v4, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 4), align 8
  store volatile <2 x float> %v5, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 5), align 8
  store volatile <2 x float> %v6, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 6), align 8
  store volatile <2 x float> %v7, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 7), align 8
  store volatile <2 x float> %v8, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 8), align 8
  store volatile <2 x float> %v9, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 9), align 8
  store volatile <2 x float> %v10, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 10), align 8
  store volatile <2 x float> %v11, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 11), align 8
  store volatile <2 x float> %v12, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 12), align 8
  store volatile <2 x float> %v13, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 13), align 8
  store volatile <2 x float> %v14, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 14), align 8
  store volatile <2 x float> %v15, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 15), align 8
  store volatile <2 x float> %v16, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 16), align 8
  store volatile <2 x float> %v17, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 17), align 8
  store volatile <2 x float> %v18, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 18), align 8
  store volatile <2 x float> %v19, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 19), align 8
  store volatile <2 x float> %v20, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 20), align 8
  store volatile <2 x float> %v21, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 21), align 8
  store volatile <2 x float> %v22, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 22), align 8
  store volatile <2 x float> %v23, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 23), align 8
  store volatile <2 x float> %v24, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 24), align 8
  store volatile <2 x float> %v25, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 25), align 8
  store volatile <2 x float> %v26, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 26), align 8
  store volatile <2 x float> %v27, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 27), align 8
  store volatile <2 x float> %v28, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 28), align 8
  store volatile <2 x float> %v29, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 29), align 8
  store volatile <2 x float> %v30, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 30), align 8
  store volatile <2 x float> %v31, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 31), align 8
  store volatile <2 x float> %v32, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 32), align 8
  store volatile <2 x float> %v33, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 33), align 8
  store volatile <2 x float> %v34, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 34), align 8
  store volatile <2 x float> %v35, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 35), align 8
  store volatile <2 x float> %v36, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 36), align 8
  store volatile <2 x float> %v37, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 37), align 8
  store volatile <2 x float> %v38, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 38), align 8
  store volatile <2 x float> %v39, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 39), align 8
  store volatile <2 x float> %v40, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 40), align 8
  store volatile <2 x float> %v41, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 41), align 8
  store volatile <2 x float> %v42, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 42), align 8
  store volatile <2 x float> %v43, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 43), align 8
  store volatile <2 x float> %v44, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 44), align 8
  store volatile <2 x float> %v45, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 45), align 8
  store volatile <2 x float> %v46, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 46), align 8
  store volatile <2 x float> %v47, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 47), align 8
  store volatile <2 x float> %v48, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 48), align 8
  store volatile <2 x float> %v49, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 49), align 8
  store volatile <2 x float> %v50, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 50), align 8
  store volatile <2 x float> %v51, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 51), align 8
  store volatile <2 x float> %v52, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 52), align 8
  store volatile <2 x float> %v53, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 53), align 8
  store volatile <2 x float> %v54, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 54), align 8
  store volatile <2 x float> %v55, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 55), align 8
  store volatile <2 x float> %v56, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 56), align 8
  store volatile <2 x float> %v57, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 57), align 8
  store volatile <2 x float> %v58, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 58), align 8
  store volatile <2 x float> %v59, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 59), align 8
  store volatile <2 x float> %v60, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 60), align 8
  store volatile <2 x float> %v61, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 61), align 8
  store volatile <2 x float> %v62, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 62), align 8
  store volatile <2 x float> %v63, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 63), align 8
  store volatile <2 x float> %v64, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 64), align 8
  store volatile <2 x float> %v65, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 65), align 8
  store volatile <2 x float> %v66, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 66), align 8
  store volatile <2 x float> %v67, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 67), align 8
  store volatile <2 x float> %v68, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 68), align 8
  store volatile <2 x float> %v69, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 69), align 8
  store volatile <2 x float> %v70, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 70), align 8
  store volatile <2 x float> %v71, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 71), align 8
  store volatile <2 x float> %v72, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 72), align 8
  store volatile <2 x float> %v73, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 73), align 8
  store volatile <2 x float> %v74, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 74), align 8
  store volatile <2 x float> %v75, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 75), align 8
  store volatile <2 x float> %v76, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 76), align 8
  store volatile <2 x float> %v77, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 77), align 8
  store volatile <2 x float> %v78, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 78), align 8
  store volatile <2 x float> %v79, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 79), align 8
  store volatile <2 x float> %v80, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 80), align 8
  store volatile <2 x float> %v81, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 81), align 8
  store volatile <2 x float> %v82, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 82), align 8
  store volatile <2 x float> %v83, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 83), align 8
  store volatile <2 x float> %v84, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 84), align 8
  store volatile <2 x float> %v85, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 85), align 8
  store volatile <2 x float> %v86, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 86), align 8
  store volatile <2 x float> %v87, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 87), align 8
  store volatile <2 x float> %v88, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 88), align 8
  store volatile <2 x float> %v89, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 89), align 8
  store volatile <2 x float> %v90, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 90), align 8
  store volatile <2 x float> %v91, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 91), align 8
  store volatile <2 x float> %v92, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 92), align 8
  store volatile <2 x float> %v93, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 93), align 8
  store volatile <2 x float> %v94, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 94), align 8
  store volatile <2 x float> %v95, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 95), align 8
  store volatile <2 x float> %v96, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 96), align 8
  store volatile <2 x float> %v97, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 97), align 8
  store volatile <2 x float> %v98, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 98), align 8
  store volatile <2 x float> %v99, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 99), align 8
  store volatile <2 x float> %v100, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 100), align 8
  store volatile <2 x float> %v101, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 101), align 8
  store volatile <2 x float> %v102, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 102), align 8
  store volatile <2 x float> %v103, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 103), align 8
  store volatile <2 x float> %v104, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 104), align 8
  store volatile <2 x float> %v105, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 105), align 8
  store volatile <2 x float> %v106, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 106), align 8
  store volatile <2 x float> %v107, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 107), align 8
  store volatile <2 x float> %v108, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 108), align 8
  store volatile <2 x float> %v109, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 109), align 8
  store volatile <2 x float> %v110, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 110), align 8
  store volatile <2 x float> %v111, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 111), align 8
  store volatile <2 x float> %v112, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 112), align 8
  store volatile <2 x float> %v113, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 113), align 8
  store volatile <2 x float> %v114, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 114), align 8
  store volatile <2 x float> %v115, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 115), align 8
  store volatile <2 x float> %v116, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 116), align 8
  store volatile <2 x float> %v117, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 117), align 8
  store volatile <2 x float> %v118, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 118), align 8
  store volatile <2 x float> %v119, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 119), align 8
  store volatile <2 x float> %v120, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 120), align 8
  store volatile <2 x float> %v121, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 121), align 8
  store volatile <2 x float> %v122, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 122), align 8
  store volatile <2 x float> %v123, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 123), align 8
  store volatile <2 x float> %v124, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 124), align 8
  store volatile <2 x float> %v125, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 125), align 8
  store volatile <2 x float> %v126, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 126), align 8
  store volatile <2 x float> %v127, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 127), align 8
  store volatile <2 x float> %v128, <2 x float>* getelementptr inbounds ([130 x <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 128), align 8
  store volatile <2 x float> %v129, <2 x float>* getelementptr inbounds ([130 x
 <2 x float>], [130 x <2 x float>]* @gv2f32, i64 0, i64 129), align 8

  ret void
}
