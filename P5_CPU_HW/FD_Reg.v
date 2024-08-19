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
    input [31:0] instru,
    //input [31:0] PCplus4,
	 input [31:0] PC,
    //output reg [31:0] PCplus4_D,
    output reg [31:0] instru_D,
	 output reg [31:0] PC_D
    );
	 always @ (posedge clk) begin
			if(en == 0) begin
				//PCplus4_D <= PCplus4_D;
				instru_D <= instru_D;
				PC_D <= PC_D;
			end
			else if (reset == 1) begin
				//PCplus4_D <= 32'h00003000;
				instru_D <= 0;
				PC_D <= 32'h00003000;
			end
			else begin
				//PCplus4_D <= PCplus4;
				instru_D <= instru;
				PC_D <= PC;
			end
	 end	 

endmodule
