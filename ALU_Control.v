`timescale 1ns / 1ps

`define SLLFunc  6'b000000
`define SRLFunc  6'b000010
`define SRAFunc  6'b000011
`define ADDFunc  6'b100000
`define ADDUFunc 6'b100001
`define SUBFunc  6'b100010
`define SUBUFunc 6'b100011
`define ANDFunc  6'b100100
`define ORFunc   6'b100101
`define XORFunc  6'b000101
`define NORFunc  6'b100111
`define SLTFunc  6'b101010
`define SLTUFunc 6'b101011
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sai Sandeep L V
// 
// Create Date:    16:47:53 11/13/2016 
// Design Name: 
// Module Name:    ALUControl 
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

module ALUControl( ALUCtrl, ALUop, FuncCode
    );
	
	input [3:0]ALUop;
	input [5:0]FuncCode;
	
	output reg [3:0]ALUCtrl;
	
	always@(*)begin
	
	if(ALUop != 4'b1111) 
		ALUCtrl = ALUop;
	
	else begin
		case(FuncCode)

		`SLLFunc  :  ALUCtrl = 4'b0011;
				
		`SRLFunc  :	 ALUCtrl = 4'b0100;

		`SRAFunc  :	 ALUCtrl = 4'b1101;
				
		`ADDFunc  :	 ALUCtrl = 4'b0010;
				
		`ADDUFunc :	 ALUCtrl = 4'b1000;
				
		`SUBFunc  :	 ALUCtrl = 4'b0110;
				
		`SUBUFunc :	 ALUCtrl = 4'b1001;
				
		`ANDFunc  :	 ALUCtrl = 4'b0000;
				
		`ORFunc   :	 ALUCtrl = 4'b0001;
				
		`XORFunc  :	 ALUCtrl = 4'b1010;
				
		`NORFunc  :	 ALUCtrl = 4'b1100;
				
		`SLTFunc  :	 ALUCtrl = 4'b0111;
				
		`SLTUFunc :	 ALUCtrl = 4'b1011;
				
		  default :	 ALUCtrl = 4'bx;
						
			endcase
		end
	end

endmodule


