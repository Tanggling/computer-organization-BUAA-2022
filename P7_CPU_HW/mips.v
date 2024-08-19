`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:04:20 12/03/2023 
// Design Name: 
// Module Name:    mips 
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
module mips(
	input clk,                    // ʱ���ź�
    input reset,                  // ͬ����λ�ź�
    input interrupt,              // �ⲿ�ж��ź�
    output [31:0] macroscopic_pc, // ��� PC

    output [31:0] i_inst_addr,    // IM ��ȡ��ַ��ȡָ PC��
    input  [31:0] i_inst_rdata,   // IM ��ȡ����

    output [31:0] m_data_addr,    // DM ��д��ַ
    input  [31:0] m_data_rdata,   // DM ��ȡ����
    output [31:0] m_data_wdata,   // DM ��д������
    output [3 :0] m_data_byteen,  // DM �ֽ�ʹ���ź�

    output [31:0] m_int_addr,     // �жϷ�������д���ַ
    output [3 :0] m_int_byteen,   // �жϷ������ֽ�ʹ���ź�

    output [31:0] m_inst_addr,    // M �� PC

    output w_grf_we,              // GRF дʹ���ź�
    output [4 :0] w_grf_addr,     // GRF ��д��Ĵ������
    output [31:0] w_grf_wdata,    // GRF ��д������

    output [31:0] w_inst_addr     // W �� PC
    );

	wire [31:0] PrAddr,PrRD,DEV_Addr,Timer0_RD,Timer1_RD;
	wire [31:0] PrWD,DEV_WD;
	wire [3:0] DEV_WE,WE_T0,WE_T1;

	assign m_data_wdata = DEV_WD;
	assign m_data_addr = DEV_Addr;
	assign m_int_addr  = DEV_Addr;
	assign macroscopic_pc = m_inst_addr;//macroscopic

	wire IRQ_0,IRQ_1;
	
	wire [5:0] HWint;

	assign HWint[0] = IRQ_0;
	assign HWint[1] = IRQ_1;
	assign HWint[2] = interrupt;
	assign HWint[5:3] = 0;

	CPU CPU(
		.clk(clk),
		.reset(reset),
		.HWint(HWint),
		.i_inst_addr(i_inst_addr),
		.i_inst_rdata(i_inst_rdata),
		.m_data_rdata(PrRD),
		.m_data_addr(PrAddr),
		.m_data_wdata(PrWD),
		.m_data_byteen(DEV_WE),
		.m_inst_addr(m_inst_addr),
		.w_grf_we(w_grf_we),//dont't change
		.w_grf_addr(w_grf_addr),//dont
		.w_grf_wdata(w_grf_wdata),//dont
		.w_inst_addr(w_inst_addr)//dont
	);
	
	Bridge Bridge(
	    .PrAddr(PrAddr),
        .PrRD(PrRD),
        .PrWD(PrWD),
        .DEV_Addr(DEV_Addr),
        .DM_RD(m_data_rdata),//m_data_rdata
		.Timer0_RD(Timer0_RD),
		.Timer1_RD(Timer1_RD),
		.DEV_WD(DEV_WD),
		.DEV_WE(DEV_WE),
		.WE_DM(m_data_byteen),
		.WE_T0(WE_T0),
		.WE_T1(WE_T1),
		.WE_INT(m_int_byteen)
    );
	 
	TC Timer0(
	    .clk(clk),
        .reset(reset),
        .Addr(DEV_Addr[31:2]),
        .WE(|WE_T0),
        .Din(DEV_WD),
        .Dout(Timer0_RD),
        .IRQ(IRQ_0)
	);
	 
	TC Timer1(
		.clk(clk),
        .reset(reset),
        .Addr(DEV_Addr[31:2]),
        .WE(|WE_T1),
        .Din(DEV_WD),
        .Dout(Timer1_RD),
        .IRQ(IRQ_1)
	);
			 
			
endmodule
