`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:38:25 11/01/2023 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input clk,
    input reset,
    input WE,
    input [31:0] WD,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
	 input [31:0] WPC,
	 input [31:0] instru,
    output [31:0] D1,
    output [31:0] D2
    );
	 
	 reg [31:0] register [0:31];
	 integer i;
	 wire [31:0] temp;
	 assign D1 = register[A1];
	 assign D2 = register[A2];
	 assign temp = 32'h00004e0c;
	 always @(posedge clk) begin
			if (reset == 1) begin
					for (i = 0; i < 32; i = i + 1) begin
							register[i] <= 32'h0;
					end
			end
			else begin
			//$display("%b",WE);
			            
							
					if (WE == 1 && A3 != 5'b0) begin				
							register[A3] <= WD;
							//$display("%d@%h: $%d <= %h", $time,WPC, A3, WD);
					end
			end
	 end


endmodule
