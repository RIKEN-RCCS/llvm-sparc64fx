Code generator patches to LLVM for HPC extensions of Fujitsu SPARC64
====================================================================

DO NOT USE THIS FOR SERIOUS APPLICATIONS
----------------------------------------

This patch adds a support of SIMD extensions of SPARC64 VIIIfx and
IXfx (K Computer and Fujitsu FX10).  It is for LLVM-3.9.1.  Specify
the target CPU as "-mcpu=s64fx8".  It includes small patches to CLANG
to accept a new CPU type (see in lib/Target/Sparc).  Do not use this
for SPARC V9, because the modification should conflict with the
original code.

See the Wiki for more information: https://github.com/pf-aics-riken/llvm-sparc64fx/wiki

LLVM
----

This directory and its subdirectories contain source code for LLVM,
a toolkit for the construction of highly optimized compilers,
optimizers, and runtime environments.

LLVM is open source software. You may freely distribute it under the terms of
the license agreement found in LICENSE.txt.

Please see the documentation provided in docs/ for further
assistance with LLVM, and in particular docs/GettingStarted.rst for getting
started with LLVM and docs/README.txt for an overview of LLVM's
documentation setup.

If you are writing a package for LLVM, see docs/Packaging.rst for our
suggestions.
