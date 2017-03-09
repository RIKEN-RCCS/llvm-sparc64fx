//===-- SparcInstrFormats.td - Sparc Instruction Formats ---*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

// [S64fx] XAR bits hold the bits for the extended register numbers,
// which will be stored in the SXAR1/2 prefix instructions.
// (rd{11-9}:rs1{8-6}:rs2{5-3}:rs3{2-0}).  These bits are taken from
// the operands, and are temporarily stored in the higher bits in
// Inst.  xar_v indicates extened instructions, and xar_simd=0 for
// scalar, xar_simd=1 for 2-SIMD, simd=2 for 4-SIMD.  The bits xar_v
// and xar_simd are also stored in TSFlags, which needs to be checked
// before machine code emission.  MEMO: (0) The higher bits in Inst
// are used instead of TSFlags, because storing them in TSFlags caused
// undefined values which err with "Invalid TSFlags bit in INSN".  (1)
// Bits of SoftFail and Size are made match to Inst.  They are set 48
// bits to make tblgen not warn for disassembler (instruction
// conflicts).

class InstSP<dag outs, dag ins, string asmstr, list<dag> pattern,
             InstrItinClass itin = NoItinerary>
   : Instruction {
  field bits<48> Inst;

  let Namespace = "SP";
  let Size = 6;

  bits<2> op;
  let Inst{31-30} = op;               // Top two bits are the 'op' field
  let Inst{47-32} = 0;

  dag OutOperandList = outs;
  dag InOperandList = ins;
  let AsmString   = asmstr;
  let Pattern = pattern;

  let DecoderNamespace = "Sparc";
  field bits<48> SoftFail = 0;

  let Itinerary = itin;

  bits<1> xar_v = 0;
  bits<2> xar_simd = 0;
  let TSFlags{2} = xar_v;
  let TSFlags{1-0} = xar_simd;

  bits<3> xar_rd = 0;
  bits<3> xar_rs1 = 0;
  bits<3> xar_rs2 = 0;
  bits<3> xar_rs3 = 0;
  bits<15> xar;
  let xar{14} = xar_v;
  let xar{13-12} = xar_simd;
  let xar{11-9} = xar_rd;
  let xar{8-6} = xar_rs1;
  let xar{5-3} = xar_rs2;
  let xar{2-0} = xar_rs3;
  let Inst{46-32} = xar;
}

//===----------------------------------------------------------------------===//
// Format #2 instruction classes in the Sparc
//===----------------------------------------------------------------------===//

// Format 2 instructions
class F2<dag outs, dag ins, string asmstr, list<dag> pattern,
         InstrItinClass itin = NoItinerary>
   : InstSP<outs, ins, asmstr, pattern, itin> {
  bits<3>  op2;
  bits<22> imm22;
  let op          = 0;    // op = 0
  let Inst{24-22} = op2;
  let Inst{21-0}  = imm22;
}

// Specific F2 classes: SparcV8 manual, page 44
//
class F2_1<bits<3> op2Val, dag outs, dag ins, string asmstr, list<dag> pattern,
           InstrItinClass itin = NoItinerary>
   : F2<outs, ins, asmstr, pattern, itin> {
  bits<5>  rd;

  let op2         = op2Val;

  let Inst{29-25} = rd;
}

class F2_2<bits<3> op2Val, bit annul, dag outs, dag ins, string asmstr,
           list<dag> pattern, InstrItinClass itin = NoItinerary>
   : F2<outs, ins, asmstr, pattern, itin> {
  bits<4>   cond;
  let op2         = op2Val;

  let Inst{29}    = annul;
  let Inst{28-25} = cond;
}

