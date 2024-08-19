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
    input [1:0] op,
    output [31:0] ans
    );
	  
	 assign ans = (op == 2'b00)? (in1 + in2):
							 (op == 2'b01)? (in1 - in2):
															(in1 | in2);
endmodule
