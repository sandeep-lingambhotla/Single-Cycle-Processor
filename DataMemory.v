`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sai Sandeep L V
// 
// Create Date:    19:47:22 11/12/2016 
// Design Name: 
// Module Name:    DataMemory 
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
module DataMemory( ReadData, WriteData, Address, MemoryRead, MemoryWrite, Clock
    );
	 
	 input [31:0]WriteData;
	 input [5:0]Address;
	 input MemoryRead;
	 input MemoryWrite;
	 input Clock;
	 
	 output [31:0]ReadData;
	 reg [31:0]ReadData;
	 
	 reg [31:0]a[63:0];
	 
	 always@(posedge Clock)begin
		
		if(MemoryRead)
				ReadData <= a[Address];
		else ;
		
		end
		
	 always@(negedge Clock) begin
		
		if(MemoryWrite)
			a[Address] <= WriteData;
		else ;
		
	  end


endmodule