class F2_3<bits<3> op2Val, bit annul, bit pred,
           dag outs, dag ins, string asmstr, list<dag> pattern,
           InstrItinClass itin = NoItinerary>
   : InstSP<outs, ins, asmstr, pattern, itin> {
  bits<2>  cc;
  bits<4>  cond;
  bits<19> imm19;

  let op          = 0;    // op = 0

  let Inst{29}    = annul;
  let Inst{28-25} = cond;
  let Inst{24-22} = op2Val;
  let Inst{21-20} = cc;
  let Inst{19}    = pred;
  let Inst{18-0}  = imm19;
}

class F2_4<bits<3> cond, bit annul, bit pred, dag outs, dag ins,
           string asmstr, list<dag> pattern, InstrItinClass itin = NoItinerary>
   : InstSP<outs, ins, asmstr, pattern, itin> {
  bits<16> imm16;
  bits<5>  rs1;

  let op          = 0;    // op = 0

  let Inst{29}    = annul;
  let Inst{28}    = 0;
  let Inst{27-25} = cond;
  let Inst{24-22} = 0b011;
  let Inst{21-20} = imm16{15-14};
  let Inst{19}    = pred;
  let Inst{18-14} = rs1;
  let Inst{13-0}  = imm16{13-0};
}


//===----------------------------------------------------------------------===//
// Format #3 instruction classes in the Sparc
//===----------------------------------------------------------------------===//

class F3<dag outs, dag ins, string asmstr, list<dag> pattern,
         InstrItinClass itin = NoItinerary>
   : InstSP<outs, ins, asmstr, pattern, itin> {
  bits<8> rd;
  bits<6> op3;
  bits<8> rs1;
  let op{1} = 1;   // Op = 2 or 3
  let Inst{29-25} = rd{4-0};
  let Inst{24-19} = op3;
  let Inst{18-14} = rs1{4-0};
  let xar_rd = rd{7-5};
  let xar_rs1 = rs1{7-5};
}

// Specific F3 classes: SparcV8 manual, page 44
//
class F3_1_asi<bits<2> opVal, bits<6> op3val, dag outs, dag ins,
           string asmstr, list<dag> pattern, InstrItinClass itin = NoItinerary>
   : F3<outs, ins, asmstr, pattern, itin> {
  bits<8> asi;
  bits<8> rs2;

  let op         = opVal;
  let op3        = op3val;

  let Inst{13}   = 0;     // i field = 0
  let Inst{12-5} = asi;   // address space identifier
  let Inst{4-0}  = rs2{4-0};
  let xar_rs2 = rs2{7-5};
}

class F3_1<bits<2> opVal, bits<6> op3val, dag outs, dag ins, string asmstr,
       list<dag> pattern, InstrItinClass itin = IIC_iu_instr>
  : F3_1_asi<opVal, op3val, outs, ins, asmstr, pattern, itin> {
  let asi = 0;
}

class F3_2<bits<2> opVal, bits<6> op3val, dag outs, dag ins,
           string asmstr, list<dag> pattern, InstrItinClass itin = IIC_iu_instr>
   : F3<outs, ins, asmstr, pattern, itin> {
  bits<13> simm13;

  let op         = opVal;
  let op3        = op3val;

  let Inst{13}   = 1;     // i field = 1
  let Inst{12-0} = simm13;
}

// floating-point
class F3_3<bits<2> opVal, bits<6> op3val, bits<9> opfval, dag outs, dag ins,
           string asmstr, list<dag> pattern, InstrItinClass itin = NoItinerary>
   : F3<outs, ins, asmstr, pattern, itin> {
  bits<8> rs2;

  let op         = opVal;
  let op3        = op3val;

  let Inst{13-5} = opfval;   // fp opcode
  let Inst{4-0}  = rs2{4-0};
  let xar_rs2 = rs2{7-5};
}

// floating-point unary operations.
class F3_3u<bits<2> opVal, bits<6> op3val, bits<9> opfval, dag outs, dag ins,
           string asmstr, list<dag> pattern, InstrItinClass itin = NoItinerary>
   : F3<outs, ins, asmstr, pattern, itin> {
  bits<8> rs2;

  let op         = opVal;
  let op3        = op3val;
  let rs1        = 0;

  let Inst{13-5} = opfval;   // fp opcode
  let Inst{4-0}  = rs2{4-0};
  let xar_rs2 = rs2{7-5};
}

