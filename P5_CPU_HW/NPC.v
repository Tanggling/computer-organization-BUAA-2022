`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:31:55 11/01/2023 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [1:0] jumpOp,
    input [31:0] PC,
	 input [31:0] PC_D,
    input [31:0] add,
    input zero,
    input [25:0] jumpnext,
    input [31:0] jr,
    output [31:0] PCplus4,
    output [31:0] nextPC
    );
	 wire choose;
	 wire [31:0] choose_tmp;
	 wire [31:0] choose1;
	 wire [31:0] choose2;
	 wire [31:0] choose3;
	 assign PCplus4 = PC_D + 32'h8;
	 assign choose = (zero) & (jumpOp == 2'b01);
    assign choose_tmp = (choose == 1) ? (add * 4) + 4 : 8;
																							  
	 wire [31:0] choose0 = PC +  32'h00000004;																						  
    assign choose1 = PC_D  + choose_tmp;
	 assign choose2 = {{PC[31:28]},{jumpnext},{2{1'b0}}};
	 assign choose3 = jr;
	 
	 assign nextPC = (jumpOp == 2'b10)? choose2:
									(jumpOp == 2'b11)? choose3:
									(jumpOp == 2'b01)? choose1:
										                            choose0;
	 //always #10 $display("jumpOp = %d nextPC = %h  ",jumpOp, nextPC);
endmodule
