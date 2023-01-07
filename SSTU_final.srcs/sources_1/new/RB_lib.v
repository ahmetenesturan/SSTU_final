`timescale 1ns / 1ps

module register(
	input clk,
	input reset,
	input en,
	input [7:0] r_in,
	output reg [7:0] r_out
    );

    reg [7:0]reg_next;
    reg [7:0]reg_out;
    
    always @(posedge clk, posedge reset) begin
        if(reset==1)
            reg_out <= 0;
        else
            reg_out <= reg_next;
    end
    
    //enable activates register
    always @(*) begin
        if(en)
            reg_next = r_in;
        else
            reg_next = reg_out;
    end
    
    (* dont_touch *) //if both enable and reset signals are low, output is unchanged
    always @(*) begin
        r_out = reg_out;
    end
endmodule


module mux8(
	input [7:0]I0,
	input [7:0]I1,
	input [7:0]I2,
	input [7:0]I3,
	input [7:0]I4,
	input [7:0]I5,
	input [7:0]I6,
	input [7:0]I7,
	input [2:0]S,
	output reg [7:0]O
    );

(* dont_touch *)
always @* begin
	case(S)
		3'b000: O = I0;
		3'b001: O = I1;
		3'b010: O = I2;
		3'b011: O = I3;
		3'b100: O = I4;
		3'b101: O = I5;
		3'b110: O = I6;
		3'b111: O = I7;
	endcase
end
endmodule

module mux16(
	input [7:0]I0,
	input [7:0]I1,
	input [7:0]I2,
	input [7:0]I3,
	input [7:0]I4,
	input [7:0]I5,
	input [7:0]I6,
	input [7:0]I7,
	input [7:0]I8,
	input [7:0]I9,
	input [7:0]I10,
	input [7:0]I11,
	input [7:0]I12,
	input [7:0]I13,
	input [7:0]I14,
	input [7:0]I15,
	input [3:0]S,
	output reg [7:0]O
    );

(* dont_touch *)
always @* begin
	case(S)
		4'b0000: O = I0;
		4'b0001: O = I1;
		4'b0010: O = I2;
		4'b0011: O = I3;
		4'b0100: O = I4;
		4'b0101: O = I5;
		4'b0110: O = I6;
		4'b0111: O = I7;
		4'b1000: O = I8;
		4'b1001: O = I9;
		4'b1010: O = I10;
		4'b1011: O = I11;
		4'b1100: O = I12;
		4'b1101: O = I13;
		4'b1110: O = I14;
		4'b1111: O = I15;
	endcase
end
endmodule

module decoder4x16(
	input [3:0]In,
	input en,
	output reg [15:0]Out
    );

(* dont_touch *) 
always @(*) begin
	if(en == 0)
		Out = 0; 
	else begin
		case(In)
			4'b0000: Out = 16'd1;
			4'b0001: Out = 16'd2;
			4'b0010: Out = 16'd4;
			4'b0011: Out = 16'd8;
			4'b0100: Out = 16'd16;
			4'b0101: Out = 16'd32;
			4'b0110: Out = 16'd64;
			4'b0111: Out = 16'd128;
			4'b1000: Out = 16'd256;
			4'b1001: Out = 16'd512;
			4'b1010: Out = 16'd1024;
			4'b1011: Out = 16'd2048;
			4'b1100: Out = 16'd4096;
			4'b1101: Out = 16'd8192;
			4'b1110: Out = 16'd16384;
			4'b1111: Out = 16'd32768;
		endcase
	end
end
endmodule
