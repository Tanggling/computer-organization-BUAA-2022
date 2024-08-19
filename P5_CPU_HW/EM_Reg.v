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
