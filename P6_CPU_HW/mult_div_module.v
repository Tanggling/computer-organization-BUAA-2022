`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:37:32 11/18/2023 
// Design Name: 
// Module Name:    mult_div_module 
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
module mult_div_module(
    input clk,
    input reset,
    input [31:0] in1,
    input [31:0] in2,
    input [2:0] op,
    input chose,
	 input changeHI,
	 input changeLO,
    output start,
    output busy,
    output [31:0] HI,
    output [31:0] LO
);
    reg [31:0] in1_tmp;
    reg [31:0] in2_tmp;
    reg [2:0] op_tmp;
    reg [3:0] count;
    reg [31:0] LO_REG;
    reg [31:0] HI_REG;

    assign start = (chose == 1) & (count == 0);//the starting requirement
    assign busy  = (count > 0);
    assign HI = HI_REG;
    assign LO = LO_REG;

    wire [63:0] mult_ans = $signed(in1_tmp) * $signed(in2_tmp);
    wire [63:0] multu_ans = in1_tmp * in2_tmp;
    wire [31:0] div_div = $signed(in1_tmp) / $signed(in2_tmp);
    wire [31:0] div_mod = $signed(in1_tmp) % $signed(in2_tmp);
    wire [31:0] divu_div = in1_tmp / in2_tmp;
    wire [31:0] divu_mod = in1_tmp % in2_tmp;

    always @ (posedge clk) begin
        if (reset == 1) begin//reset_operation(initialize)
		  HI_REG <= 0;
		  LO_REG <= 0;
            in1_tmp <= 0;
            in2_tmp <= 0;
            op_tmp <= 0;
            count <= 0;
        end
        else begin//normal_operation
            if (start == 1) begin//if begin,then add count
                count <= count + 1;
                in1_tmp <= in1;
                in2_tmp <= in2;
                op_tmp <= op;
            end
            else if ( busy == 1 )begin
                if (op_tmp == 0 | op_tmp == 1) begin//mult RTL
                    if (count < 5) begin//if count is less than 5
                        count <= count + 1;
                    end
                    else begin//complete mult operation
                        count <= 0;
                        //do something about mult operation
                        if (op_tmp == 0) begin
                            HI_REG <= mult_ans[63:32];
                            LO_REG <= mult_ans[31:0];
                        end
                        else begin
                            HI_REG <= multu_ans[63:32];
                            LO_REG <= multu_ans[31:0];
                        end
                    end 
                end
                else begin
                    if (count < 10) begin//if count is less than 10
                        count <= count + 1 ;
                    end
                    else begin
                        count <= 0;
                        if (op_tmp == 2) begin
                            HI_REG <= div_mod;
                            LO_REG <= div_div;
                        end  
                        else begin
                            HI_REG <= divu_mod;
                            LO_REG <= divu_div;
                        end        
                    end
                end
            end
            else begin
                if(changeHI == 1) HI_REG <= in1;
                else if(changeLO == 1) LO_REG <= in1;
            end
        end
    end
endmodule
