`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:07:23 11/09/2023 
// Design Name: 
// Module Name:    dt 
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
module dt(
    input clk,
    input reset,
    input [1:0] T_new,
    input [4:0] rs,
    input [4:0] rt,
	input [4:0] rd,
	output reg [4:0] rd_next,
    output reg [1:0] T_new_next,
    output reg [4:0] rs_next,
    output reg [4:0] rt_next
    );
	 always @(posedge clk) begin
			if (reset == 1) begin 
					rd_next <= 0;
				    T_new_next <= 0;
					 rs_next <= 0;
					 rt_next <= 0;
			end
			else begin
					rd_next <= rd;
					 T_new_next <= (T_new == 2'b0) ? 0 : T_new - 1;
					 rs_next = rs;
					 rt_next = rt;
			end
	 end


endmodule
