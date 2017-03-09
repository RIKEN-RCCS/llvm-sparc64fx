//===---- SparcInstrS64fx.td - S64fx extensions -----===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// Instruction definitions of SPARC64 HPC-ACE.
//===----------------------------------------------------------------------===//

// [S64fx] This file is new for S64fx.

// [S64fx] MEMO: Feature ACE1 means implementing JPS1 and HPC-ACE, and
// ACE2 for UA2011 and HPC-ACE2.  JPS1 includes VIS1 and VIS2 but not
// VIS3, while UA2011 includes VIS3.  Hoverver, here, ACE1 actually
// means 2-SIMD and ACE2 means 4-SIMD, and ACE1 and ACE2 are
// exclusive, currenlty.  This does not define some VIS instructions
// of HPC-ACE, yet.  Here, SPARC extensions "JPS" refers to Joint
// Programming Specification, and "UA" refers to UltraSPARC
// Architecture.

// [S64fx] TODO: (0) Swapping between vector elements (0 vs. 1,
// and 2 vs. 3) in the FMA is not defined.  (1) ACE2 instructions are
// not yet defined.

def IsACE : Predicate<"Subtarget->isACE()">;
def IsACE1 : Predicate<"Subtarget->isACE1()">;
def IsACE2 : Predicate<"Subtarget->isACE2()">;

class F2_sxar1<string asmstr>
  : InstSP<(outs), (ins), asmstr, []> {
  let op = 0;
  let Inst{29} = 0;
  let Inst{24-22} = 7; // op2
}

class F2_sxar2<string asmstr>
  : InstSP<(outs), (ins), asmstr, []> {
  let op = 0;
  let Inst{29} = 1;
  let Inst{24-22} = 7; // op2
}

let Predicates = [IsACE] in {
def SXAR1 : F2_sxar1<"sxar1">;
def SXAR2 : F2_sxar2<"sxar2">;
}

// Format 3 (op=2): RDM, SSM (Set SIMD Mode) and SNF (Set Non-Faulting
// Mode) instructions in ACE2.

class F3_op2<bits<1> iw, dag ins, string asmstr>
  : F3<(outs), ins, asmstr, []> {
  bits<3> mode;
  let op = 2;
  let rd = 0;
  let rs1 = 0;
  let op3 = 0b110110;
  let Inst{13-5} = 0b010001101; // opf
  let Inst{4} = iw;             // SSM:0, SNF:1
  let Inst{3} = 0;
  let Inst{2-0} = mode;
}

class F3_3_vis<bits<9> opfval, dag outs, dag ins,
               string asmstr, list<dag> pattern>
  : F3_3<0b10, 0b110110, opfval, outs, ins, asmstr, pattern>;

let rs2 = 0 in
class F3_3u_vis<bits<9> opfval, dag outs, dag ins,
                string asmstr, list<dag> pattern>
  : F3_3<0b10, 0b110110, opfval, outs, ins, asmstr, pattern>;

let rs1 = 0, rs2 = 0 in
class F3_3z_vis<bits<9> opfval, dag outs, dag ins,
                string asmstr, list<dag> pattern>
  : F3_3<0b10, 0b110110, opfval, outs, ins, asmstr, pattern>;

class F3_3_cmpr<bits<4> opflow, dag outs, dag ins,
                string asmstr, list<dag> pattern>
: F3_3_vis<{0b10110, opflow}, outs, ins, asmstr, pattern>;

class F3_3_stfr<bits<2> opval, bits<6> op3val, bits<2> ty,
                dag outs, dag ins, string asmstr, list<dag> pattern>
  : F3<outs, ins, asmstr, pattern> {
  bits<8> rs2;
  let op = opval;
  let op3 = op3val;
  let Inst{13} = 0;
  let Inst{11-10} = ty;
  let Inst{4-0} = rs2{4-0};
  let xar_rs2 = rs2{7-5};
}

class F4_fecsld<dag outs, dag ins, string asmstr, list<dag> pattern>
  : F4<0b110110, outs, ins, asmstr, pattern> {
  bits<8> rs1;
  bits<8> rs2;
  bits<2> shc;
  let op = 2;
  bits<9> opf = 0b110000001;
  let Inst{18-14} = rs1{4-0};
  let Inst{13-5} = opf;
  let Inst{4-0} = rs2{4-0};
  let xar_v = 1;
  let xar_simd = 2;
  let xar_rs1 = rs1{7-5};
  let xar_rs2 = rs2{7-5};
  let xar_rs3{1-0} = shc;
}

// Format 5 (op=2, op3=0x37) four-operand operations: FMADD, FPMADDX,
// FSELMOV, FTRIMADD and FSHIFTORX.

class F5_1<bits<2>var, bits<2>size, dag outs, dag ins,
        string asmstr, list<dag> pattern>
  : InstSP<outs, ins, asmstr, pattern> {
  let Predicates = [IsACE];
  bits<8> rd;
  bits<8> rs1;
  bits<8> rs2;
  bits<8> rs3;
  let op = 2;
  bits<6> op3 = 0b110111;
  let Inst{29-25} = rd{4-0};
  let Inst{24-19} = op3;
  let Inst{18-14} = rs1{4-0};
  let Inst{13-9} = rs3{4-0};
  let Inst{8-7} = var;
  let Inst{6-5} = size;
  let Inst{4-0} = rs2{4-0};
  let xar_simd = 0;
  let xar_rd = rd{7-5};
  let xar_rs1 = rs1{7-5};
  let xar_rs2 = rs2{7-5};
  let xar_rs3 = rs3{7-5};
}

// Format 6 (ACE2) (op=3).

class F6_1<bits<6>op3, bits<2>var, bits<2>size, dag outs, dag ins,
        string asmstr, list<dag> pattern>
  : InstSP<outs, ins, asmstr, pattern> {
  let Predicates = [IsACE2];
  bits<8> rd;
  bits<8> rs1;
  bits<8> rs2;
  bits<1> id;
  bits<2> ty;
  let op = 3;
  let Inst{29-25} = rd{4-0};
  let Inst{24-19} = op3;
  let Inst{18-14} = rs1{4-0};
  let Inst{12} = id;
  let Inst{11-10} = ty;
  let Inst{4-0} = rs2{4-0};
  let xar_v = 1;
  let xar_simd = 0;
  let xar_rd = rd{7-5};
  let xar_rs1 = rs1{7-5};
  let xar_rs2 = rs2{7-5};
}

let Predicates = [IsACE2] in {
def SSM : F3_op2<0, (ins i32imm:$mode), "ssm $mode">;
def SNF : F3_op2<1, (ins i32imm:$mode), "snf $mode">;
}

// FECSLD (Element Concatenate Shift Left) Instruction

let Predicates = [IsACE2] in {
def FECSLD : F4_fecsld<(outs V4DFPRegs:$rd),
  (ins V4DFPRegs:$rs1, V4DFPRegs:$rs2, i32imm:$shc),
  "fecsld,s $rs1, $rs2, $shc, $rd", []>;

let isPseudo = 1, isCodeGenOnly = 1 in
def swap_v4f32 : F4_fecsld<(outs V4FPRegs:$rd), (ins V4FPRegs:$rs1),
                           "SWAPNODE", []>;
let isPseudo = 1, isCodeGenOnly = 1 in
def swap_v4f64 : F4_fecsld<(outs V4DFPRegs:$rd), (ins V4DFPRegs:$rs1),
                           "SWAPNODE", []>;
}

// BUILD_VECTOR//EXTRACT_VECTOR_ELT/INSERT_VECTOR_ELT (2-SIMD).
// (Define EXTRACT_VECTOR_ELT becuase the predefined rule of LLVM
// (seemingly) uses load/store; INSERT_VECTOR_ELT, too).

multiclass define_build_vector_v2<ValueType STY, ValueType VTY> {
  def : Pat<(build_vector STY:$ra, STY:$rb),
    (VTY (INSERT_SUBREG
          (VTY (INSERT_SUBREG (VTY (IMPLICIT_DEF)),
                STY:$ra, subreg_v0)),
          STY:$rb, subreg_v1))>;

  def : Pat<(extractelt VTY:$rv, 0),
    (STY (EXTRACT_SUBREG VTY:$rv, subreg_v0))>;
  def : Pat<(extractelt VTY:$rv, 1),
    (STY (EXTRACT_SUBREG VTY:$rv, subreg_v1))>;

  def : Pat<(insertelt VTY:$rv, STY:$ra, 0),
    (VTY (INSERT_SUBREG VTY:$rv, STY:$ra, subreg_v0))>;
  def : Pat<(insertelt VTY:$rv, STY:$rb, 1),
    (VTY (INSERT_SUBREG VTY:$rv, STY:$rb, subreg_v1))>;
}

