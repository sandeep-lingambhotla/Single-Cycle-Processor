`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sai Sandeep L V
// 
// Create Date:    17:51:22 01/07/2017 
// Design Name: 
// Module Name:    SingleCycleProcessor 
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
module SingleCycleProc(Clk, Reset_L, startPC, dMemOut);

parameter PC_W = 32;
parameter DATA_MEM_DATA_W = 32;

input Clk;
input Reset_L;
input [PC_W - 1:0]startPC;

output [DATA_MEM_DATA_W - 1:0]dMemOut;

parameter PC_REG_W = 32;
parameter INST_WORD_W = 32;
parameter ALU_OP_W = 4;
parameter REG_FILE_ADDR_W = 5;
parameter REG_FILE_DATA_W = 32;
parameter ALU_CTRL_W = 4;
parameter ALU_DATA_W = 32;
parameter DATA_MEM_ADDR_W = 6;

reg [PC_REG_W - 1 : 0]		PC;

wire [PC_REG_W - 1 : 0]		intPC;
wire [PC_REG_W - 1 : 0]		intPCPlus4;
wire [PC_REG_W - 1 : 0]		intBranchAddr;
wire [PC_REG_W - 1 : 0]		intJumpAddr;
wire 						intBEQFlag;

wire [INST_WORD_W - 1 : 0]		InstructionWord;

wire	RegDst;
wire	ALUSrc1;
wire	ALUSrc2;
wire	RegSrc;
wire	RegWrite;
wire	MemRead;
wire	MemWrite;
wire	BranchCtrl;
wire	Jump;
wire	SignExtend;
wire [ALU_OP_W - 1 : 0]	ALUOp;

wire [REG_FILE_ADDR_W - 1 : 0]	intRW;
wire [REG_FILE_DATA_W - 1 : 0]	intRegFileBusA;
wire [REG_FILE_DATA_W - 1 : 0]	intRegFileBusB;
wire [REG_FILE_DATA_W - 1 : 0]	intRegFileBusW;

wire [ALU_CTRL_W - 1 : 0]	ALUCtrl;

wire [ALU_DATA_W - 1 : 0]	intSignZeroExtImm;

wire [ALU_DATA_W - 1 : 0]	intALUBusA;
wire [ALU_DATA_W - 1 : 0]	intALUBusB;
wire [ALU_DATA_W - 1 : 0]	intALUBusW;
wire 						Zero;

wire [DATA_MEM_DATA_W - 1 : 0]	intDataMemOut;
wire [PC_W - 1 : 0] intPCBranch;

always @ (negedge Clk or negedge Reset_L)
begin : PC_block
	
	if(Reset_L == 1'b0)
			PC <= startPC;
	else
			PC <= intPC;
end	// PC_block


// Program Counter logic

assign intPCPlus4 = PC + 4;
assign intBEQFlag = BranchCtrl & Zero;
assign intBranchAddr = intPCPlus4 + {intSignZeroExtImm[29:0],2'b00};
assign intJumpAddr = {intPCPlus4[31:28],InstructionWord[25:0],2'b00};
assign intPCBranch = (intBEQFlag) ? intBranchAddr : intPCPlus4;
assign intPC = (Jump == 1) ?  intJumpAddr: intPCBranch;

// Program Counter - Address for instruction memory


InstructionMemory INM(
	.Address	(PC	),
	.Data		(InstructionWord)
);

SingleCycleControl SCC(
	.Opcode		(InstructionWord[31:26]),
	.FuncCode	(InstructionWord[5:0]),
	.RegDst		(RegDst),
	.ALUSrc1	(ALUSrc1),
	.ALUSrc2	(ALUSrc2),
	.MemToReg	(RegSrc),
	.RegWrite	(RegWrite),
	.MemRead	(MemRead),
	.MemWrite	(MemWrite),
	.Branch		(BranchCtrl),
	.Jump		(Jump),
	.SignExtend	(SignExtend),
	.ALUOp		(ALUOp)
);

assign intRW = (RegDst == 1'b1) ? InstructionWord[15:11]:
   								  InstructionWord[20:16];

										   
RegisterFile RF(
	.Clk	(Clk),
	.RA		(InstructionWord[25:21]),
	.RB		(InstructionWord[20:16]),
    .RW		(intRW),
	.BusW	(intRegFileBusW),
	.RegWr	(RegWrite),
	.BusA	(intRegFileBusA),
	.BusB	(intRegFileBusB)
);

ALUControl ALUC(
	.ALUop		(ALUOp),
	.FuncCode	(InstructionWord[5:0]),
	.ALUCtrl	(ALUCtrl)
);

assign intSignZeroExtImm = (SignExtend == 1'b1) ?
					{{16{InstructionWord[15]}},InstructionWord[15:0]} :
					{16'b0,InstructionWord[15:0]};
					
assign intALUBusA = (ALUSrc1 == 1'b0) ? 
							intRegFileBusA :
							{27'b0,InstructionWord[10:6]};
									
assign intALUBusB = (ALUSrc2 == 1'b0) ?
							intRegFileBusB :
							intSignZeroExtImm ;
							
ALU alu(
	.BusA		(intALUBusA),
	.BusB		(intALUBusB),
	.ALUCtrl	(ALUCtrl),
	.BusW		(intALUBusW),
	.Zero		(Zero)
);


DataMemory	DM(
	.Clock		(Clk),
	.Address	(intALUBusW[DATA_MEM_ADDR_W+2-1:2]),
	.WriteData	(intRegFileBusB),
	.MemoryRead	(MemRead),
	.ReadData	(intDataMemOut),
	.MemoryWrite (MemWrite)
);

assign dMemOut = intDataMemOut;

assign intRegFileBusW = (RegSrc == 1'b0) ? intALUBusW:intDataMemOut;


endmodule


