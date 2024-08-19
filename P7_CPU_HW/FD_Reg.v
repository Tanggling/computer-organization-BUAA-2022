`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:47:07 11/09/2023 
// Design Name: 
// Module Name:    FD_Reg 
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
module FD_Reg(
    input clk,
    input reset,
    input en,
	input nc,
	input req,
    input [31:0] instru,
    //input [31:0] PCplus4,
	input [31:0] PC,
	input [4:0] ExcCode_F,
	input BD_F,
	output reg BD_D,
	output reg [4:0] ExcCode_D,
    //output reg [31:0] PCplus4_D,
    output reg [31:0] instru_D,
	output reg [31:0] PC_D
    );
	 always @ (posedge clk) begin
			if (reset == 1) begin
				//PCplus4_D <= 32'h00003000;
				BD_D <= 0;
				ExcCode_D <= 0;
				instru_D <= 0;
				PC_D <= 32'h00003000;
			end
			else if(req) begin
				BD_D <= 0;
				ExcCode_D <= 0;
				instru_D <= 0;
				PC_D <= PC;
			end
			else if(en == 0) begin
				//PCplus4_D <= PCplus4_D;
				BD_D <= BD_D;
				ExcCode_D <= ExcCode_D;
				instru_D <= instru_D;
				PC_D <= PC_D;
			end
			else begin
				//PCplus4_D <= PCplus4;
				if (nc == 1) begin
					BD_D <= 0;
					ExcCode_D <= 0;
					instru_D <= 0;
				end
				else begin
					BD_D <= BD_F;
					ExcCode_D <= ExcCode_F;
					instru_D <= instru;
				end
				PC_D <= PC;
			end
	 end	 

endmodule
