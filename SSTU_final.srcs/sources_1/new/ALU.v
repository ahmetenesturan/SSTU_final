`timescale 1ns / 1ps
module ALU(
input [7:0] ALUinA,ALUinB,
	input [1:0] InsSel,
	output [7:0] ALUout,
	output CO,Z
    );
wire [7:0] out1, out2, out3, out4;
wire carry_out;
	and8 a(ALUinA,ALUinB,out1);		
	xor8 b(ALUinA,ALUinB,out2);   
	add8 c(ALUinA,ALUinB,1'b0,carry_out, out3);	
	shift8 d(ALUinA,out4);	
	
	comp8 e(ALUout,Z); 
	mux4 f(out1,out2,out3,out4,InsSel,ALUout);	
	mux4 g(1'b0,1'b0,carry_out,out4[0],InsSel,CO);
endmodule