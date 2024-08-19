`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:36:19 11/09/2023 
// Design Name: 
// Module Name:    fac_ctrl 
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
module fac_ctrl(
    input SecRT_D,
    input SecRT_E,
    input RegWrite_E,
    input RegWrite_M,
    input RegWrite_W,
    input [4:0] WR_E,
    input [4:0] WR_M,
    input [4:0] WR_W,
    input [4:0] rs_D,
    input [4:0] rt_D,
    input [4:0] rs_E,
    input [4:0] rt_E,
    input [4:0] rt_M,
    input [1:0] T_new_E,
    input [1:0] T_new_M,
    input [1:0] rsT_use_D,
    input [1:0] rtT_use_D,
	 input mult_relative,//new
	 input start,//new
	 input busy,//new
     input w_cp0_epc,
     input w_cp0_epc_M,
     input jepc,
    output halt,
    output [1:0] MRS_D,
    output [1:0] MRT_D,
    output [1:0] MRS_E,
    output [1:0] MRT_E,
    output MRT_M
    );
	 assign halt = ((RegWrite_E) & (WR_E == rs_D) & (WR_E != 5'b0) & (T_new_E > rsT_use_D))
	                   |((RegWrite_E) & (WR_E == rt_D) & (WR_E != 5'b0) & (T_new_E > rtT_use_D))
							 |((RegWrite_M) & (WR_M == rs_D) & (WR_M != 5'b0) & (T_new_M > rsT_use_D))
							 |((RegWrite_M) & (WR_M == rt_D) & (WR_M != 5'b0) & (T_new_M > rtT_use_D))
							 |((start | busy) & mult_relative)
                             |(jepc & (w_cp0_epc | w_cp0_epc_M));
	 //check_2nd
    assign MRS_D =  ((RegWrite_E) & (T_new_E == 0) & (WR_E == rs_D) & (WR_E == 31)) ? 3://pc+4
										((RegWrite_M) & (T_new_M == 0) & (WR_M == rs_D) & (WR_M != 0)) ? 2:
																		 ((RegWrite_W) & (WR_W == rs_D) & (WR_W != 0))?    1:
                                                                                                                   0;
    assign MRT_D =  ((RegWrite_E) & (T_new_E == 0) & (WR_E == rt_D) & (WR_E == 31)) ? 3://pc+4
										((RegWrite_M) & (T_new_M == 0) & (WR_M == rt_D) & (WR_M != 0)) ? 2:
																		 ((RegWrite_W) & (WR_W == rt_D) & (WR_W != 0))?    1:
                                                                                                                   0;
    assign MRS_E = ((RegWrite_M) & (T_new_M == 0) & (WR_M == rs_E) & (WR_M != 0)) ? 2:
																		 ((RegWrite_W) & (WR_W == rs_E) & (WR_W != 0))?    1:
                                                                                                                   0;
    assign MRT_E = ((RegWrite_M) & (T_new_M == 0) & (WR_M == rt_E) & (WR_M != 0)) ? 2:
																		 ((RegWrite_W) & (WR_W == rt_E) & (WR_W != 0))?    1:
                                                                                                                   0;	
    assign MRT_M = (RegWrite_W) & (WR_W == rt_M) & (WR_W != 0);																																						 

endmodule
