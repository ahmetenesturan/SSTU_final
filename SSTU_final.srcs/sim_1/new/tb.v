`timescale 1ns / 1ps
module tb();

	reg clk,reset,Start;
	reg [7:0] InA,InB;
	wire [7:0] Out;
	wire Busy;

	TOP uut(clk,reset ,Start ,InA ,InB ,Busy ,Out );
	always #(10) clk = ~clk;

	initial begin
		clk = 0;
		reset = 1;
		InA = 0;
		InB = 0;
		Start = 0;
		#30;
        reset = 0;
		Start = 1;
		InA = 8'd8; 
		InB = 8'd6;	
		#1000;		
		//Start = 0;
		#1000;		
	end	     
endmodule