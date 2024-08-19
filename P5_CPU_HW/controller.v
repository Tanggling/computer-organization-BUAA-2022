`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:00:24 11/02/2023 
// Design Name: 
// Module Name:    controller 
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
module controller(
    input [5:0] func,
    input [5:0] op,
    output writePC,
    output RegDst,
    output ExtOp,
    output RegWrite,
    output MemToReg,
    output MemWrite,
    output [1:0] aluOp,
    output [1:0] jumpOp,
    output SaveImm,
    output SecRT,
	 output [1:0] rsT_use,
	 output [1:0] rtT_use,
	 output [1:0] T_new
    );
	 wire rtype, ori, lw, sw, beq, lui, jal, add, sub, jr;
	 assign rtype = (op == 6'b000000);
	 assign ori     = (op == 6'b001101);
	 assign lw      = (op == 6'b100011);
	 assign sw      = (op == 6'b101011);
	 assign beq     = (op == 6'b000100);
	 assign lui      = (op == 6'b001111);
	 assign jal      = (op == 6'b000011);
	 assign add     = rtype & (func == 6'h20);
	 assign sub     = rtype & (func == 6'h22);
	 assign jr       =  rtype & (func == 6'h08);
	 
	 assign writePC = jal ;
	 assign RegDst = add | sub;
	 assign ExtOp = lw | sw | beq ;
	 assign RegWrite = add | sub | ori | lw | lui | jal ;
	 assign MemToReg = lw;
	 assign MemWrite = sw;
	 assign aluOp[0] = beq | sub;
	 assign aluOp[1] = ori;
	 assign jumpOp[0] = beq | jr;
	 assign jumpOp[1] = jr | jal;
	 assign SaveImm = lui;
	 assign SecRT = add | sub | beq ;
	 assign rsT_use = (add == 1 | sub == 1| ori == 1 | lw == 1| sw == 1) ? 2'b01 : 
	                                                                   (beq == 1 | jr  == 1 )? 2'b00 :
																																	  2'b11 ;
	 //check_1st
	 assign rtT_use = (add | sub | ori | lw) ? 2'b01 :
										               ( sw  ) ? 2'b10 :
															 ( beq ) ? 2'b00:
															             2'b11;
	 //check_1st																		 
	 assign T_new = (add | sub | ori | lui ) ? 2'b10:
									                    ( lw ) ? 2'b11:
															  ( jal ) ? 2'b01:
																		    2'b00;
	 //check_1st																	  
endmodule 
