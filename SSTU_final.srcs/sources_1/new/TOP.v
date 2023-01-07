`timescale 1ns / 1ps
module TOP(
    input clk,reset,Start,
	input [7:0]InA, InB, 
	output Busy, 
	output [7:0] Out 
    );    
    wire [2:0]InMuxAdd;
    wire [3:0]OutMuxAdd,RegAdd;
    wire WE,CO,Z;
    wire [7:0]ALUinA,ALUinB,ALUout,CUconst;
    wire [1:0]InsSel;
    CU a(clk ,reset, Start,CO,Z,WE,Busy,InsSel ,InMuxAdd ,OutMuxAdd ,RegAdd ,CUconst );
    ALU b(ALUinA ,ALUinB ,InsSel ,ALUout ,CO,Z);
    RB c(clk,reset ,InA ,InB,CUconst ,ALUout,InMuxAdd ,WE,RegAdd ,OutMuxAdd ,Out ,ALUinA,ALUinB );
endmodule