defm V2F32 : define_build_vector_v2<f32, v2f32>;
defm V2F64 : define_build_vector_v2<f64, v2f64>;

// BUILD_VECTOR/EXTRACT_VECTOR_ELT/INSERT_VECTOR_ELT (4-SIMD).  It
// first swaps elements two-by-two and uses the 2-SIMD case.

def : Pat<(build_vector (f32 XFPRegs:$i0), (f32 XFPRegs:$i1),
           (f32 XFPRegs:$i2), (f32 XFPRegs:$i3)),
          (v4f32 (INSERT_SUBREG
                  (v4f32 (INSERT_SUBREG
                          (swap_v4f32
                           (v4f32 (INSERT_SUBREG
                                   (v4f32 (INSERT_SUBREG
                                           (v4f32 (IMPLICIT_DEF)),
                                           XFPRegs:$i2, subreg_v0)),
                                   XFPRegs:$i3, subreg_v1))),
                          XFPRegs:$i0, subreg_v0)),
                  XFPRegs:$i1, subreg_v1))>;

def : Pat<(build_vector (f64 DFPRegs:$i0), (f64 DFPRegs:$i1),
           (f64 DFPRegs:$i2), (f64 DFPRegs:$i3)),
          (v4f64 (INSERT_SUBREG
                  (v4f64 (INSERT_SUBREG
                          (swap_v4f64
                           (v4f64 (INSERT_SUBREG
                                   (v4f64 (INSERT_SUBREG
                                           (v4f64 (IMPLICIT_DEF)),
                                           DFPRegs:$i2, subreg_v0)),
                                   DFPRegs:$i3, subreg_v1))),
                          DFPRegs:$i0, subreg_v0)),
                  DFPRegs:$i1, subreg_v1))>;

def : Pat<(extractelt (v4f32 V4FPRegs:$Rs), 0),
          (f32 (EXTRACT_SUBREG V4FPRegs:$Rs, subreg_v0))>;
def : Pat<(extractelt (v4f32 V4FPRegs:$Rs), 1),
          (f32 (EXTRACT_SUBREG V4FPRegs:$Rs, subreg_v1))>;
def : Pat<(extractelt (v4f32 V4FPRegs:$Rs), 2),
          (f32 (EXTRACT_SUBREG
                (swap_v4f32 V4FPRegs:$Rs), subreg_v0))>;
def : Pat<(extractelt (v4f32 V4FPRegs:$Rs), 3),
          (f32 (EXTRACT_SUBREG
                (swap_v4f32 V4FPRegs:$Rs), subreg_v1))>;

def : Pat<(extractelt (v4f64 V4DFPRegs:$Rs), 0),
          (f64 (EXTRACT_SUBREG V4DFPRegs:$Rs, subreg_v0))>;
def : Pat<(extractelt (v4f64 V4DFPRegs:$Rs), 1),
          (f64 (EXTRACT_SUBREG V4DFPRegs:$Rs, subreg_v1))>;
def : Pat<(extractelt (v4f64 V4DFPRegs:$Rs), 2),
          (f64 (EXTRACT_SUBREG
                (swap_v4f64 V4DFPRegs:$Rs), subreg_v0))>;
def : Pat<(extractelt (v4f64 V4DFPRegs:$Rs), 3),
          (f64 (EXTRACT_SUBREG
                (swap_v4f64 V4DFPRegs:$Rs), subreg_v1))>;

def : Pat<(insertelt (v4f32 V4FPRegs:$Rd), (f32 XFPRegs:$Rs), 0),
          (v4f32 (INSERT_SUBREG V4FPRegs:$Rd, XFPRegs:$Rs, subreg_v0))>;
def : Pat<(insertelt (v4f32 V4FPRegs:$Rd), (f32 XFPRegs:$Rs), 1),
          (v4f32 (INSERT_SUBREG V4FPRegs:$Rd, XFPRegs:$Rs, subreg_v1))>;
def : Pat<(insertelt (v4f32 V4FPRegs:$Rd), (f32 XFPRegs:$Rs), 2),
          (v4f32 (swap_v4f32 (INSERT_SUBREG
                              (swap_v4f32 V4FPRegs:$Rd),
                              XFPRegs:$Rs, subreg_v0)))>;
def : Pat<(insertelt (v4f32 V4FPRegs:$Rd), (f32 XFPRegs:$Rs), 3),
          (v4f32 (swap_v4f32 (INSERT_SUBREG
                              (swap_v4f32 V4FPRegs:$Rd),
                              XFPRegs:$Rs, subreg_v1)))>;

def : Pat<(insertelt (v4f64 V4DFPRegs:$Rd), (f64 DFPRegs:$Rs), 0),
          (v4f64 (INSERT_SUBREG V4DFPRegs:$Rd, DFPRegs:$Rs, subreg_v0))>;
def : Pat<(insertelt (v4f64 V4DFPRegs:$Rd), (f64 DFPRegs:$Rs), 1),
          (v4f64 (INSERT_SUBREG V4DFPRegs:$Rd, DFPRegs:$Rs, subreg_v1))>;
def : Pat<(insertelt (v4f64 V4DFPRegs:$Rd), (f64 DFPRegs:$Rs), 2),
          (v4f64 (swap_v4f64 (INSERT_SUBREG
                              (swap_v4f64 V4DFPRegs:$Rd),
                              DFPRegs:$Rs, subreg_v0)))>;
def : Pat<(insertelt (v4f64 V4DFPRegs:$Rd), (f64 DFPRegs:$Rs), 3),
          (v4f64 (swap_v4f64 (INSERT_SUBREG
                              (swap_v4f64 V4DFPRegs:$Rd),
                              DFPRegs:$Rs, subreg_v1)))>;

let DecoderMethod = "DecodeLoadFP", xar_v = 1, Predicates = [IsACE] in {
  defm LDFx : Load<"ld", 0b100000, load, XFPRegs, f32>;
  def LDFAxrr : LoadASI<"ld", 0b110000, load, XFPRegs, f32>;
}

let DecoderMethod = "DecodeStoreFP", xar_v = 1, Predicates = [IsACE] in {
  defm STFx : Store<"st", 0b100100, store, XFPRegs, f32>;
  def STFAxrr : StoreASI<"st", 0b110100, store, XFPRegs, f32>;
}

// Type conversions work on integers in the FP registers.

let Predicates = [IsACE] in {
  let xar_v = 1 in
  def FITOSx : F3_3u<2, 0b110100, 0b011000100,
                     (outs XFPRegs:$rd), (ins XFPRegs:$rs2),
                     "fitos $rs2, $rd",
                     [(set f32:$rd, (SPitof f32:$rs2))]>;
  let xar_v = 1 in
  def FITODx : F3_3u<2, 0b110100, 0b011001000,
                     (outs DFPRegs:$rd), (ins XFPRegs:$rs2),
                     "fitod $rs2, $rd",
                     [(set f64:$rd, (SPitof f32:$rs2))]>;

  let xar_v = 1 in
  def FXTOSx : F3_3u<2, 0b110100, 0b010000100,
                     (outs XFPRegs:$rd), (ins DFPRegs:$rs2),
                     "fxtos $rs2, $rd",
                     [(set f32:$rd, (SPxtof f64:$rs2))]>;
  //def FXTODx : F3_3u<2, 0b110100, 0b010001000,
  //(outs DFPRegs:$rd), (ins DFPRegs:$rs2),
  //"fxtod $rs2, $rd",
  //[(set f64:$rd, (SPxtof i64:$rs2))]>;

  let xar_v = 1 in
  def FSTOIx : F3_3u<2, 0b110100, 0b011010001,
                     (outs XFPRegs:$rd), (ins XFPRegs:$rs2),
                     "fstoi $rs2, $rd",
                     [(set f32:$rd, (SPftoi f32:$rs2))]>;
  let xar_v = 1 in
  def FDTOIx : F3_3u<2, 0b110100, 0b011010010,
                     (outs XFPRegs:$rd), (ins DFPRegs:$rs2),
                     "fdtoi $rs2, $rd",
                     [(set f32:$rd, (SPftoi f64:$rs2))]>;

  let xar_v = 1 in
  def FSTOXx : F3_3u<2, 0b110100, 0b010000001,
                     (outs DFPRegs:$rd), (ins XFPRegs:$rs2),
                     "fstox $rs2, $rd",
                     [(set f64:$rd, (SPftox f32:$rs2))]>;
  //def FDTOXx : F3_3u<2, 0b110100, 0b010000010,
  //(outs DFPRegs:$rd), (ins DFPRegs:$rs2),
  //"fdtox $rs2, $rd",
  //[(set f64:$rd, (SPftox f64:$rs2))]>;

  let xar_v = 1 in
  def FSTODx : F3_3u<2, 0b110100, 0b011001001,
                     (outs DFPRegs:$rd), (ins XFPRegs:$rs2),
                     "fstod $rs2, $rd",
                     [(set f64:$rd, (fextend f32:$rs2))]>;
  let xar_v = 1 in
  def FDTOSx : F3_3u<2, 0b110100, 0b011000110,
                     (outs XFPRegs:$rd), (ins DFPRegs:$rs2),
                     "fdtos $rs2, $rd",
                     [(set f32:$rd, (fround f64:$rs2))]>;
}

