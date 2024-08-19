`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:07:34 11/01/2023 
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
    input clk,
    input reset,
	 output [31:0] i_inst_addr,
	 input [31:0] i_inst_rdata,
	 input [31:0] m_data_rdata,
	 output [31:0]  m_data_addr,
    output [31:0] m_data_wdata,
	 output [3:0] m_data_byteen,
	 output [31:0] m_inst_addr,
	 output w_grf_we,
	 output [4:0] w_grf_addr,
	 output [31:0] w_grf_wdata,
	 output [31:0] w_inst_addr
	 );
	 
	 /* IFU:
			 in: clk , reset , nowPC
			 out: PC , instru
	 */
	  wire [31:0] instru;
	  wire [31:0] nowPC;
	  wire [31:0] PC;
	  wire halt;
	  assign en = ~halt;
	  
	  wire [25:0] jumpnext = instru_D[25:0];
	  wire [31:0] PCplus4; 
	 
	 wire [31:0] instru_D;
	 wire [31:0] PCplus4_D;
	 
	 //IFU IM outside
	 assign i_inst_addr = PC;
	 assign instru = i_inst_rdata;		 
	 
	wire branch;

	 wire writePC, RegDst, RegWrite, MemToReg, MemWrite, SaveImm, SecRT,mult_relative,writeHI,writeLO,changeHI,changeLO;
	 wire [2:0] store_type,load_type;//store & load signal
	 wire [1:0] ad = m_data_addr [1:0];
	 
	 assign m_data_byteen = (store_type_M == 1 ) ? 4'b1111:
													(store_type_M == 2 & ad[1] == 0)? 4'b0011:
													(store_type_M == 2 & ad[1] == 1) ? 4'b1100:
													(store_type_M == 3)? (1 << ad):
													0;
	  
	 assign m_data_addr = ANS_M;
	 wire [7:0] temp = RD2_M_F[7:0];
	 wire [4:0] shift = 8 * ad;
	 assign m_data_wdata = (store_type_M == 1) ? RD2_M_F:
													(store_type_M == 2& ad[1] == 0) ? {{16'b0},{RD2_M_F[15:0]}}:
													(store_type_M == 2 & ad[1] == 1) ? {{RD2_M_F[15:0]},{16'b0}}:
													(store_type_M == 3)? temp << shift:0;
	 assign m_inst_addr = PC_M;
	 
	 /*reg [31:0] temp1,temp2;
	 always @(posedge clk) begin
		if(reset == 1) begin
			temp1 <= 0;
			temp2 <= 0;
		end
		else begin
			temp1 <= extendednum_E;
			temp2 <= RD1_E_F;
		end
	 end*/
	 //assign DMout = m_data_rdata;
	  
	 
	 wire [2:0] aluOp;
	 wire aluchose;
	 wire [2:0] jumpOp;
	 
	 wire [1:0] rsT_use;
	 wire [1:0] rtT_use;
	 wire [1:0] T_new;
	 
	 wire [5:0] op = instru_D[31:26];
	 wire [5:0] func = instru_D[5:0];
	 wire [4:0] rs = instru_D[25:21];
	 wire [4:0] rt = instru_D[20:16];
	 wire [4:0] rd = instru_D[15:11];
	 wire [15:0] immediate = instru_D[15:0];
	 wire [31:0] extendednum;
	 wire [4:0]  WriteReg = (RegDst == 1) ? rd:
							(writePC == 1) ? 5'd31:
							rt;
    	 
	 wire [31:0] immediate32bits = {{immediate},{16{1'b0}}};
	 
	  
	 wire [31:0] RD1;
	 wire [31:0] RD2;
	 
	 wire [31:0] RD1_F =   (MRS_D == 3) ? PCplus4_E:
												(MRS_D == 2) ? WriteData:
	                            (MRS_D == 1) ?   WriteData_W:
																		RD1;
	 wire [31:0] RD2_F = (MRT_D == 3) ? PCplus4_E:
											(MRT_D == 2) ? WriteData:
								  (MRT_D == 1) ? WriteData_W:
								                           RD2;
	 wire [31:0] sum = RD1_F + RD2_F;//branch detection

	 assign zero = (RD1_F == RD2_F);
	 assign w_grf_we = RegWrite_W;
	 assign w_grf_addr = WriteReg_W;
	 assign w_grf_wdata = WriteData_W;
	 
	 assign w_inst_addr = PC_W;
	 
	 
	 wire writePC_E,  RegWrite_E, MemToReg_E, MemWrite_E, SaveImm_E, SecRT_E,writeHI_E,writeLO_E,changeHI_E,changeLO_E;
	 wire [2:0] store_type_E,load_type_E;
	 wire [2:0] aluOp_E;
	 wire aluchose_E;//new
	 wire [31:0] RD1_E;
	 wire [31:0] RD2_E;
	 wire [31:0] immediate32bits_E;
	 wire [31:0] PCplus4_E;
	 wire [31:0] extendednum_E;
	 wire [4:0] WriteReg_E;
	 
	 
		 
	 wire [4:0] rs_E, rt_E;
	 wire [1:0] T_new_E;
	 
	 wire [31:0] RD1_E_F = (MRS_E == 2) ? WriteData:
		                         (MRS_E == 1)  ? WriteData_W:
										 RD1_E;
		wire [31:0] RD2_E_F =  (MRT_E == 2) ? WriteData:
		                         (MRT_E == 1)  ? WriteData_W:
										 RD2_E;

		
		wire [31:0] data2;
	   wire [31:0] ans;
		wire start,busy;
		wire [31:0] HI,LO;
		assign data2 = (SecRT_E == 1) ? RD2_E_F : extendednum_E;

		 wire [31:0] HI_M,LO_M;
		 wire writePC_M,  RegWrite_M, MemToReg_M, MemWrite_M, SaveImm_M,writeHI_M,writeLO_M;
		 wire [2:0] store_type_M, load_type_M;
		 wire [31:0] RD2_M;
		 wire [31:0] immediate32bits_M;
		 wire [31:0] PCplus4_M;
		 wire [4:0] WriteReg_M;
		 wire [31:0] ANS_M;
		 
		 wire [1:0] T_new_M;
		 wire [4:0] rs_M,rt_M;
		
		wire [31:0] DMout;
	  
	   wire [31:0] RD2_M_F = MRT_M == 1 ? WriteData_W : RD2_M; 
		
		wire [31:0] WriteData;
	   assign WriteData = (writePC_M == 1) ? PCplus4_M:
											(SaveImm_M == 1)? immediate32bits_M:
											(MemToReg_M == 1)? DMout:
											(writeHI_M == 1)? HI_M:
											(writeLO_M == 1) ? LO_M:
																				ANS_M;
	 
	   
		wire [31:0] WriteData_W;
		wire [4:0] WriteReg_W;
		wire RegWrite_W;
		
		
		//wire halt;
		wire [1:0] MRS_D,MRT_D,MRS_E,MRT_E;
		wire MRT_M;
		
		wire [31:0] PC_D,PC_E,PC_M,PC_W;
		
		//wire jump_signal = (jumpOp > 0) & (instru != 0);
		
		 
	  IFU IFU(
		 .nowPC(nowPC),
		 .clk(clk),
		 .en(en),
		 .reset(reset),
		 .PC(PC)
	 ); 	 
 
	 NPC NPC(
		 .jumpOp(jumpOp),
		 .sum(sum),
		 .PC_D(PC_D),
		 .PC(PC),
		 .add(extendednum),
		 .zero(zero),//modified to pre_operation 'beq'
		 .jumpnext(jumpnext),
		 .jr(RD1_F),
		 .PCplus4(PCplus4),
		 .nextPC(nowPC)
    );

	 FD_Reg FD_Reg(
		 .clk(clk),
       .reset(reset),
       .en(en),
       .instru(instru),
		 .PC(PC),
       //.PCplus4(PCplus4),
       //.PCplus4_D(PCplus4_D),
       .instru_D(instru_D),
		 .PC_D(PC_D)
		 );
		 
	 
	 controller controller(
		 .func(func),
		 .op(op),
		 .D1(RD1_F),
		 .D2(RD2_F),
		 .writePC(writePC),
		 .RegDst(RegDst),
		 .ExtOp(ExtOp),
		 .RegWrite(RegWrite),
		 .MemToReg(MemToReg),
		 .MemWrite(MemWrite),
		 .store_type(store_type),
		 .load_type(load_type),
		 .aluOp(aluOp),
		 .aluchose(aluchose),
		 .writeHI(writeHI),
		 .writeLO(writeLO),
		 .changeHI(changeHI),
		 .changeLO(changeLO),
		 .mult_relative(mult_relative),
		 .jumpOp(jumpOp),
		 .SaveImm(SaveImm),
		 .SecRT(SecRT),
		 .rsT_use(rsT_use),
	    .rtT_use(rtT_use),
	    .T_new(T_new),
		.branch(branch)
    );

	 
	 ETX ETX(
		 .in(immediate),
		 .ExtOp(ExtOp),
		 .extendednum(extendednum)
    );
	
	 
	 GRF GRF(
		 .clk(clk),
		 .reset(reset),
		 .WE(RegWrite_W),
		 .WD(WriteData_W),
		 .A1(rs),
		 .A2(rt),
		 .A3(WriteReg_W),
		 .instru(instru),
		 .WPC(PC_W),
		 .D1(RD1),
		 .D2(RD2)
    );
	 
	 
	 
	 
	 DE_Reg DE(
			.clk(clk),
			 .reset(reset|halt),
			 .WR_D(WriteReg),
			 .RD1_D(RD1_F),
			 .RD2_D(RD2_F),
			 .EXTNUM_D(extendednum),
			 .PCplus4_D(PCplus4),
			 .IMMNUM_D(immediate32bits),
			 .ALUOP_D(aluOp),
			 .aluchose_D(aluchose),
			 .SecRT_D(SecRT),
			 .MemWrite_D(MemWrite),
			 .MemToReg_D(MemToReg),
			 .RegWrite_D(RegWrite),
			 .SaveImm_D(SaveImm),
			 .WritePC_D(writePC),
			 .PC_D(PC_D),
			 .writeHI_D(writeHI),
			 .writeLO_D(writeLO),
			 .store_type_D(store_type),
			 .load_type_D(load_type),
			 .store_type_E(store_type_E),
			 .load_type_E(load_type_E),
			 .writeHI_E(writeHI_E),
			 .writeLO_E(writeLO_E),
			 .changeHI_D(changeHI),
			 .changeLO_D(changeLO),
			 .changeHI_E(changeHI_E),
			 .changeLO_E(changeLO_E),
			 .WR_E(WriteReg_E),
			 .RD1_E(RD1_E),
			 .RD2_E(RD2_E),
			 .EXTNUM_E(extendednum_E),
			 .PCplus4_E(PCplus4_E),
			 .IMMNUM_E(immediate32bits_E),
			 .ALUOP_E(aluOp_E),
			 .aluchose_E(aluchose_E),
			 .SecRT_E(SecRT_E),
			 .MemWrite_E(MemWrite_E),
			 .MemToReg_E(MemToReg_E),
			 .RegWrite_E(RegWrite_E),
			 .SaveImm_E(SaveImm_E),
			 .WritePC_E(writePC_E),
			 .PC_E(PC_E)
	);
		
	dt dt1(
			.clk(clk),
			.reset(reset),
			.T_new(T_new),
			.rs(rs),
			.rt(rt),
			.T_new_next(T_new_E),
			.rs_next(rs_E),
			.rt_next(rt_E)
		);
		
	
		 ALU ALU(
			 .in1(RD1_E_F),
			 .in2(data2),
			 .op(aluOp_E),
			 .ans(ans)
		 );
		 
		 mult_div_module mult_div_module(
			 .clk(clk),
			 .reset(reset),
			 .in1(RD1_E_F),
			 .in2(RD2_E_F),
			 .op(aluOp_E),
			 .chose(aluchose_E),
			 .start(start),
			 .busy(busy),
			 .changeHI(changeHI_E),
			 .changeLO(changeLO_E),
			 .HI(HI),
			 .LO(LO)
		 );
	
		EM_Reg EM_Reg(
				.clk(clk),
			  .reset(reset),
			  .RD2_E(RD2_E_F),
			  .ANS_E(ans),
			  .MemWrite_E(MemWrite_E),
			  .MemToReg_E(MemToReg_E),
			  .IMMNUM_E(immediate32bits_E),
			  .WR_E(WriteReg_E),
			  .PCplus4_E(PCplus4_E),
			  .RegWrite_E(RegWrite_E),
			  .SaveImm_E(SaveImm_E),
			  .WritePC_E(writePC_E),
			  .PC_E(PC_E),
			  .writeHI_E(writeHI_E),
			  .writeLO_E(writeLO_E),
			 .HI_E(HI),
			 .LO_E(LO),
			 .store_type_E(store_type_E),
			 .load_type_E(load_type_E),
			 .store_type_M(store_type_M),
			 .load_type_M(load_type_M),
			 .HI_M(HI_M),
			 .LO_M(LO_M),
			 .writeHI_M(writeHI_M),
			 .writeLO_M(writeLO_M),
			  .RD2_M(RD2_M),
			  .ANS_M(ANS_M),
			  .MemWrite_M(MemWrite_M),
			  .MemToReg_M(MemToReg_M),
			  .IMMNUM_M(immediate32bits_M),
			  .WR_M(WriteReg_M),
			  .PCplus4_M(PCplus4_M),
			  .RegWrite_M(RegWrite_M),
			  .SaveImm_M(SaveImm_M),
			  .WritePC_M(writePC_M),
			  .PC_M(PC_M)
			);
			
			
			
			dt dt2(
				.clk(clk),
				.reset(reset),
				.T_new(T_new_E),
				.rs(rs_E),
				.rt(rt_E),
				.T_new_next(T_new_M),
				.rs_next(rs_M),
				.rt_next(rt_M)
			);
		
		 
	  
	 
	 /*DM DM(
		 .clk(clk),
		 .reset(reset),
		 .store(MemWrite_M),
		 .load(MemToReg_M),
		 .pc(PC_M),
		 .DMout(DMout),
		 .data(RD2_M_F),
		 .addr(ANS_M)
    );*/
	 
	 ext_DM ext_DM(
		 .A(ad),
		 .Din(m_data_rdata),
		 .Dout(DMout),
		 .op(load_type_M)
	 );
	
		
		MW_Reg MW_Reg(
			.clk(clk),
         .reset(reset),
         .WD_M(WriteData),
         .WR_M(WriteReg_M),
         .RegWrite_M(RegWrite_M),
			.PC_M(PC_M),
         .WD_W(WriteData_W),
         .WR_W(WriteReg_W),
         .RegWrtie_W(RegWrite_W),
			.PC_W(PC_W)
		);
		

		fac_ctrl fac_ctrl(
			     .SecRT_D(SecRT),
				  .SecRT_E(SecRT_E),
				  .RegWrite_E(RegWrite_E),
				  .RegWrite_M(RegWrite_M),
				  .RegWrite_W(RegWrite_W),
					.WR_E(WriteReg_E),
					.WR_M(WriteReg_M),
					.WR_W(WriteReg_W),
					.rs_D(rs),
					.rt_D(rt),
					.rs_E(rs_E),
					.rt_E(rt_E),
					.rt_M(rt_M),
					.T_new_E(T_new_E),
					.T_new_M(T_new_M),
					.rsT_use_D(rsT_use),
					.rtT_use_D(rtT_use),
					.mult_relative(mult_relative),
					.start(start),
					.busy(busy),
				   .halt(halt),
					.MRS_D(MRS_D),
					.MRT_D(MRT_D),
					.MRS_E(MRS_E),
					.MRT_E(MRT_E),
				   .MRT_M(MRT_M)
		);

endmodule