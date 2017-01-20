`timescale 1ns / 1ps

`define RTYPEOPCODE 6'b000000
`define LWOPCODE    6'b100011
`define SWOPCODE    6'b101011
`define BEQOPCODE   6'b000100
`define JOPCODE     6'b000010
`define ORIOPCODE   6'b001101
`define ADDIOPCODE  6'b001000
`define ADDIUOPCODE 6'b001001
`define ANDIOPCODE  6'b001100
`define LUIOPCODE   6'b001111
`define SLTIOPCODE  6'b001010
`define SLTIUOPCODE 6'b001011
`define XORIOPCODE  6'b001110

`define SLLFunc  6'b000000
`define SRLFunc  6'b000010
`define SRAFunc  6'b000011


`define AND  4'b0000
`define OR   4'b0001
`define ADD  4'b0010
`define SLL  4'b0011
`define SRL  4'b0100
`define SUB  4'b0110
`define SLT  4'b0111
`define ADDU 4'b1000
`define SUBU 4'b1001
`define XOR  4'b1010
`define SLTU 4'b1011
`define NOR  4'b1100
`define SRA  4'b1101
`define LUI  4'b1110
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:23:47 11/13/2016 
// Design Name: 
// Module Name:    SingleCycleControl 
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
module SingleCycleControl( RegDst, ALUSrc1, ALUSrc2, MemToReg, RegWrite,MemRead,
									MemWrite, Branch, Jump, SignExtend, ALUOp, Opcode, FuncCode
    );

	input [5:0]Opcode;
	input [5:0]FuncCode;
	
	output reg RegDst;
	output reg ALUSrc1;
	output reg ALUSrc2;
	output reg MemToReg;
	output reg RegWrite;
	output reg MemRead;
	output reg MemWrite;
	output reg Branch;
	output reg Jump;
	output reg SignExtend;
	output reg [3:0]ALUOp;
	
		always@(*)begin
		
			case(Opcode)
					`RTYPEOPCODE : begin
										
												RegDst = 1'b1;
												
												if ( FuncCode == `SLLFunc || FuncCode == `SRLFunc || FuncCode == `SRAFunc )
													begin
															  ALUSrc1 = 1'b1 ;
															  ALUSrc2 = 1'b0 ;
													end
												else
													begin
															ALUSrc1 = 1'b0;
															ALUSrc2 = 1'b0;
													end
												MemToReg =1'b0;
												RegWrite = 1'b1;
												MemRead = 1'b0;
												MemWrite = 1'b0;
												Branch = 1'b0;
												Jump = 1'b0;
												SignExtend =1'b0;
												ALUOp = 4'b1111;
												
					
										end
					`LWOPCODE    :begin
												RegDst = 1'b0;
												ALUSrc1 = 1'b0;
												ALUSrc2 = 1'b1;
												MemToReg = 1'b1;
												RegWrite = 1'b1;
												MemRead = 1'b1;
												MemWrite = 1'b0;
												Branch = 1'b0;
												Jump = 1'b0;
												SignExtend =1'b1;
												ALUOp = `ADD;

										end
					`SWOPCODE    :begin
												RegDst = 1'bx;
												ALUSrc1 = 1'b0;
												ALUSrc2 = 1'b1;
												MemToReg = 1'b0;
												RegWrite = 1'b0;
												MemRead = 1'b0;
												MemWrite = 1'b1;
												Branch = 1'b0;
												Jump = 1'b0;
												SignExtend = 1'b1;
												ALUOp = `ADD;

										end
					`BEQOPCODE   :begin
												RegDst = 1'bx;
												ALUSrc1 = 1'b0;
												ALUSrc2 = 1'b0;
												MemToReg = 1'bx;
												RegWrite = 1'b0;
												MemRead = 1'b0;
												MemWrite = 1'b0;
												Branch = 1'b1;
												Jump = 1'b0;
												SignExtend = 1'b0;
												ALUOp = `XOR;

										end
					`JOPCODE     :begin
												RegDst = 1'bx;
												ALUSrc1 = 1'bx;
												ALUSrc2 = 1'bx;
												MemToReg = 1'bx;
												RegWrite = 1'b0;
												MemRead = 1'b0;
												MemWrite = 1'b0;
												Branch = 1'bx;
												Jump = 1'b1;
												SignExtend = 1'b0;
												ALUOp = 4'bxxxx;

										end
					`ORIOPCODE   :begin
												RegDst = 1'b0;
												ALUSrc1 = 1'b0;
												ALUSrc2 = 1'b1;
												MemToReg = 1'b0;
												RegWrite = 1'b1;
												MemRead = 1'b0;
												MemWrite = 1'b0;
												Branch = 1'b0;
												Jump = 1'b0;
												SignExtend = 1'b0;
												ALUOp = `OR;

										end
					`ADDIOPCODE  :begin
												RegDst = 1'b0;
												ALUSrc1 = 1'b0;
												ALUSrc2 = 1'b1;
												MemToReg = 1'b0;
												RegWrite = 1'b1;
												MemRead = 1'b0;
												MemWrite = 1'b0;
												Branch = 1'b0;
												Jump = 1'b0;
												SignExtend = 1'b1;
												ALUOp = `ADD;

										end
					`ADDIUOPCODE :begin
												RegDst = 1'b0;
												ALUSrc1 = 1'b0;
												ALUSrc2 = 1'b1;
												MemToReg = 1'b0;
												RegWrite = 1'b1;
												MemRead = 1'b0;
												MemWrite = 1'b0;
												Branch = 1'b0;
												Jump = 1'b0;
												SignExtend = 1'b1;
												ALUOp = `ADDU;

										end
					`ANDIOPCODE  :begin
												RegDst = 1'b0;
												ALUSrc1 = 1'b0;
												ALUSrc2 = 1'b1;
												MemToReg = 1'b0;
												RegWrite = 1'b1;
												MemRead = 1'b0;
												MemWrite = 1'b0;
												Branch = 1'b0;
												Jump = 1'b0;
												SignExtend = 1'b0;
												ALUOp = `AND;

										end
					`LUIOPCODE   :begin
												RegDst = 1'b0;
												ALUSrc1 = 1'bx;
												ALUSrc2 = 1'b1;
												MemToReg = 1'b0;
												RegWrite = 1'b1;
												MemRead = 1'b0;
												MemWrite = 1'b0;
												Branch = 1'b0;
												Jump = 1'b0;
												SignExtend = 1'bx;
												ALUOp = `LUI;

										end
					`SLTIOPCODE  :begin
												RegDst = 1'b0;
												ALUSrc1 = 1'b0;
												ALUSrc2 = 1'b1;
												MemToReg = 1'b0;
												RegWrite = 1'b1;
												MemRead = 1'b0;
												MemWrite = 1'b0;
												Branch = 1'b0;
												Jump = 1'b0;
												SignExtend = 1'b1;
												ALUOp = `SLT;

										end
					`SLTIUOPCODE :begin
												RegDst = 1'b0;
												ALUSrc1 = 1'b0;
												ALUSrc2 = 1'b1;
												MemToReg = 1'b0;
												RegWrite = 1'b1;
												MemRead = 1'b0;
												MemWrite = 1'b0;
												Branch = 1'b0;
												Jump = 1'b0;
												SignExtend = 1'b1;
												ALUOp = `SLTU;

										end
					`XORIOPCODE  :begin
												RegDst = 1'b0;
												ALUSrc1 = 1'b0;
												ALUSrc2 = 1'b1;
												MemToReg = 1'b0;
												RegWrite = 1'b1;
												MemRead = 1'b0;
												MemWrite = 1'b0;
												Branch = 1'b0;
												Jump = 1'b0;
												SignExtend = 1'b0;
												ALUOp = `XOR;

										end
						default:begin
												RegDst = 1'bx;
												ALUSrc1 = 1'bx;
												ALUSrc2 = 1'bx;
												MemToReg = 1'bx;
												RegWrite = 1'bx;
												MemRead = 1'bx;
												MemWrite = 1'bx;
												Branch = 1'bx;
												Jump = 1'bx;
												SignExtend = 1'bx;
												ALUOp = 4'bxxxx;

							end
							
					endcase
				
		
		
		end


endmodule


