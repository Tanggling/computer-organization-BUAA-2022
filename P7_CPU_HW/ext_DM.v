`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:20:18 11/21/2023 
// Design Name: 
// Module Name:    ext_DM 
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
module ext_DM(
    input [31:0] Din,
    output [31:0] Dout,
    input [1:0] A,
    input [2:0] op
    );
	
	 wire [7:0] n31_24 = Din[31:24];
	 wire [7:0] n23_16 = Din[23:16];
	 wire [7:0] n15_8 = Din[15:8];
	 wire [7:0] n7_0 = Din[7:0];
	 
	 wire [4:0] temp = (A * 8) + 7; 
	 wire t = Din[temp];
	 wire [7:0] tt = temp == 7? Din[7:0] : temp == 15? Din[15:8]: temp == 23? Din[23:16]: Din[31:24];
	 
	 
	 assign Dout = (op == 1)? Din:
								 (op == 2 & A[1] == 0)? {{16{Din[15]}},{Din[15:0]}}:
								  (op == 2 & A[1] == 1)? {{16{Din[31]}},{Din[31:16]}}:
								                                       (op == 3)? {{24{t}},{tt}}:
																													         0;

endmodule
