`timescale 1ns / 1ps

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
// Engineer: 	Sai Sandeep L V
// 
// Create Date:    08:24:37 11/13/2016 
// Design Name: 
// Module Name:    ALU 
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
module ALU( BusA, BusB, ALUCtrl, BusW, Zero
    );
	

	input [31:0] BusA,BusB;
	input [3:0] ALUCtrl;
	
	output reg [31:0] BusW;
	output Zero;
	
		assign Zero = (BusW == 32'b0) ? 1'b1 : 1'b0 ;
	
	always@(*)begin
	
	case(ALUCtrl)
		
		`AND: BusW = BusA & BusB;
			
		`OR:  BusW = BusA | BusB;
		
		`ADD:	BusW = $signed(BusA) + $signed(BusB);
			
		`SLL: BusW = BusB << BusA[4:0];
			
		`SRL: BusW = BusB >> BusA[4:0];
			
		`SUB: BusW = $signed(BusA) - $signed(BusB);
			
		`SLT: BusW = ($signed(BusA) < $signed(BusB)) ? 1:0;
			
	    	`ADDU: BusW = (BusA) + (BusB);
			
	     	`SUBU: BusW = (BusA) - (BusB);
			
		`XOR: BusW = BusA ^ BusB;
			
     	     	`SLTU: BusW = (BusA < BusB) ? 1:0;
			
		`NOR: BusW = ~(BusA | BusB);
			
		`SRA: BusW = $signed(BusB) >>> BusA[4:0];
			
		`LUI: BusW = {BusB,16'b0};
			
	   default:	 BusW = 32'bx;
					
	endcase
	
	
	end
	
	
	
endmodule


