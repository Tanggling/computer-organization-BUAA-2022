`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:50:32 11/01/2023 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input clk,
    input reset,
    input store,
    input load,
    input [31:0] data,
    input [31:0] addr,
	 input [31:0] pc,
    output [31:0] DMout
    );
	 wire [11:0] ad;
	 assign ad = addr[13:2];
	 integer i;
	 reg [31:0] dm_reg [0:3071];
	 assign DMout =  dm_reg[ad];
	 
	 always @(posedge clk) begin
			if (reset == 1) begin
					for (i = 0; i < 3072; i = i + 1) begin
							dm_reg[i] <= 32'h0;
					end
			end
			else begin
					if (store == 1) begin
							dm_reg[ad] <= data;
							$display("%d@%h: *%h <= %h",$time, pc, addr, data);
					end
			end
	 end


endmodule