let xar_v = 1, Predicates = [IsACE] in {
  def FMOVSx : F3_3u<2, 0b110100, 0b000000001,
                     (outs XFPRegs:$rd), (ins XFPRegs:$rs2),
                     "fmovs $rs2, $rd", []>;
  def FNEGSx : F3_3u<2, 0b110100, 0b000000101,
                     (outs XFPRegs:$rd), (ins XFPRegs:$rs2),
                     "fnegs $rs2, $rd",
                     [(set f32:$rd, (fneg f32:$rs2))]>;
  def FABSSx : F3_3u<2, 0b110100, 0b000001001,
                     (outs XFPRegs:$rd), (ins XFPRegs:$rs2),
                     "fabss $rs2, $rd",
                     [(set f32:$rd, (fabs f32:$rs2))]>;
}

// Note FMOV(s,d,q)cc instructions are note extended.  See
// FMOV{S,D,Q}_{I,F}CC in SparcInstrInfo.td.

let xar_v = 1, Predicates = [IsACE] in {
  def FSQRTSx : F3_3u<2, 0b110100, 0b000101001,
                      (outs FPe0Regs:$rd), (ins XFPRegs:$rs2),
                      "fsqrts $rs2, $rd",
                      [(set f32:$rd, (fsqrt f32:$rs2))]>;
  def FDIVSx : F3_3<2, 0b110100, 0b001001101,
                   (outs FPe0Regs:$rd), (ins XFPRegs:$rs1, XFPRegs:$rs2),
                   "fdivs $rs1, $rs2, $rd",
                   [(set f32:$rd, (fdiv f32:$rs1, f32:$rs2))]>;
}

let xar_v = 1, Predicates = [IsACE] in {
def FADDSx : F3_3<2, 0b110100, 0b001000001,
                  (outs XFPRegs:$rd), (ins XFPRegs:$rs1, XFPRegs:$rs2),
                  "fadds $rs1, $rs2, $rd",
                  [(set f32:$rd, (fadd f32:$rs1, f32:$rs2))]>;
def FSUBSx : F3_3<2, 0b110100, 0b001000101,
                  (outs XFPRegs:$rd), (ins XFPRegs:$rs1, XFPRegs:$rs2),
                  "fsubs $rs1, $rs2, $rd",
                  [(set f32:$rd, (fsub f32:$rs1, f32:$rs2))]>;
def FMULSx : F3_3<2, 0b110100, 0b001001001,
                  (outs XFPRegs:$rd), (ins XFPRegs:$rs1, XFPRegs:$rs2),
                  "fmuls $rs1, $rs2, $rd",
                  [(set f32:$rd, (fmul f32:$rs1, f32:$rs2))]>;
def FSMULDx : F3_3<2, 0b110100, 0b001101001,
                  (outs DFPRegs:$rd), (ins XFPRegs:$rs1, XFPRegs:$rs2),
                  "fsmuld $rs1, $rs2, $rd",
                  [(set f64:$rd, (fmul (fextend f32:$rs1),
                                        (fextend f32:$rs2)))]>;
}

// The assembler requires an explicit "%fcc0" for V9.  These replaces
// FCMPS/FCMPD/FCMPQ in SparcInstrInfo.td.

let Defs = [FCC0], rd = 0, isCodeGenOnly = 1, Predicates = [IsACE] in {
  let xar_v = 1 in
  def FCMPSx : F3_3c<2, 0b110101, 0b001010001,
        (outs), (ins XFPRegs:$rs1, XFPRegs:$rs2),
        "fcmps %fcc0, $rs1, $rs2",
        [(SPcmpfcc f32:$rs1, f32:$rs2)]>;
  def FCMPDx : F3_3c<2, 0b110101, 0b001010010,
        (outs), (ins DFPRegs:$rs1, DFPRegs:$rs2),
        "fcmpd %fcc0, $rs1, $rs2",
        [(SPcmpfcc f64:$rs1, f64:$rs2)]>;
  def FCMPQx : F3_3c<2, 0b110101, 0b001010011,
        (outs), (ins QFPRegs:$rs1, QFPRegs:$rs2),
        "fcmpq %fcc0, $rs1, $rs2",
        [(SPcmpfcc f128:$rs1, f128:$rs2)]>,
        Requires<[HasHardQuad]>;
}

// SIMD Instructions.

multiclass define_vload<bits<2> simd, string op, bits<6> op3val,
                        SDPatternOperator opnode,
                        RegisterClass RC, ValueType TY, string remark> {
  let xar_v = 1, xar_simd = simd in
  def rr : F3_1<3, op3val,
    (outs RC:$rd), (ins MEMrr:$addr),
    !strconcat(op, " [$addr], $rd", remark),
    [(set TY:$rd, (opnode ADDRrr:$addr))]>;
  let xar_v = 1, xar_simd = simd in
  def ri : F3_2<3, op3val,
    (outs RC:$rd), (ins MEMri:$addr),
    !strconcat(op, " [$addr], $rd", remark),
    [(set TY:$rd, (opnode ADDRri:$addr))]>;
}

multiclass define_vstore<bits<2> simd, string op, bits<6> op3val,
                         SDPatternOperator opnode,
                         RegisterClass RC, ValueType TY, string remark> {
  let xar_v = 1, xar_simd = simd in
  def rr : F3_1<3, op3val,
    (outs), (ins MEMrr:$addr, RC:$rd),
    !strconcat(op, " $rd, [$addr]", remark),
    [(opnode TY:$rd, ADDRrr:$addr)]>;
  let xar_v = 1, xar_simd = simd in
  def ri : F3_2<3, op3val,
    (outs), (ins MEMri:$addr, RC:$rd),
    !strconcat(op, " $rd, [$addr]", remark),
    [(opnode TY:$rd, ADDRri:$addr)]>;
}

let DecoderMethod = "DecodeLoadFP", Predicates = [IsACE1] in
  defm V2LDF : define_vload<1, "ld,s", 0b100000, load, V2FPRegs, v2f32,
                            " /*v2*/">;
let DecoderMethod = "DecodeLoadDFP", Predicates = [IsACE1] in
  defm V2LDD : define_vload<1, "ldd,s", 0b100011, load, V2DFPRegs, v2f64,
                            " /*v2*/">;

let DecoderMethod = "DecodeStoreFP", Predicates = [IsACE1] in
  defm V2STF : define_vstore<1, "st,s", 0b100100, store, V2FPRegs, v2f32,
                             " /*v2*/">;
let DecoderMethod = "DecodeStoreDFP", Predicates = [IsACE1] in
  defm V2STD : define_vstore<1, "std,s", 0b100111, store, V2DFPRegs, v2f64,
                             " /*v2*/">;

let DecoderMethod = "DecodeLoadFP", Predicates = [IsACE2] in
  defm V4LDF : define_vload<2, "ld,s", 0b100000, load, V4FPRegs, v4f32,
                            " /*v2*/">;
let DecoderMethod = "DecodeLoadDFP", Predicates = [IsACE2] in
  defm V4LDD : define_vload<2, "ldd,s", 0b100011, load, V4DFPRegs, v4f64,
                            " /*v2*/">;

let DecoderMethod = "DecodeStoreFP", Predicates = [IsACE2] in
  defm V4STF : define_vstore<2, "st,s", 0b100100, store, V4FPRegs, v4f32,
                             " /*v4*/">;
let DecoderMethod = "DecodeStoreDFP", Predicates = [IsACE2] in
  defm V4STD : define_vstore<2, "std,s", 0b100111, store, V4DFPRegs, v4f64,
                             " /*v4*/">;

// Conditional stores {STFR, STDFR}.  Note that an address offset
// (simm8) in SPARC64-VIII has been removed in SPARC64-XI.  STFRUW is
// in ACE2.  They are in the F3 format.

let xar_v = 1, xar_simd = 1, Predicates = [IsACE1] in
def V2STFR : F3_3_stfr<
  3, 0b101100, 0,
  (outs), (ins IntRegs:$rs1, V2FPRegs:$rd, V2FPRegs:$rs2),
  "stfr $rd, $rs2, [$rs1] /*v2*/",
  []>;
