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
    input reset
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
	 
	 		 
	 
	 wire writePC, RegDst, RegWrite, MemToReg, MemWrite, SaveImm, SecRT;
	 wire [1:0] aluOp;
	 wire [1:0] jumpOp;
	 
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
	 wire [4:0]  WriteReg = (writePC == 1) ? 5'd31:
											(RegDst == 1) ? rd:
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
	 assign zero = (RD1_F == RD2_F);
	 wire writePC_E,  RegWrite_E, MemToReg_E, MemWrite_E, SaveImm_E, SecRT_E;
	 wire [1:0] aluOp_E;
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
		assign data2 = (SecRT_E == 1) ? RD2_E_F : extendednum_E;

		 
		 wire writePC_M,  RegWrite_M, MemToReg_M, MemWrite_M, SaveImm_M;
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
		 .PC(PC),
		 .instru(instru)
	 ); 	 
 
	 NPC NPC(
		 .jumpOp(jumpOp),
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
		 .writePC(writePC),
		 .RegDst(RegDst),
		 .ExtOp(ExtOp),
		 .RegWrite(RegWrite),
		 .MemToReg(MemToReg),
		 .MemWrite(MemWrite),
		 .aluOp(aluOp),
		 .jumpOp(jumpOp),
		 .SaveImm(SaveImm),
		 .SecRT(SecRT),
		 .rsT_use(rsT_use),
	    .rtT_use(rtT_use),
	    .T_new(T_new)
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
			 .SecRT_D(SecRT),
			 .MemWrite_D(MemWrite),
			 .MemToReg_D(MemToReg),
			 .RegWrite_D(RegWrite),
			 .SaveImm_D(SaveImm),
			 .WritePC_D(writePC),
			 .PC_D(PC_D),
			 .WR_E(WriteReg_E),
			 .RD1_E(RD1_E),
			 .RD2_E(RD2_E),
			 .EXTNUM_E(extendednum_E),
			 .PCplus4_E(PCplus4_E),
			 .IMMNUM_E(immediate32bits_E),
			 .ALUOP_E(aluOp_E),
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
		
		 
	  
	 
	 DM DM(
		 .clk(clk),
		 .reset(reset),
		 .store(MemWrite_M),
		 .load(MemToReg_M),
		 .pc(PC_M),
		 .DMout(DMout),
		 .data(RD2_M_F),
		 .addr(ANS_M)
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
				   .halt(halt),
					.MRS_D(MRS_D),
					.MRT_D(MRT_D),
					.MRS_E(MRS_E),
					.MRT_E(MRT_E),
				   .MRT_M(MRT_M)
		);

endmodule