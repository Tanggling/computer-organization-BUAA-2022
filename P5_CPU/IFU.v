`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:04:22 11/01/2023 
// Design Name: 
// Module Name:    IFU 
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
module IFU(
    input [31:0] nowPC,
    input clk,
    input reset,
	 input en,
    output [31:0] PC,
    output [31:0] instru
    );
	wire [11:0] addr;
	reg [31:0] im_reg [0:4095];
	reg [31:0] PC_reg;
	initial begin
		  $readmemh("code.txt", im_reg);
	end
	
	wire [31:0]  temp = PC_reg - 32'h00003000;
	assign addr = temp [13:2] ;
	assign instru = im_reg[addr];
	assign PC = PC_reg;
	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
	always @(posedge clk) begin
	      //$display("PC = :%h", PC);
			if(en == 0) begin
					PC_reg <= PC_reg;
			end
			else if (reset == 1) begin
					PC_reg <= 32'h00003000;
			end
			else begin
					PC_reg <= nowPC ;
			end
	end
	
endmodule