// floating-point compares.
class F3_3c<bits<2> opVal, bits<6> op3val, bits<9> opfval, dag outs, dag ins,
           string asmstr, list<dag> pattern, InstrItinClass itin = NoItinerary>
   : F3<outs, ins, asmstr, pattern, itin> {
  bits<8> rs2;

  let op         = opVal;
  let op3        = op3val;

  let Inst{13-5} = opfval;   // fp opcode
  let Inst{4-0}  = rs2{4-0};
  let xar_rs2 = rs2{7-5};
}

// Shift by register rs2.
class F3_Sr<bits<2> opVal, bits<6> op3val, bit xVal, dag outs, dag ins,
            string asmstr, list<dag> pattern, InstrItinClass itin = IIC_iu_instr>
   : F3<outs, ins, asmstr, pattern, itin> {
  bit x = xVal;           // 1 for 64-bit shifts.
  bits<8> rs2;

  let op         = opVal;
  let op3        = op3val;

  let Inst{13}   = 0;     // i field = 0
  let Inst{12}   = x;     // extended registers.
  let Inst{4-0}  = rs2{4-0};
  let xar_rs2 = rs2{7-5};
}

// Shift by immediate.
class F3_Si<bits<2> opVal, bits<6> op3val, bit xVal, dag outs, dag ins,
            string asmstr, list<dag> pattern, InstrItinClass itin = IIC_iu_instr>
   : F3<outs, ins, asmstr, pattern, itin> {
  bit x = xVal;           // 1 for 64-bit shifts.
  bits<6> shcnt;          // shcnt32 / shcnt64.

  let op         = opVal;
  let op3        = op3val;

  let Inst{13}   = 1;     // i field = 1
  let Inst{12}   = x;     // extended registers.
  let Inst{5-0}  = shcnt;
}

// Define rr and ri shift instructions with patterns.
multiclass F3_S<string OpcStr, bits<6> Op3Val, bit XVal, SDNode OpNode,
                ValueType VT, RegisterClass RC,
                InstrItinClass itin = IIC_iu_instr> {
  def rr : F3_Sr<2, Op3Val, XVal, (outs RC:$rd), (ins RC:$rs1, IntRegs:$rs2),
                 !strconcat(OpcStr, " $rs1, $rs2, $rd"),
                 [(set VT:$rd, (OpNode VT:$rs1, i32:$rs2))],
                 itin>;
  def ri : F3_Si<2, Op3Val, XVal, (outs RC:$rd), (ins RC:$rs1, i32imm:$shcnt),
                 !strconcat(OpcStr, " $rs1, $shcnt, $rd"),
                 [(set VT:$rd, (OpNode VT:$rs1, (i32 imm:$shcnt)))],
                 itin>;
}

class F4<bits<6> op3, dag outs, dag ins, string asmstr, list<dag> pattern,
           InstrItinClass itin = NoItinerary>
   : InstSP<outs, ins, asmstr, pattern, itin> {
  bits<8> rd;

  let op          = 2;
  let Inst{29-25} = rd{4-0};
  let Inst{24-19} = op3;
  let xar_rd = rd{7-5};
}


class F4_1<bits<6> op3, dag outs, dag ins,
           string asmstr, list<dag> pattern,
           InstrItinClass itin = NoItinerary>
   : F4<op3, outs, ins, asmstr, pattern, itin> {
  bit    intcc;
  bits<2> cc;
  bits<4> cond;
  bits<8> rs2;

  let Inst{4-0}   = rs2{4-0};
  let Inst{12-11} = cc;
  let Inst{13}    = 0;
  let Inst{17-14} = cond;
  let Inst{18}    = intcc;
  let xar_rs2 = rs2{7-5};
}

