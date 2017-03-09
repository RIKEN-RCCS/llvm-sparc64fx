;; -*-Mode: Fundamental; Coding: utf-8;-*-

MEMO ON S64fx

*** (2017-03-09) CURRENT STATUS (TODO)

** TODO in general

(0) ctors/dtors (or initializers specified by attributes) do not work.

(1) C++ exceptions do not work.

(2) SPARC V9 is not tested.  We tried to make the modifications avoid
conflicts with the original code, but certainly not so.

(3) Floating-point comparisons by FCMP (generating result in
registers) do not properly generate results on orderedness.

** TODO on instructions

(0) 4-SIMD instructions are not coded at all.
(1) Masked stores (STFR, STDFR) are not generated.
(2) Element swap of SIMD FMA is not utilized.
(3) Integer SIMD instructions are not not generated.

*** (2017-03-09) CURRENT STATUS (MEMO)

** MEMO on disassembler

Disassember cannot distinguish 2-SIMD and 4-SIMD.  2-SIMD
instructions are selected.

** MEMO on SXAR prefixing

SXAR prefixing is performed after delay-slot filling.  If it were
before delay-slot filling, checks of SXAR prefixing can be omitted,
because prefixed instructions are put in a bundle and delay-slot
filling skips them.

** MEMO on HPC-ACE (tricky instructions)

FCMP (result in registers) lacks instructions for checking
orderedness.

Low-numbered registers of the single-precision FPs (F0-F31) have a
different layout from V9 in extended instructions.  They are
subregisters in a straightforward way as F0 in D0, F1 in D1, etc., and
are not packed like in V9 FP registers.

FDIV and FSQRT can generate a result only in the vector element0
registers (the first half of registers, i.e., F0-F127 and D0-D127).

Conditional Store instructins {STFR, STDFR} have address offsets
(simm8) in SPARC64-VIIIfx, but they become undefined in SPARC64-XIfx
(ignored and simm8 is always 0).
