`timescale 1ns / 1ps
`define IM SR[15:10]
`define EXL SR[1]
`define IE SR[0]
`define IP Cause[15:10]
`define ExcCode Cause[6:2]
`define BD Cause[31]
`define Int 0
`define AdEL 4
`define AdES 5
`define Syscall 8
`define RI 10
`define Ov 12
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:02:50 12/03/2023 
// Design Name: 
// Module Name:    CP0 
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
module CP0(
    input clk,
    input reset,
    input en,
    input [4:0] CP0Add,
    input [31:0] CP0In,
    output [31:0] CP0Out,
    input [31:0] VPC,
    input BDIn,
    input [4:0] ExcCodeIn,
    input [5:0] HWint,
    input EXLClr,
    output [31:0] EPCOut,
    output Req
    );
	
	reg [31:0] SR,Cause,EPC;
	
    assign CP0Out = (CP0Add == 5'd12)? SR:
                    (CP0Add == 5'd13)? Cause:
                                       EPC;
    wire int_req =  |(HWint[5:0] & `IM) & `IE & !`EXL;
    wire exc_req =  (ExcCodeIn == `AdEL || ExcCodeIn == `AdES || ExcCodeIn == `Syscall || ExcCodeIn == `RI || ExcCodeIn == `Ov)  & !`EXL;
    assign Req = int_req | exc_req;
    assign EPCOut = {EPC[31:2],2'B0};
    wire [31:0] tmp_PC = (Req & BDIn)? VPC - 4:
                         (Req)? VPC : EPC;

	always @(posedge clk) begin
        if(reset) begin
            SR <= 0;
            Cause <= 0;
            EPC <= 0;
        end
        else begin
            `IP <= HWint[5:0];
            if (EXLClr) begin
                `EXL <= 0;
            end
            if (Req) begin//if exception happens
                `EXL <= 1;
                EPC <= tmp_PC;//
                `ExcCode <= ExcCodeIn;
                `BD <= BDIn;
            end
            else if (en) begin
                if(CP0Add == 5'd12) begin
                    SR <= CP0In;
                end
                else if(CP0Add == 5'd14) begin
                    EPC <= CP0In;
                end
            end
        end
	end
	 


endmodule
