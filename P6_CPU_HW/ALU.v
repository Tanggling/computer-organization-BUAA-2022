`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:21:02 11/01/2023 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] in1,
    input [31:0] in2,
    input [2:0] op,
    output [31:0] ans
    );
	 wire slt = $signed(in1) < $signed(in2);
	 wire sltu = in1 < in2;
	  
	 assign ans = (op == 3'b000)? (in1 + in2):
							 (op == 3'b001)? (in1 - in2):
							 (op == 3'b010)? (in1 | in2):
							 (op == 3'b011)?  (in1 & in2):
							 (op == 3'b100)?  slt:
																sltu;
endmodule
