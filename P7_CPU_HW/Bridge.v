`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:50:38 12/03/2023 
// Design Name: 
// Module Name:    Bridge 
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
module Bridge(
    input [31:0] PrAddr,
    output [31:0] PrRD,
    input [31:0] PrWD,
    output [31:0] DEV_Addr,
    input [31:0] DM_RD,
    input [31:0] Timer0_RD,
    input [31:0] Timer1_RD,
    output [31:0] DEV_WD,
    input [3:0] DEV_WE,
    output [3:0] WE_DM,
    output [3:0] WE_T0,
    output [3:0] WE_T1,
    output [3:0] WE_INT
    );
	 
	assign DEV_Addr = PrAddr;
	assign DEV_WD = PrWD;
	 
	wire HitDM = (DEV_Addr >= 32'h0) & (DEV_Addr <= 32'h2fff);
	wire HitT0 = (DEV_Addr >= 32'h7f00) & ( DEV_Addr < 32'h7f0b);
	wire HitT1 = (DEV_Addr >= 32'h7f10) & (DEV_Addr < 32'h7f1b);
    wire HitINT = (DEV_Addr >= 32'h7f20) & (DEV_Addr < 32'h7f23);
	 
	assign PrRD =   (HitDM)? DM_RD:
	                (HitT0)? Timer0_RD:
				    (HitT1)? Timer1_RD:
				    32'H0;
								 
    assign WE_DM = {4{HitDM}} & DEV_WE;
	assign WE_T0  = {4{HitT0}} & DEV_WE;
	assign WE_T1  = {4{HitT1}} & DEV_WE;
	assign WE_INT = {4{HitINT}} & DEV_WE;

endmodule
