`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:00:17 11/09/2023 
// Design Name: 
// Module Name:    DE_Reg 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DE_Reg(
    input clk,
    input reset,
    input [4:0] WR_D,
    input [31:0] RD1_D,
    input [31:0] RD2_D,
    input [31:0] EXTNUM_D,
    input [31:0] PCplus4_D,
    input [31:0] IMMNUM_D,
    input [2:0] ALUOP_D,
	 input aluchose_D,
    input SecRT_D,
    input MemWrite_D,
    input MemToReg_D,
    input RegWrite_D,
    input SaveImm_D,
    input WritePC_D,
	 input [31:0] PC_D,
	 input writeHI_D,//new
	 input writeLO_D,//new
	 input changeHI_D,
	 input changeLO_D,
	 input [2:0] store_type_D,
	 input [2:0] load_type_D,
	 output reg [2:0] load_type_E,
	 output reg [2:0] store_type_E,
	 output reg changeHI_E,
	 output reg changeLO_E,
	 output reg writeHI_E,//new
	 output reg writeLO_E,//new
	 output reg [4:0] WR_E,
    output reg [31:0] RD1_E,
    output reg [31:0] RD2_E,
    output reg [31:0] EXTNUM_E,
    output reg [31:0] PCplus4_E,
    output reg [31:0] IMMNUM_E,
    output reg [2:0] ALUOP_E,
	 output reg aluchose_E,
    output reg SecRT_E,
    output reg MemWrite_E,
    output reg MemToReg_E,
    output reg RegWrite_E,
    output reg SaveImm_E,
    output reg WritePC_E,
	 output reg [31:0] PC_E
    );

	 always@(posedge clk) begin
			if(reset == 1) begin
			load_type_E <= 0;
			store_type_E <= 0;
			changeHI_E <= 0;
			changeLO_E <= 0;
					writeHI_E <= 0;
					writeLO_E <= 0;
					WR_E <= 0;
					RD1_E <= 0;
					RD2_E <= 0;
					EXTNUM_E <= 0;
					PCplus4_E <= 0;
					IMMNUM_E <= 0;
					ALUOP_E <= 0;
					aluchose_E <= 0;
					SecRT_E <= 0;
					MemWrite_E <= 0;
					MemToReg_E <= 0;
					RegWrite_E <= 0;
					SaveImm_E <= 0;
					WritePC_E <= 0;
					PC_E <= 0;
			end
			else begin
			load_type_E <= load_type_D;
			store_type_E <= store_type_D;
			changeHI_E <= changeHI_D;
			changeLO_E <= changeLO_D;
					writeHI_E <= writeHI_D;
					writeLO_E <= writeLO_D;
					WR_E <= WR_D;
					RD1_E <= RD1_D;
					RD2_E <= RD2_D;
					EXTNUM_E <= EXTNUM_D;
					PCplus4_E <= PCplus4_D;
					IMMNUM_E <= IMMNUM_D;
					ALUOP_E <= ALUOP_D;
					aluchose_E <= aluchose_D;
					SecRT_E <= SecRT_D;
					MemWrite_E <= MemWrite_D;
					MemToReg_E <= MemToReg_D;
					RegWrite_E <= RegWrite_D;
					SaveImm_E <= SaveImm_D;
					WritePC_E <= WritePC_D;
					PC_E <= PC_D;
			end
	 end
endmodule
