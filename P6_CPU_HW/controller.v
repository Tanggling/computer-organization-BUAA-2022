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
	input [31:0] D1,//new input with RD1_F
	input [31:0] D2,//new input with RD2_F
    output writePC,
    output RegDst,
    output ExtOp,
    output RegWrite,
    output MemToReg,
    output MemWrite,
	output [2:0] store_type,
	output [2:0] load_type,
    output [2:0] aluOp,
	output aluchose,
	output mult_relative,
    output [2:0] jumpOp,
    output SaveImm,
    output SecRT,
	output writeHI,//new
	output writeLO,//new
	output changeHI,
	output changeLO,
	output [1:0] rsT_use,
	output [1:0] rtT_use,
	output [1:0] T_new,
	output branch//new output means new branch instruction
    );

	wire rtype = (op == 6'b000000);
	wire ori     = (op == 6'b001101);
	wire lw      = (op == 6'b100011);
	wire sw      = (op == 6'b101011);
	wire beq     = (op == 6'b000100);
	wire lui      = (op == 6'b001111);
	wire jal      = (op == 6'b000011);
	wire addi    = (op == 6'b001000);
	wire andi    = (op == 6'b001100);
	wire lb       = (op == 6'b100000);
	wire lh       = (op == 6'b100001);
	wire sb       = (op == 6'b101000);
    wire sh       = (op == 6'b101001);
	wire mult    = rtype & (func == 6'b011000);
	wire multu  = rtype & (func == 6'b011001);
	wire div      = rtype & (func == 6'b011010);
	wire divu    = rtype & (func == 6'b011011);
	wire mfhi    = rtype & (func == 6'b010000);
	wire mflo    = rtype & (func == 6'b010010);
	wire mthi    = rtype & (func == 6'b010001);
	wire mtlo    = rtype & (func == 6'b010011);
	wire bne     = op == 6'b000101;
	wire add     = rtype & (func == 6'h20);
	wire sub     = rtype & (func == 6'h22);
	wire jr       =  rtype & (func == 6'h08);
	wire and_   = rtype & (func == 6'b100100);
	wire or_     = rtype & (func == 6'b100101);
	wire slt      = rtype & (func == 6'b101010);
	wire sltu     = rtype & (func == 6'b101011);
	 
	assign branch = rtype & (func == 6'b001111);//add branch rtl
	wire condition = (D1 + D2 < 32'h00006000);
	wire by = branch & condition;//'by' means that the instruction is branch and the fact corresponds with the condition
	
	assign writeHI = mfhi;
	assign writeLO = mflo;
	assign changeHI = mthi;
	assign changeLO = mtlo;
	assign writePC = jal | by;
  	assign RegDst = add | sub | and_ | or_ | slt | sltu | mfhi | mflo | by;
	assign ExtOp = lw | sw | beq | addi | bne | lh | lb | sh | sb;
	assign RegWrite = add | sub | ori | lw | lui | jal | and_ | or_ | slt | sltu 
                    | addi | andi | lb | lh | mfhi | mflo | by;
	assign MemToReg = lw | lb | lh;
	assign MemWrite = sw | sb | sh;
	assign store_type =  (sw)?  1:
						(sh)?  2:
						(sb)? 3: 0;
	assign load_type = (lw)? 1:
					    (lh)?  2:
						(lb)? 3:0;
	assign aluOp[0] = sub | and_ | andi | sltu | multu | divu;//add bit
	assign aluOp[1] = ori | and_ | andi | or_  | div | divu;
	assign aluOp[2] = slt | sltu ;
	assign aluchose = mult | multu | div | divu;
	assign mult_relative = mult | multu | div | divu | mfhi | mflo | mthi | mtlo ;
	assign jumpOp[0] = beq | jr | by;//change way
	assign jumpOp[1] = jr | jal;
	assign jumpOp[2] = bne | by;
	assign SaveImm = lui;
	assign SecRT = add | sub | mfhi | mflo | and_ | or_ | slt | sltu ;
	assign rsT_use = (add | sub | ori | lw | sw| lh | lb | sh | sb | and_ |or_ | slt | sltu |addi | andi| mult | multu | div | divu | mthi | mtlo) ? 2'b01 : 
	                                                                   (beq | jr | bne | branch)? 2'b00 :
																																	  2'b11 ;
	//check_1st
	assign rtT_use = (add | sub | and_ | or_ | slt | sltu | mult | multu | div | divu ) ? 2'b01 :
										               ( sw | sh | sb ) ? 2'b10 :
															 ( beq | bne | branch) ? 2'b00:
															             2'b11;
	//check_1st																		 
	assign T_new = (add | sub | ori | lui | and_ | or_ | slt | sltu | addi | andi | mfhi | mflo) ? 2'b10:
									                    ( lw | lh | lb) ? 2'b11:
															  ( jal | by) ? 2'b01:
																		    2'b00;
	//check_1st																	  
endmodule 
