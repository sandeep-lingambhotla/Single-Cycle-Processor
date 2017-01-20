`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sai Sandeep L V
// 
// Create Date:    18:08:26 11/12/2016 
// Design Name: 
// Module Name:    RegisterFile 
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
module RegisterFile( BusA, BusB, BusW, RA, RB, RW, RegWr, Clk
    );

input [31:0]BusW;
input [4:0]RA;
input [4:0]RB;
input [4:0]RW;
input RegWr;
input Clk;

output [31:0]BusA;
output [31:0]BusB;
//reg [31:0]BusA;
//reg [31:0]BusB;

reg [31:0]a[31:1];			//This is the register file

//This part is for reading the memory
//These are read asynchronously
// If you are doing a continuous assign, dont instantiate as a reg.

assign BusA = (RA != 0)? a[RA]:0;
assign BusB = (RB != 0)? a[RB]:0;


//This part is for writing from memory
always@(negedge Clk)begin
	if(RegWr)
		if(RW != 5'b0)	
			a[RW]<=BusW;
		
	end

endmodule


