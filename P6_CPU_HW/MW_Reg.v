`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:59:47 11/09/2023 
// Design Name: 
// Module Name:    MW_Reg 
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
module MW_Reg(
    input clk,
    input reset,
    input [31:0] WD_M,
    input [4:0] WR_M,
    input RegWrite_M,
	 input [31:0] PC_M,
    output reg [31:0] WD_W,
    output reg [4:0] WR_W,
    output reg RegWrtie_W,
	 output reg [31:0] PC_W
    );
	always @(posedge clk) begin
        if (reset == 1) begin
            WD_W <= 0;
            WR_W <= 0;
            RegWrtie_W <= 0;
				PC_W <= 0;
        end
        else begin
            WD_W <= WD_M;
            WR_W <= WR_M;
            RegWrtie_W <= RegWrite_M;
				PC_W <= PC_M;
        end
    end

endmodule
