`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:11:09 11/09/2023 
// Design Name: 
// Module Name:    EM_Reg 
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
module EM_Reg(
    input clk,
    input reset,
    input req,
    input [31:0] RD2_E,
    input [31:0] ANS_E,
    input MemWrite_E,
    input MemToReg_E,
    input [31:0] IMMNUM_E,
    input [4:0] WR_E,
    input [31:0] PCplus4_E,
    input RegWrite_E,
    input SaveImm_E,
    input WritePC_E,
	input [31:0] PC_E,
	input writeHI_E,//new
	input writeLO_E,//new
	input [31:0] HI_E,
	input [31:0] LO_E,
	input [2:0] store_type_E,
	input [2:0] load_type_E,
    input BD_E,
    input writec0_E,
    input changec0_E,
    input jepc_E,
    input w_cp0_epc_E,
    input EXLClr_E,
    input [4:0] ExcCode_E,
    output reg [4:0] ExcCode_M,
    output reg EXLClr_M,
    output reg w_cp0_epc_M,
    output reg jepc_M,
    output reg writec0_M,
    output reg changec0_M,
    output reg BD_M,
	output reg [2:0] store_type_M,
	output reg [2:0] load_type_M,
	output reg [31:0] HI_M,
	output reg [31:0] LO_M,
	output reg writeHI_M,//new
	output reg writeLO_M,//new
    output reg [31:0] RD2_M,
    output reg [31:0] ANS_M,
    output reg MemWrite_M,
    output reg MemToReg_M,
    output reg [31:0] IMMNUM_M,
    output reg [4:0] WR_M,
    output reg [31:0] PCplus4_M,
    output reg RegWrite_M,
    output reg SaveImm_M,
    output reg WritePC_M,
	 output reg [31:0] PC_M
    );
	 
	 always@(posedge clk) begin
			if(reset == 1) begin
                ExcCode_M <= 0;
                EXLClr_M <= 0;
                w_cp0_epc_M <= 0;
                jepc_M <= 0;
                writec0_M <= 0;
                changec0_M <= 0;
                BD_M <= 0;
                load_type_M <= 0;
                store_type_M <= 0;
				HI_M <= 0;
				LO_M <= 0;
				writeHI_M <= 0;
				writeLO_M <= 0;
				RD2_M <= 0;
                ANS_M <= 0;
                MemWrite_M <= 0;
                MemToReg_M <= 0;
                IMMNUM_M <= 0;
                WR_M <= 0;
                PCplus4_M <= 0;
                RegWrite_M <= 0;
                SaveImm_M <= 0;
                WritePC_M <= 0;
				PC_M <= 0;
			end
            else if(req) begin
                ExcCode_M <= 0;
                EXLClr_M <= 0;
                w_cp0_epc_M <= 0;
                jepc_M <= 0;
                writec0_M <= 0;
                changec0_M <= 0;
                BD_M <= 0;
                load_type_M <= 0;
                store_type_M <= 0;
				HI_M <= 0;
				LO_M <= 0;
				writeHI_M <= 0;
				writeLO_M <= 0;
				RD2_M <= 0;
                ANS_M <= 0;
                MemWrite_M <= 0;
                MemToReg_M <= 0;
                IMMNUM_M <= 0;
                WR_M <= 0;
                PCplus4_M <= 0;
                RegWrite_M <= 0;
                SaveImm_M <= 0;
                WritePC_M <= 0;
				PC_M <= 0;
            end
			else begin
                ExcCode_M <= ExcCode_E;
                EXLClr_M <= EXLClr_E;
                w_cp0_epc_M <= w_cp0_epc_E;
                jepc_M <= jepc_E;
                writec0_M <= writec0_E;
                changec0_M <= changec0_E;
                BD_M <= BD_E;
                load_type_M <= load_type_E;
                store_type_M <= store_type_E;
				HI_M <= HI_E;
				LO_M <= LO_E;
				writeHI_M <= writeHI_E;
				writeLO_M <= writeLO_E;
				RD2_M <= RD2_E;
                ANS_M <= ANS_E;
                MemWrite_M <= MemWrite_E;
                MemToReg_M <= MemToReg_E;
                IMMNUM_M <= IMMNUM_E;
                WR_M <= WR_E;
                PCplus4_M <= PCplus4_E;
                RegWrite_M <= RegWrite_E;
                SaveImm_M <= SaveImm_E;
                WritePC_M <= WritePC_E;	
				PC_M <= PC_E;
			end
	 end


endmodule