let xar_v = 1, xar_simd = 2, Predicates = [IsACE2] in
def V4STFR : F3_3_stfr<
  3, 0b101100, 0,
  (outs), (ins IntRegs:$rs1, V4FPRegs:$rd, V4FPRegs:$rs2),
  "stfr $rd, $rs2, [$rs1] /*v4*/",
  []>;

let xar_v = 1, xar_simd = 1, Predicates = [IsACE1] in
def V2STDFR : F3_3_stfr<
  3, 0b101111, 0,
  (outs), (ins IntRegs:$rs1, V2DFPRegs:$rd, V2DFPRegs:$rs2),
  "stdfr $rd, $rs2, [$rs1] /*v2*/",
  []>;
let xar_v = 1, xar_simd = 2, Predicates = [IsACE2] in
def V4STDFR : F3_3_stfr<
  3, 0b101111, 0,
  (outs), (ins IntRegs:$rs1, V4DFPRegs:$rd, V4DFPRegs:$rs2),
  "stdfr $rd, $rs2, [$rs1] /*v4*/",
  []>;

// Note the type constraint on masked_store is weak; Condition need
// not be an integer.

let Predicates = [IsACE1] in {
  def : Pat<(masked_store iPTR:$rs1, v2f32:$rs2, v2f32:$rd),
  (V2STFR iPTR:$rs1, V2FPRegs:$rs2, V2FPRegs:$rd)>;
  def : Pat<(masked_store iPTR:$rs1, v2f64:$rs2, v2f64:$rd),
  (V2STDFR iPTR:$rs1, V2DFPRegs:$rs2, V2DFPRegs:$rd)>;
}
let Predicates = [IsACE2] in {
  def : Pat<(masked_store iPTR:$rs1, v4f32:$rs2, v4f32:$rd),
  (V4STFR iPTR:$rs1, V4FPRegs:$rs2, V4FPRegs:$rd)>;
  def : Pat<(masked_store iPTR:$rs1, v4f64:$rs2, v4f64:$rd),
  (V4STDFR iPTR:$rs1, V4DFPRegs:$rs2, V4DFPRegs:$rd)>;
}

// FP constants for patterns of FZERO and FONE (all zeros, all ones).

def fpimm0 : PatLeaf<(fpimm), [{return N->isExactlyValue(0.0);}]>;
def fpimmall1 : PatLeaf<(fpimm), [{return llvm::isAllOnes(N);}]>;

multiclass define_vector_variants<
  RegisterClass RC32, ValueType TY32, RegisterClass RC64, ValueType TY64,
  string vectorsuffix, string remark> {

  // Moves.

  def FMOVS : F3_3u<2, 0b110100, 0b000000001,
    (outs RC32:$rd), (ins RC32:$rs2),
    "fmovs,s $rs2, $rd" # remark, []>;
  def FMOVD : F3_3u<2, 0b110100, 0b000000010,
    (outs RC64:$rd), (ins RC64:$rs2),
    "fmovd,s $rs2, $rd" # remark, []>;

  // Binaries.

  def FADDS : F3_3<2, 0b110100, 0b001000001,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2),
    "fadds,s $rs1, $rs2, $rd" # remark,
    [(set TY32:$rd, (fadd TY32:$rs1, TY32:$rs2))]>;
  def FADDD : F3_3<2, 0b110100, 0b001000010,
    (outs RC64:$rd), (ins RC64:$rs1, RC64:$rs2),
    "faddd,s $rs1, $rs2, $rd" # remark,
    [(set TY64:$rd, (fadd TY64:$rs1, TY64:$rs2))]>;

  def FSUBS : F3_3<2, 0b110100, 0b001000101,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2),
    "fsubs,s $rs1, $rs2, $rd" # remark,
    [(set TY32:$rd, (fsub TY32:$rs1, TY32:$rs2))]>;
  def FSUBD : F3_3<2, 0b110100, 0b001000110,
    (outs RC64:$rd), (ins RC64:$rs1, RC64:$rs2),
    "fsubd,s $rs1, $rs2, $rd" # remark,
    [(set TY64:$rd, (fsub TY64:$rs1, TY64:$rs2))]>;

  def FMULS : F3_3<2, 0b110100, 0b001001001,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2),
    "fmuls,s $rs1, $rs2, $rd" # remark,
    [(set TY32:$rd, (fmul TY32:$rs1, TY32:$rs2))]>;
  def FMULD : F3_3<2, 0b110100, 0b001001010,
    (outs RC64:$rd), (ins RC64:$rs1, RC64:$rs2),
    "fmuld,s $rs1, $rs2, $rd" # remark,
    [(set TY64:$rd, (fmul TY64:$rs1, TY64:$rs2))]>;

  // Unaries.

  def FNEGS : F3_3u<2, 0b110100, 0b000000101,
    (outs RC32:$rd), (ins RC32:$rs2),
    "fnegs,s $rs2, $rd" # remark,
    [(set TY32:$rd, (fneg TY32:$rs2))]>;
  def FNEGD : F3_3u<2, 0b110100, 0b000000110,
    (outs RC64:$rd), (ins RC64:$rs2),
    "fnegd,s $rs2, $rd" # remark,
    [(set TY64:$rd, (fneg TY64:$rs2))]>;

  def FABSS : F3_3u<2, 0b110100, 0b000001001,
    (outs RC32:$rd), (ins RC32:$rs2),
    "fabss,s $rs2, $rd" # remark,
    [(set TY32:$rd, (fabs TY32:$rs2))]>;
  def FABSD : F3_3u<2, 0b110100, 0b000001010,
    (outs RC64:$rd), (ins RC64:$rs2),
    "fabsd,s $rs2, $rd" # remark,
    [(set TY64:$rd, (fabs TY64:$rs2))]>;

  // Nullaries.

  def FZEROS : F3_3z_vis<
    0b001100001,
    (outs RC32:$rd), (ins),
    "fzeros,s $rd" # remark,
    [(set TY32:$rd, (TY32 immAllZerosV))]> {let xar_v = 1;}
  def FZERO : F3_3z_vis<
    0b001100000,
    (outs RC64:$rd), (ins),
    "fzero,s $rd" # remark,
    [(set TY64:$rd, (TY64 immAllZerosV))]>;

  def FONES : F3_3z_vis<
    0b001111111,
    (outs RC32:$rd), (ins),
    "fones,s $rd" # remark,
    [(set TY32:$rd, immAllOnesV)]> {let xar_v = 1;}
  def FONE : F3_3z_vis<
    0b001111110,
    (outs RC64:$rd), (ins),
    "fone,s $rd" # remark,
    [(set TY64:$rd, immAllOnesV)]>;
}

let xar_v = 1, xar_simd = 1, Predicates = [IsACE1] in
  defm V2 : define_vector_variants<
    V2FPRegs, v2f32, V2DFPRegs, v2f64, ",s", " /*v2*/">;
let xar_v = 1, xar_simd = 2, Predicates = [IsACE2] in
  defm V4 : define_vector_variants<
    V4FPRegs, v4f32, V4DFPRegs, v4f64, ",s", " /*v2*/">;

// FZERO/FONE scalar case.

let Predicates = [IsACE] in {
  def FZEROSx : F3_3z_vis<
    0b001100001,
    (outs XFPRegs:$rd), (ins),
    "fzeros $rd",
    [(set f32:$rd, (f32 fpimm0))]> {let xar_v = 1;}
  def FZERO : F3_3z_vis<
    0b001100000,
    (outs DFPRegs:$rd), (ins),
    "fzero $rd",
    [(set f64:$rd, (f64 fpimm0))]>;

  def FONESx : F3_3z_vis<
    0b001111111,
    (outs XFPRegs:$rd), (ins),
    "fones $rd",
    [(set f32:$rd, fpimmall1)]> {let xar_v = 1;}
  def FONE : F3_3z_vis<
    0b001111110,
    (outs DFPRegs:$rd), (ins),
    "fone $rd",
    [(set f64:$rd, fpimmall1)]>;
}

// MEMO: Give a prefix explicitly, because an empty name for defm is
// not allowed.  It is converted to "anonymous_xxx", when an empty one
// is specified.

