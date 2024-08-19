`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:25:07 11/01/2023 
// Design Name: 
// Module Name:    ETX 
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
module ETX(
    input [15:0] in,
    input ExtOp,
    output [31:0] extendednum
    );
	 
	 assign extendednum = ExtOp == 1 ? {{16{in[15]}},in[15:0]}:
																		   {{16{1'b0}},in[15:0]};

endmodule
