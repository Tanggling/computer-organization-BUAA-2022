////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: IFU_synthesis.v
// /___/   /\     Timestamp: Wed Nov 01 22:20:30 2023
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -insert_glbl true -w -dir netgen/synthesis -ofmt verilog -sim IFU.ngc IFU_synthesis.v 
// Device	: xc6slx4-3-tqg144
// Input file	: IFU.ngc
// Output file	: D:\codefield\ISE_Verilog\my_CPU\netgen\synthesis\IFU_synthesis.v
// # of Modules	: 1
// Design Name	: IFU
// Xilinx        : D:\ISE\14.7\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module IFU (
  clk, reset, PC, nowPC, instru
);
  input clk;
  input reset;
  output PC;
  input [31 : 0] nowPC;
  output [31 : 0] instru;
  wire nowPC_0_IBUF_0;
  wire clk_BUFGP_1;
  wire PC_reg_2;
  wire instru_28_OBUF_38;
  wire instru_31_OBUF_39;
  FD   PC_reg (
    .C(clk_BUFGP_1),
    .D(nowPC_0_IBUF_0),
    .Q(PC_reg_2)
  );
  IBUF   nowPC_0_IBUF (
    .I(nowPC[0]),
    .O(nowPC_0_IBUF_0)
  );
  OBUF   instru_31_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[31])
  );
  OBUF   instru_30_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[30])
  );
  OBUF   instru_29_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[29])
  );
  OBUF   instru_28_OBUF (
    .I(instru_28_OBUF_38),
    .O(instru[28])
  );
  OBUF   instru_27_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[27])
  );
  OBUF   instru_26_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[26])
  );
  OBUF   instru_25_OBUF (
    .I(instru_28_OBUF_38),
    .O(instru[25])
  );
  OBUF   instru_24_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[24])
  );
  OBUF   instru_23_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[23])
  );
  OBUF   instru_22_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[22])
  );
  OBUF   instru_21_OBUF (
    .I(instru_28_OBUF_38),
    .O(instru[21])
  );
  OBUF   instru_20_OBUF (
    .I(instru_28_OBUF_38),
    .O(instru[20])
  );
  OBUF   instru_19_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[19])
  );
  OBUF   instru_18_OBUF (
    .I(instru_28_OBUF_38),
    .O(instru[18])
  );
  OBUF   instru_17_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[17])
  );
  OBUF   instru_16_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[16])
  );
  OBUF   instru_15_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[15])
  );
  OBUF   instru_14_OBUF (
    .I(instru_28_OBUF_38),
    .O(instru[14])
  );
  OBUF   instru_13_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[13])
  );
  OBUF   instru_12_OBUF (
    .I(instru_28_OBUF_38),
    .O(instru[12])
  );
  OBUF   instru_11_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[11])
  );
  OBUF   instru_10_OBUF (
    .I(instru_28_OBUF_38),
    .O(instru[10])
  );
  OBUF   instru_9_OBUF (
    .I(instru_28_OBUF_38),
    .O(instru[9])
  );
  OBUF   instru_8_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[8])
  );
  OBUF   instru_7_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[7])
  );
  OBUF   instru_6_OBUF (
    .I(instru_28_OBUF_38),
    .O(instru[6])
  );
  OBUF   instru_5_OBUF (
    .I(instru_28_OBUF_38),
    .O(instru[5])
  );
  OBUF   instru_4_OBUF (
    .I(instru_28_OBUF_38),
    .O(instru[4])
  );
  OBUF   instru_3_OBUF (
    .I(instru_28_OBUF_38),
    .O(instru[3])
  );
  OBUF   instru_2_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[2])
  );
  OBUF   instru_1_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[1])
  );
  OBUF   instru_0_OBUF (
    .I(instru_31_OBUF_39),
    .O(instru[0])
  );
  OBUF   PC_OBUF (
    .I(PC_reg_2),
    .O(PC)
  );
  BUFGP   clk_BUFGP (
    .I(clk),
    .O(clk_BUFGP_1)
  );
  VCC   XST_VCC1 (
    .P(instru_28_OBUF_38)
  );
  GND   XST_GND1 (
    .G(instru_31_OBUF_39)
  );
endmodule


`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