multiclass define_scalar_vector_variants<
  string prefix,
  RegisterClass RC32, ValueType TY32, RegisterClass RC64, ValueType TY64,
  string vectorsuffix, string remark> {

  // Ternaries.

  def prefix#FMADDS : F5_1<
    0b00, 0b01,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2, RC32:$rs3),
    "fmadds" # vectorsuffix # " $rs1, $rs2, $rs3, $rd" # remark,
    [(set TY32:$rd, (fma TY32:$rs1, TY32:$rs2, TY32:$rs3))]> {
    let xar_v = 1;}
  def prefix#FMADDD : F5_1<
    0b00, 0b10,
    (outs RC64:$rd), (ins RC64:$rs1, RC64:$rs2, RC64:$rs3),
    "fmaddd" # vectorsuffix # " $rs1, $rs2, $rs3, $rd" # remark,
    [(set TY64:$rd, (fma TY64:$rs1, TY64:$rs2, TY64:$rs3))]>;

  def prefix#FMSUBS : F5_1<
    0b01, 0b01,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2, RC32:$rs3),
    "fmsubs" # vectorsuffix # " $rs1, $rs2, $rs3, $rd" # remark,
    [(set TY32:$rd, (fma TY32:$rs1, TY32:$rs2, (fneg TY32:$rs3)))]> {
    let xar_v = 1;}
  def prefix#FMSUBD : F5_1<
    0b01, 0b10,
    (outs RC64:$rd), (ins RC64:$rs1, RC64:$rs2, RC64:$rs3),
    "fmsubd" # vectorsuffix # " $rs1, $rs2, $rs3, $rd" # remark,
    [(set TY64:$rd, (fma TY64:$rs1, TY64:$rs2, (fneg TY64:$rs3)))]>;

  def prefix#FNMSUBS : F5_1<
    0b10, 0b01,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2, RC32:$rs3),
    "fnmsubs" # vectorsuffix # " $rs1, $rs2, $rs3, $rd" # remark,
    [(set TY32:$rd, (fneg (fma TY32:$rs1, TY32:$rs2, (fneg TY32:$rs3))))]> {
    let xar_v = 1;}
  def prefix#FNMSUBD : F5_1<
    0b10, 0b10,
    (outs RC64:$rd), (ins RC64:$rs1, RC64:$rs2, RC64:$rs3),
    "fnmsubd" # vectorsuffix # " $rs1, $rs2, $rs3, $rd" # remark,
    [(set TY64:$rd, (fneg (fma TY64:$rs1, TY64:$rs2, (fneg TY64:$rs3))))]>;

  def prefix#FNMADDS : F5_1<
    0b11, 0b01,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2, RC32:$rs3),
    "fnmadds" # vectorsuffix # " $rs1, $rs2, $rs3, $rd" # remark,
    [(set TY32:$rd, (fneg (fma TY32:$rs1, TY32:$rs2, TY32:$rs3)))]> {
    let xar_v = 1;}
  def prefix#FNMADDD : F5_1<
    0b11, 0b10,
    (outs RC64:$rd), (ins RC64:$rs1, RC64:$rs2, RC64:$rs3),
    "fnmaddd" # vectorsuffix # " $rs1, $rs2, $rs3, $rd" # remark,
    [(set TY64:$rd, (fneg (fma TY64:$rs1, TY64:$rs2, TY64:$rs3)))]>;

  // Binaries.

  def prefix#FMAXNUMS : F3_3<2, 0b110110, 0b101110001,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2),
    "fmaxs" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    [(set TY32:$rd, (fmaxnum TY32:$rs1, TY32:$rs2))]> {let xar_v = 1;}
  def prefix#FMAXNUMD : F3_3<2, 0b110110, 0b101110000,
    (outs RC64:$rd), (ins RC64:$rs1, RC64:$rs2),
    "fmaxd" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    [(set TY64:$rd, (fmaxnum TY64:$rs1, TY64:$rs2))]>;

  def prefix#FMINNUMS : F3_3<2, 0b110110, 0b101110011,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2),
    "fmins" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    [(set TY32:$rd, (fminnum TY32:$rs1, TY32:$rs2))]> {let xar_v = 1;}
  def prefix#FMINNUMD : F3_3<2, 0b110110, 0b101110010,
    (outs RC64:$rd), (ins RC64:$rs1, RC64:$rs2),
    "fmind" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    [(set TY64:$rd, (fminnum TY64:$rs1, TY64:$rs2))]>;

  // Other Unaries (VIS).

  def prefix#FRCPAS : F3_3u_vis<
    0b101110101,
    (outs RC32:$rd), (ins RC32:$rs2),
    "frcpas" # vectorsuffix # " $rs2, $rd" # remark,
    [(set TY32:$rd, (!cast<PatFrag>("int_sparc_rcpa_" # TY32) TY32:$rs2))]>;
  def prefix#FRCPAD : F3_3u_vis<
    0b101110100,
    (outs RC64:$rd), (ins RC64:$rs2),
    "frcpad" # vectorsuffix # " $rs2, $rd" # remark,
    [(set TY64:$rd, (!cast<PatFrag>("int_sparc_rcpa_" # TY64) TY64:$rs2))]>;

  def prefix#FRSQRTAS : F3_3u_vis<
    0b101110111,
    (outs RC32:$rd), (ins RC32:$rs2),
    "frsqrtas" # vectorsuffix # " $rs2, $rd" # remark,
    [(set TY32:$rd, (!cast<PatFrag>("int_sparc_rsqrta_" # TY32) TY32:$rs2))]>;
  def prefix#FRSQRTAD : F3_3u_vis<
    0b101110110,
    (outs RC64:$rd), (ins RC64:$rs2),
    "frsqrtad" # vectorsuffix # " $rs2, $rd" # remark,
    [(set TY64:$rd, (!cast<PatFrag>("int_sparc_rsqrta_" # TY64) TY64:$rs2))]>;
}

let Predicates = [IsACE] in
  defm Scalar : define_scalar_vector_variants<
  "", XFPRegs, f32, DFPRegs, f64, "", "">;
let xar_v = 1, xar_simd = 1, Predicates = [IsACE1] in
  defm V2 : define_scalar_vector_variants<
  "V2", V2FPRegs, v2f32, V2DFPRegs, v2f64, ",s", " /*v2*/">;
let xar_v = 1, xar_simd = 2, Predicates = [IsACE2] in
  defm V4 : define_scalar_vector_variants<
  "V4", V4FPRegs, v4f32, V4DFPRegs, v4f64, ",s", " /*v4*/">;

// FNMADD patterns.

let Predicates = [IsACE] in {
def : Pat<(f32 (fma (fneg f32:$rs1), f32:$rs2, (fneg f32:$rs3))),
          (FNMADDS f32:$rs1, f32:$rs2, f32:$rs3)>;
def : Pat<(f64 (fma (fneg f64:$rs1), f64:$rs2, (fneg f64:$rs3))),
          (FNMADDD f64:$rs1, f64:$rs2, f64:$rs3)>;
def : Pat<(f32 (fma f32:$rs1, (fneg f32:$rs2), (fneg f32:$rs3))),
          (FNMADDS f32:$rs1, f32:$rs2, f32:$rs3)>;
def : Pat<(f64 (fma f64:$rs1, (fneg f64:$rs2), (fneg f64:$rs3))),
          (FNMADDD f64:$rs1, f64:$rs2, f64:$rs3)>;
}
let Predicates = [IsACE1] in {
def : Pat<(v2f32 (fma (fneg v2f32:$rs1), v2f32:$rs2, (fneg v2f32:$rs3))),
          (V2FNMADDS v2f32:$rs1, v2f32:$rs2, v2f32:$rs3)>;
def : Pat<(v2f64 (fma (fneg v2f64:$rs1), v2f64:$rs2, (fneg v2f64:$rs3))),
          (V2FNMADDD v2f64:$rs1, v2f64:$rs2, v2f64:$rs3)>;
def : Pat<(v2f32 (fma v2f32:$rs1, (fneg v2f32:$rs2), (fneg v2f32:$rs3))),
          (V2FNMADDS v2f32:$rs1, v2f32:$rs2, v2f32:$rs3)>;
def : Pat<(v2f64 (fma v2f64:$rs1, (fneg v2f64:$rs2), (fneg v2f64:$rs3))),
          (V2FNMADDD v2f64:$rs1, v2f64:$rs2, v2f64:$rs3)>;
}
let Predicates = [IsACE2] in {
def : Pat<(v4f32 (fma (fneg v4f32:$rs1), v4f32:$rs2, (fneg v4f32:$rs3))),
          (V4FNMADDS v4f32:$rs1, v4f32:$rs2, v4f32:$rs3)>;
def : Pat<(v4f64 (fma (fneg v4f64:$rs1), v4f64:$rs2, (fneg v4f64:$rs3))),
          (V4FNMADDD v4f64:$rs1, v4f64:$rs2, v4f64:$rs3)>;
def : Pat<(v4f32 (fma v4f32:$rs1, (fneg v4f32:$rs2), (fneg v4f32:$rs3))),
          (V4FNMADDS v4f32:$rs1, v4f32:$rs2, v4f32:$rs3)>;
def : Pat<(v4f64 (fma v4f64:$rs1, (fneg v4f64:$rs2), (fneg v4f64:$rs3))),
          (V4FNMADDD v4f64:$rs1, v4f64:$rs2, v4f64:$rs3)>;
}

// FNMSUB patterns.

let Predicates = [IsACE] in {
def : Pat<(f32 (fma (fneg f32:$rs1), f32:$rs2, f32:$rs3)),
          (FNMSUBS f32:$rs1, f32:$rs2, f32:$rs3)>;
def : Pat<(f64 (fma (fneg f64:$rs1), f64:$rs2, f64:$rs3)),
          (FNMSUBD f64:$rs1, f64:$rs2, f64:$rs3)>;
}
let Predicates = [IsACE1] in {
def : Pat<(v2f32 (fma (fneg v2f32:$rs1), v2f32:$rs2, v2f32:$rs3)),
          (V2FNMSUBS v2f32:$rs1, v2f32:$rs2, v2f32:$rs3)>;
def : Pat<(v2f64 (fma (fneg v2f64:$rs1), v2f64:$rs2, v2f64:$rs3)),
          (V2FNMSUBD v2f64:$rs1, v2f64:$rs2, v2f64:$rs3)>;
}
let Predicates = [IsACE2] in {
def : Pat<(v4f32 (fma (fneg v4f32:$rs1), v4f32:$rs2, v4f32:$rs3)),
          (V4FNMSUBS v4f32:$rs1, v4f32:$rs2, v4f32:$rs3)>;
def : Pat<(v4f64 (fma (fneg v4f64:$rs1), v4f64:$rs2, v4f64:$rs3)),
          (V4FNMSUBD v4f64:$rs1, v4f64:$rs2, v4f64:$rs3)>;
}

// (Conversions between integer and FP are not used).

multiclass define_vector_type_conversion<
  string prefix,
  RegisterClass RC32, RegisterClass RC64,
  ValueType TYF32, ValueType TYI32, ValueType TYF64, ValueType TYI64,
  string remark> {
  def FITOS : F3_3u<2, 0b110100, 0b011000100,
    (outs RC32:$rd), (ins RC32:$rs2),
    "fitos,s $rs2, $rd" # remark,
    [(set TYF32:$rd, (sint_to_fp (TYI32 (bitconvert TYF32:$rs2))))]>;
  def FITOD : F3_3u<2, 0b110100, 0b011001000,
    (outs RC64:$rd), (ins RC32:$rs2),
    "fitod,s $rs2, $rd" # remark,
    [(set TYF64:$rd, (sint_to_fp (TYI32 (bitconvert TYF32:$rs2))))]>;

  def FXTOS : F3_3u<2, 0b110100, 0b010000100,
    (outs RC32:$rd), (ins RC64:$rs2),
    "fxtos,s $rs2, $rd" # remark,
    [(set TYF32:$rd, (sint_to_fp (TYI64 (bitconvert TYF64:$rs2))))]>;
  def FXTOD : F3_3u<2, 0b110100, 0b010001000,
    (outs RC64:$rd), (ins RC64:$rs2),
    "fxtod,s $rs2, $rd" # remark,
    [(set TYF64:$rd, (sint_to_fp (TYI64 (bitconvert TYF64:$rs2))))]>;

  def FSTOI : F3_3u<2, 0b110100, 0b011010001,
    (outs RC32:$rd), (ins RC32:$rs2),
    "fstoi,s $rs2, $rd" # remark,
    [(set TYF32:$rd, (bitconvert (TYI32 (fp_to_sint TYF32:$rs2))))]>;
  def FDTOI : F3_3u<2, 0b110100, 0b011010010,
    (outs RC32:$rd), (ins RC64:$rs2),
    "fdtoi,s $rs2, $rd" # remark,
    [(set TYF32:$rd, (bitconvert (TYI32 (fp_to_sint TYF64:$rs2))))]>;

  def FSTOX : F3_3u<2, 0b110100, 0b010000001,
    (outs RC64:$rd), (ins RC32:$rs2),
    "fstox,s $rs2, $rd" # remark,
    [(set TYF64:$rd, (bitconvert (TYI64 (fp_to_sint TYF32:$rs2))))]>;
  def FDTOX : F3_3u<2, 0b110100, 0b010000010,
    (outs RC64:$rd), (ins RC64:$rs2),
    "fdtox,s $rs2, $rd" # remark,
    [(set TYF64:$rd, (bitconvert (TYI64 (fp_to_sint TYF64:$rs2))))]>;

  def FSTOD : F3_3u<2, 0b110100, 0b011001001,
    (outs RC64:$rd), (ins RC32:$rs2),
    "fstod,s $rs2, $rd" # remark,
    [(set TYF64:$rd, (fextend TYF32:$rs2))]>;
  def FDTOS : F3_3u<2, 0b110100, 0b011000110,
    (outs RC32:$rd), (ins RC64:$rs2),
    "fdtos,s $rs2, $rd" # remark,
    [(set TYF32:$rd, (fround TYF64:$rs2))]>;
}

let xar_v = 1, xar_simd = 1, Predicates = [IsACE1] in
  defm V2 : define_vector_type_conversion<
  "V2", V2FPRegs, V2DFPRegs, v2f32, v2i32, v2f64, v2i64, " /*v2*/">;
let xar_v = 1, xar_simd = 2, Predicates = [IsACE2] in
  defm V4 : define_vector_type_conversion<
  "V4", V4FPRegs, V4DFPRegs, v4f32, v4i32, v4f64, v4i64, " /*v4*/">;

// The integer vetor instructions {FPMADDX, FPMADDXHI} are not
// defined.

multiclass define_integer_vector_variants<
  RegisterClass RC64, ValueType TY64,
  string vectorsuffix, string remark> {
  let NAME = !if (!eq (""#NAME, "E"), "", ""#NAME) in {

  // Binaries (64bit integer).

  def FPMADDX : F5_1<
    0b00, 0b00,
    (outs RC64:$rd), (ins RC64:$rs1, RC64:$rs2, RC64:$rs3),
    "fpmaddx" # vectorsuffix # " $rs1, $rs2, $rs3, $rd" # remark,
    []>;
  def FPMADDXHI : F5_1<
    0b01, 0b00,
    (outs RC64:$rd), (ins RC64:$rs1, RC64:$rs2, RC64:$rs3),
    "fpmaddxhi" # vectorsuffix # " $rs1, $rs2, $rs3, $rd" # remark,
    []>;
}
}

// SETCC/SELECT/VSELECT but with the condition in FP registers.  They
// are needed because the condition of FSELMOV should be in FP
// registers.  SELECT accepts conditions in both integer and FP
// registers, and one with an integer condition maps to FMOVR (which
// is a non-extended V9 instruction).

def SDT_SP_setcc_f : SDTypeProfile<
  1, 3, [SDTCisFP<0>, SDTCisFP<1>, SDTCisSameAs<1, 2>, SDTCisVT<3, OtherVT>]>;
def SDT_SP_select_f : SDTypeProfile<
  1, 3, [SDTCisFP<0>, SDTCisFP<1>, SDTCisSameAs<0, 2>, SDTCisSameAs<0, 3>]>;
def SDT_SP_bool_move_f : SDTypeProfile<
  1, 1, [SDTCisFP<0>, SDTCisInt<1>]>;
def SDT_SP_bool_move_i : SDTypeProfile<
  1, 1, [SDTCisInt<0>, SDTCisFP<1>]>;

//def SDT_SP_vselect : SDTypeProfile<
//  1, 3, [SDTCisSameAs<0, 1>, SDTCisSameAs<0, 2>, SDTCisSameAs<2, 3>,
//         SDTCisSameNumEltsAs<0, 1>]>;

def SPsetccf : SDNode<"SPISD::SETCC_F", SDT_SP_setcc_f>;
def SPselectf : SDNode<"SPISD::SELECT_F", SDT_SP_select_f>;
def SPboolmovef : SDNode<"SPISD::BOOL_MOVE_F", SDT_SP_bool_move_f>;
def SPboolmovei : SDNode<"SPISD::BOOL_MOVE_I", SDT_SP_bool_move_i>;

//def SPvselect : SDNode<"SPISD::SPVSELECT", SDT_SP_vselect>;

def : Pat<(v2f32 (SPboolmovef v2i1:$a)), (COPY_TO_REGCLASS $a, V2FPRegs)>;
def : Pat<(v2i1 (SPboolmovei v2f32:$a)), (COPY_TO_REGCLASS $a, V2FPRegs)>;
def : Pat<(v4f32 (SPboolmovef v4i1:$a)), (COPY_TO_REGCLASS $a, V4FPRegs)>;
def : Pat<(v4i1 (SPboolmovei v4f32:$a)), (COPY_TO_REGCLASS $a, V4FPRegs)>;

// Compare with result in registers (the op name is changed to FCMPR.
// The result types of SETCC on vectors are v2i1/v4i1.  The result
// type of SETCC on scalars is i1 at first, then converted to i32/i64.
// SETCC on scalar FPs are replaced by SETCC_F, when their use is
// SELECT on FPs.

multiclass define_compare_to_register_variants<
  string prefix, SDNode SETCCOP,
  RegisterClass RC32, ValueType TY32,
  RegisterClass RC64, ValueType TY64, ValueType TYCC,
  string vectorsuffix, string remark> {
  def prefix#FCMPREQS : F3_3_cmpr<
    0b0001,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2),
    "fcmpeqs" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    [(set TYCC:$rd, (SETCCOP TY32:$rs1, TY32:$rs2, SETEQ))]> {let xar_v = 1;}
  def prefix#FCMPREQES : F3_3_cmpr<
    0b0011,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2),
    "fcmpeqes" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    []> {let xar_v = 1;}
  def prefix#FCMPRLEES : F3_3_cmpr<
    0b0101,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2),
    "fcmplees" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    [(set TYCC:$rd, (SETCCOP TY32:$rs1, TY32:$rs2, SETLE))]> {let xar_v = 1;}
  def prefix#FCMPRLTES : F3_3_cmpr<
    0b0111,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2),
    "fcmpltes" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    [(set TYCC:$rd, (SETCCOP TY32:$rs1, TY32:$rs2, SETLT))]> {let xar_v = 1;}
  def prefix#FCMPRNES : F3_3_cmpr<
    0b1001,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2),
    "fcmpnes" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    [(set TYCC:$rd, (SETCCOP TY32:$rs1, TY32:$rs2, SETNE))]> {let xar_v = 1;}
  def prefix#FCMPRNEES : F3_3_cmpr<
    0b1011,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2),
    "fcmpnees" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    []> {let xar_v = 1;}
  def prefix#FCMPRGTES : F3_3_cmpr<
    0b1101,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2),
    "fcmpgtes" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    [(set TYCC:$rd, (SETCCOP TY32:$rs1, TY32:$rs2, SETGT))]> {let xar_v = 1;}
  def prefix#FCMPRGEES : F3_3_cmpr<
    0b1111,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2),
    "fcmpgees" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    [(set TYCC:$rd, (SETCCOP TY32:$rs1, TY32:$rs2, SETGE))]> {let xar_v = 1;}

  def prefix#FCMPREQD : F3_3_cmpr<
    0b0000,
    (outs RC32:$rd), (ins RC64:$rs1, RC64:$rs2),
    "fcmpeqd" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    [(set TYCC:$rd, (SETCCOP TY64:$rs1, TY64:$rs2, SETEQ))]>;
  def prefix#FCMPREQED : F3_3_cmpr<
    0b0010,
    (outs RC32:$rd), (ins RC64:$rs1, RC64:$rs2),
    "fcmpeqed" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    []>;
  def prefix#FCMPRLEED : F3_3_cmpr<
    0b0100,
    (outs RC32:$rd), (ins RC64:$rs1, RC64:$rs2),
    "fcmpleed" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    [(set TYCC:$rd, (SETCCOP TY64:$rs1, TY64:$rs2, SETLE))]>;
  def prefix#FCMPRLTED : F3_3_cmpr<
    0b0110,
    (outs RC32:$rd), (ins RC64:$rs1, RC64:$rs2),
    "fcmplted" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    [(set TYCC:$rd, (SETCCOP TY64:$rs1, TY64:$rs2, SETLT))]>;
  def prefix#FCMPRNED : F3_3_cmpr<
    0b1000,
    (outs RC32:$rd), (ins RC64:$rs1, RC64:$rs2),
    "fcmpned" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    [(set TYCC:$rd, (SETCCOP TY64:$rs1, TY64:$rs2, SETNE))]>;
  def prefix#FCMPRNEED : F3_3_cmpr<
    0b1010,
    (outs RC32:$rd), (ins RC64:$rs1, RC64:$rs2),
    "fcmpneed" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    []>;
  def prefix#FCMPRGTED : F3_3_cmpr<
    0b1100,
    (outs RC32:$rd), (ins RC64:$rs1, RC64:$rs2),
    "fcmpgted" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    [(set TYCC:$rd, (SETCCOP TY64:$rs1, TY64:$rs2, SETGT))]>;
  def prefix#FCMPRGEED : F3_3_cmpr<
    0b1110,
    (outs RC32:$rd), (ins RC64:$rs1, RC64:$rs2),
    "fcmpgeed" # vectorsuffix # " $rs1, $rs2, $rd" # remark,
    [(set TYCC:$rd, (SETCCOP TY64:$rs1, TY64:$rs2, SETGE))]>;
}

let Predicates = [IsACE] in
  defm Scalar : define_compare_to_register_variants<
  "", SPsetccf, XFPRegs, f32, DFPRegs, f64, f32, "", "">;
let xar_v = 1, xar_simd = 1, Predicates = [IsACE1] in
  defm V2 : define_compare_to_register_variants<
  "V2", setcc, V2FPRegs, v2f32, V2DFPRegs, v2f64, v2i1, ",s", " /*v2*/">;
let xar_v = 1, xar_simd = 2, Predicates = [IsACE2] in
  defm V4 : define_compare_to_register_variants<
  "V4", setcc, V4FPRegs, v4f32, V4DFPRegs, v4f64, v4i1, ",s", " /*v4*/">;

// [TODO] UNORDERED COMPARES ARE NOT CORRECT; ORDEREDNESS CHECKS ARE
// NOT DEFINED.  They should be changed to a combination of
// comparisons and negations.

multiclass define_compare_to_register_patterns<
  string prefix, SDNode SETCCOP,
  ValueType TY32, ValueType TY64, ValueType TYCC> {
  def : Pat<(TYCC (SETCCOP TY32:$lhs, TY32:$rhs, SETOEQ)),
    (!cast<Instruction>(prefix#FCMPREQES) TY32:$lhs, TY32:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY32:$lhs, TY32:$rhs, SETOGT)),
    (!cast<Instruction>(prefix#FCMPRGTES) TY32:$lhs, TY32:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY32:$lhs, TY32:$rhs, SETOGE)),
    (!cast<Instruction>(prefix#FCMPRGEES) TY32:$lhs, TY32:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY32:$lhs, TY32:$rhs, SETOLT)),
    (!cast<Instruction>(prefix#FCMPRLTES) TY32:$lhs, TY32:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY32:$lhs, TY32:$rhs, SETOLE)),
    (!cast<Instruction>(prefix#FCMPRLEES) TY32:$lhs, TY32:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY32:$lhs, TY32:$rhs, SETONE)),
    (!cast<Instruction>(prefix#FCMPRNEES) TY32:$lhs, TY32:$rhs)>;
  //def : Pat<(seto TY32:$lhs, TY32:$rhs),...>;
  //def : Pat<(setuo TY32:$lhs, TY32:$rhs),...>;
  def : Pat<(TYCC (SETCCOP TY32:$lhs, TY32:$rhs, SETUEQ)),
    (!cast<Instruction>(prefix#FCMPREQES) TY32:$lhs, TY32:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY32:$lhs, TY32:$rhs, SETUNE)),
    (!cast<Instruction>(prefix#FCMPRNEES) TY32:$lhs, TY32:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY32:$lhs, TY32:$rhs, SETUGT)),
    (!cast<Instruction>(prefix#FCMPRGTES) TY32:$lhs, TY32:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY32:$lhs, TY32:$rhs, SETUGE)),
    (!cast<Instruction>(prefix#FCMPRGEES) TY32:$lhs, TY32:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY32:$lhs, TY32:$rhs, SETULT)),
    (!cast<Instruction>(prefix#FCMPRLTES) TY32:$lhs, TY32:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY32:$lhs, TY32:$rhs, SETULE)),
    (!cast<Instruction>(prefix#FCMPRLEES) TY32:$lhs, TY32:$rhs)>;

  def : Pat<(TYCC (SETCCOP TY64:$lhs, TY64:$rhs, SETOEQ)),
    (!cast<Instruction>(prefix#FCMPREQED) TY64:$lhs, TY64:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY64:$lhs, TY64:$rhs, SETOGT)),
    (!cast<Instruction>(prefix#FCMPRGTED) TY64:$lhs, TY64:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY64:$lhs, TY64:$rhs, SETOGE)),
    (!cast<Instruction>(prefix#FCMPRGEED) TY64:$lhs, TY64:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY64:$lhs, TY64:$rhs, SETOLT)),
    (!cast<Instruction>(prefix#FCMPRLTED) TY64:$lhs, TY64:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY64:$lhs, TY64:$rhs, SETOLE)),
    (!cast<Instruction>(prefix#FCMPRLEED) TY64:$lhs, TY64:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY64:$lhs, TY64:$rhs, SETONE)),
    (!cast<Instruction>(prefix#FCMPRNEED) TY64:$lhs, TY64:$rhs)>;
  //def : Pat<(seto TY64:$lhs, TY64:$rhs),...>;
  //def : Pat<(setuo TY64:$lhs, TY64:$rhs),...>;
  def : Pat<(TYCC (SETCCOP TY64:$lhs, TY64:$rhs, SETUEQ)),
    (!cast<Instruction>(prefix#FCMPREQED) TY64:$lhs, TY64:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY64:$lhs, TY64:$rhs, SETUNE)),
    (!cast<Instruction>(prefix#FCMPRNEED) TY64:$lhs, TY64:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY64:$lhs, TY64:$rhs, SETUGT)),
    (!cast<Instruction>(prefix#FCMPRGTED) TY64:$lhs, TY64:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY64:$lhs, TY64:$rhs, SETUGE)),
    (!cast<Instruction>(prefix#FCMPRGEED) TY64:$lhs, TY64:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY64:$lhs, TY64:$rhs, SETULT)),
    (!cast<Instruction>(prefix#FCMPRLTED) TY64:$lhs, TY64:$rhs)>;
  def : Pat<(TYCC (SETCCOP TY64:$lhs, TY64:$rhs, SETULE)),
    (!cast<Instruction>(prefix#FCMPRLEED) TY64:$lhs, TY64:$rhs)>;
}

let Predicates = [IsACE] in
  defm Scalar : define_compare_to_register_patterns<
  "", SPsetccf, f32, f64, f32>;
let Predicates = [IsACE1] in
  defm V2 : define_compare_to_register_patterns<
  "V2", setcc, v2f32, v2f64, v2i1>;
let Predicates = [IsACE2] in
  defm V4 : define_compare_to_register_patterns<
  "V4", setcc, v4f32, v4f64, v4i1>;

multiclass define_select_move_variants<
  string prefix, SDNode SELECTOP,
  RegisterClass RC32, ValueType TY32,
  RegisterClass RC64, ValueType TY64, ValueType TYCC,
  string vectorsuffix, string remark> {
  def prefix#FSELMOVS : F5_1<
    0b11, 0b11,
    (outs RC32:$rd), (ins RC32:$rs1, RC32:$rs2, RC32:$rs3),
    "fselmovs" # vectorsuffix # " $rs1, $rs2, $rs3, $rd" # remark,
    [(set TY32:$rd, (SELECTOP TYCC:$rs3, TY32:$rs1, TY32:$rs2))]> {
    let xar_v = 1;}
  def prefix#FSELMOVD : F5_1<
    0b11, 0b00,
    (outs RC64:$rd), (ins RC64:$rs1, RC64:$rs2, RC32:$rs3),
    "fselmovd" # vectorsuffix # " $rs1, $rs2, $rs3, $rd" # remark,
    [(set TY64:$rd, (SELECTOP TYCC:$rs3, TY64:$rs1, TY64:$rs2))]>;
}

let Predicates = [IsACE] in
  defm Scalar : define_select_move_variants<
  "", SPselectf, XFPRegs, f32, DFPRegs, f64, f32, "", "">;
let xar_v = 1, xar_simd = 1, Predicates = [IsACE1] in
  defm V2 : define_select_move_variants<
  "V2", vselect,
  V2FPRegs, v2f32, V2DFPRegs, v2f64, v2i1, ",s", " /*v2*/">;
let xar_v = 1, xar_simd = 2, Predicates = [IsACE2] in
  defm V4 : define_select_move_variants<
  "V4", vselect,
  V4FPRegs, v4f32, V4DFPRegs, v4f64, v4i1, ",s", " /*v4*/">;

// SELECT operation using FMOVR.  A DOUBLE FP IS USED FOR BOTH
// SINGLE/DOUBLE-FP.  It is because the FMOVR instruction is not
// extended in S64fx, and a single-FP variant cannot be used due to
// the changed register layout.  It prefers FMOVR to FMOVCC here for
// FMOVR is easier, because SELECT_CC is taken to be expanded to use
// FSELMOV.

let Constraints = "$f = $rd", Predicates = [HasV9] in
  def FMOVRNZD : F4_4r<
  0b110101, 0b00110, 0b101,
  (outs FPDPRegs:$rd), (ins IntbRegs:$rs1, FPDPRegs:$rs2, FPDPRegs:$f),
  "fmovrdne $rs1, $rs2, $rd",
  []>;

def : Pat<(f32 (select i32:$rs1, f32:$rs2, f32:$f)),
          (f32 (FMOVRNZD $rs1, $rs2, $f))>;
def : Pat<(f64 (select i32:$rs1, f64:$rs2, f64:$f)),
          (f64 (FMOVRNZD $rs1, $rs2, $f))>;

let Constraints = "$f = $rd", Predicates = [HasV9] in
def MOVRNZrr : F4_4r<
  0b101111, 0b00000, 0b101,
  (outs IntRegs:$rd), (ins IntRegs:$rs1, IntRegs:$rs2, IntRegs:$f),
  "movrnz $rs1, $rs2, $rd",
  [(set i64:$rd, (select i32:$rs1, i64:$rs2, i64:$f))]>;

def : Pat<(select i32:$rs1, i32:$rs2, i32:$f),
          (MOVRNZrr i32:$rs1, i32:$rs2, i32:$f)>;

// Intrinsics.

/*
def V2FAND : F3_vis_b_zd<0b001110000, "fand,s",
        [(set v2f64:$rd, (int_sparc_and_v2f64 v2f64:$rs1, v2f64:$rs2))]>;
def V2FANDNOT1 : F3_vis_b_zd<0b001101000, "fandnot1,s",
        [(set v2f64:$rd, (int_sparc_andnot1_v2f64 v2f64:$rs1, v2f64:$rs2))]>;
def V2FOR : F3_vis_b_zd<0b001111100, "for,s",
        [(set v2f64:$rd, (int_sparc_or_v2f64 v2f64:$rs1, v2f64:$rs2))]>;
def V2FXOR : F3_vis_b_zd<0b001101100, "fxor,s",
        [(set v2f64:$rd, (int_sparc_xor_v2f64 v2f64:$rs1, v2f64:$rs2))]>;
def V2FNAND : F3_vis_b_zd<0b001101110, "fnand,s",
        [(set v2f64:$rd, (int_sparc_nand_v2f64 v2f64:$rs1, v2f64:$rs2))]>;
def V2FNOR : F3_vis_b_zd<0b001100010, "fnor,s",
        [(set v2f64:$rd, (int_sparc_nor_v2f64 v2f64:$rs1, v2f64:$rs2))]>;
def V2FXNOR : F3_vis_b_zd<0b001110010, "fxnor,s",
        [(set v2f64:$rd, (int_sparc_xnor_v2f64 v2f64:$rs1, v2f64:$rs2))]>;
def V2FMAXD : F3_vis_b_zd<0b101110000, "fmaxd,s",
        [(set v2f64:$rd, (int_sparc_max_v2f64 v2f64:$rs1, v2f64:$rs2))]>;
def V2FMIND : F3_vis_b_zd<0b101110010, "fmind,s",
        [(set v2f64:$rd, (int_sparc_min_v2f64 v2f64:$rs1, v2f64:$rs2))]>;
def V2FCMPEQD : F3_vis_b_zd<0b101100000, "fcmpeqd,s",
        [(set v2f64:$rd, (int_sparc_cmpeq_v2f64 v2f64:$rs1, v2f64:$rs2))]>;
def V2FCMPGEED : F3_vis_b_zd<0b101101110, "fcmpgeed,s",
        [(set v2f64:$rd, (int_sparc_cmpge_v2f64 v2f64:$rs1, v2f64:$rs2))]>;
def V2FCMPGTED : F3_vis_b_zd<0b101101100, "fcmpgted,s",
        [(set v2f64:$rd, (int_sparc_cmpgt_v2f64 v2f64:$rs1, v2f64:$rs2))]>;
def V2FCMPLEED : F3_vis_b_zd<0b101100100, "fcmpleed,s",
        [(set v2f64:$rd, (int_sparc_cmple_v2f64 v2f64:$rs1, v2f64:$rs2))]>;
def V2FCMPLTED : F3_vis_b_zd<0b101100110, "fcmplted,s",
        [(set v2f64:$rd, (int_sparc_cmplt_v2f64 v2f64:$rs1, v2f64:$rs2))]>;
def V2FCMPNED : F3_vis_b_zd<0b101101000, "fcmpned,s",
        [(set v2f64:$rd, (int_sparc_cmpneq_v2f64 v2f64:$rs1, v2f64:$rs2))]>;
*/
