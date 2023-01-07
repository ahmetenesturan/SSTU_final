`timescale 1ns / 1ps
module RB(
    input clk,
    input reset,
    input [7:0] InA,
    input [7:0] InB,
    input [7:0] CUconst,
    input [7:0] ALUout,
    input [2:0] InMuxAdd,
    input WE,
    input [3:0] RegAdd,
    input [3:0] OutMuxAdd,
    output [7:0] Out,
    output [7:0] ALUinA,
    output [7:0] ALUinB
    );

    wire [7:0] RegOut;
    wire [7:0] mux8_out;
    wire [15:0] dec_out;
    wire [7:0] Rout [15:0];


    mux8 in_mux(.S(InMuxAdd), .I0(InA), .I1(InB), .I2(CUconst), .I3(ALUout), .I4(RegOut), .I5(RegOut), .I6(RegOut), .I7(RegOut), .O(mux8_out));

    decoder4x16 in_reg(RegAdd, WE, dec_out);

    genvar i;

    generate
        for(i = 0; i < 16; i = i + 1) begin
            register regs_gen(.clk(clk), .reset(reset), .en(dec_out[i]), .r_in(mux8_out), .r_out(Rout[i]));
        end
    endgenerate
            
    mux16 out_mux(.S(OutMuxAdd), .I0(Rout[0]), .I1(Rout[1]), .I2(Rout[2]), .I3(Rout[3]),
    .I4(Rout[4]), .I5(Rout[5]), .I6(Rout[6]), .I7(Rout[7]), 
    .I8(Rout[8]), .I9(Rout[9]), .I10(Rout[10]), .I11(Rout[11]), .I12(Rout[12]), .I13(Rout[13]), .I14(Rout[14]), .I15(Rout[15]), 
    .O(RegOut));

    assign Out = Rout[0];
    assign ALUinA = Rout[1];
    assign ALUinB = Rout[2];


endmodule