class F4_2<bits<6> op3, dag outs, dag ins,
            string asmstr, list<dag> pattern,
            InstrItinClass itin = NoItinerary>
   : F4<op3, outs, ins, asmstr, pattern, itin> {
  bit      intcc;
  bits<2>  cc;
  bits<4>  cond;
  bits<11> simm11;

  let Inst{10-0}  = simm11;
  let Inst{12-11} = cc;
  let Inst{13}    = 1;
  let Inst{17-14} = cond;
  let Inst{18}    = intcc;
}

class F4_3<bits<6> op3, bits<6> opf_low, dag outs, dag ins,
           string asmstr, list<dag> pattern,
           InstrItinClass itin = NoItinerary>
   : F4<op3, outs, ins, asmstr, pattern, itin> {
  bits<4> cond;
  bit     intcc;
  bits<2> opf_cc;
  bits<8> rs2;

  let Inst{18}     = 0;
  let Inst{17-14}  = cond;
  let Inst{13}     = intcc;
  let Inst{12-11}  = opf_cc;
  let Inst{10-5}   = opf_low;
  let Inst{4-0}    = rs2{4-0};
  let xar_rs2 = rs2{7-5};
}

class F4_4r<bits<6> op3, bits<5> opf_low, bits<3> rcond, dag outs, dag ins,
            string asmstr, list<dag> pattern,
            InstrItinClass itin = NoItinerary>
   : F4<op3, outs, ins, asmstr, pattern, itin> {
  bits <8> rs1;
  bits <8> rs2;
  let Inst{18-14} = rs1{4-0};
  let Inst{13}    = 0;  // IsImm
  let Inst{12-10} = rcond;
  let Inst{9-5}   = opf_low;
  let Inst{4-0}   = rs2{4-0};
  let xar_rs1 = rs1{7-5};
  let xar_rs2 = rs2{7-5};
}


class F4_4i<bits<6> op3, bits<3> rcond, dag outs, dag ins,
            string asmstr, list<dag> pattern,
           InstrItinClass itin = NoItinerary>
   : F4<op3, outs, ins, asmstr, pattern, itin> {
  bits<8> rs1;
  bits<10> simm10;
  let Inst{18-14} = rs1{4-0};
  let Inst{13}    = 1;  // IsImm
  let Inst{12-10} = rcond;
  let Inst{9-0}   = simm10;
  let xar_rs1 = rs1{7-5};
}


class TRAPSP<bits<6> op3Val, bit isimm, dag outs, dag ins,
             string asmstr, list<dag> pattern,
             InstrItinClass itin = NoItinerary>
   : F3<outs, ins, asmstr, pattern, itin> {
   bits<4> cond;
   bits<2> cc;

   let op = 0b10;
   let rd{4} = 0;
   let rd{3-0} = cond;
   let op3 = op3Val;
   let Inst{13} = isimm;
   let Inst{12-11} = cc;
}

class TRAPSPrr<bits<6> op3Val, dag outs, dag ins,
               string asmstr, list<dag> pattern,
               InstrItinClass itin = NoItinerary>
   : TRAPSP<op3Val, 0, outs, ins, asmstr, pattern, itin> {
   bits<5> rs2;

   let Inst{10-5} = 0;
   let Inst{4-0}  = rs2;
}

class TRAPSPri<bits<6> op3Val, dag outs, dag ins,
               string asmstr, list<dag> pattern,
               InstrItinClass itin = NoItinerary>
   : TRAPSP<op3Val, 1, outs, ins, asmstr, pattern, itin> {
   bits<8> imm;

   let Inst{10-8} = 0;
   let Inst{7-0}  = imm;
}

// Pseudo-instructions for alternate assembly syntax (never used by codegen).
// These are aliases that require C++ handling to convert to the target
// instruction, while InstAliases can be handled directly by tblgen.
class AsmPseudoInst<dag outs, dag ins, string asm>
  : InstSP<outs, ins, asm, []> {
  let isPseudo = 1;
}
