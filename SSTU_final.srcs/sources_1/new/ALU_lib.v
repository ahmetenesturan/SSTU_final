`timescale 1ns / 1ps

module mux4(
	input [7:0]I0,
	input [7:0]I1,
	input [7:0]I2,
	input [7:0]I3,
	input [1:0]S,
	output reg [7:0]O
    );

(* dont_touch *)
always @* begin
	case(S)
		2'b00: O = I0;
		2'b01: O = I1;
		2'b10: O = I2;
		2'b11: O = I3;
	endcase
end
endmodule

module comp8(
	input [7:0] a,
	output reg Z
    );
    (* dont_touch *)
    always @* begin
        if(a==0)
            Z=1;
        else
            Z=0;
    end
endmodule

module add8 (x,y,c_in,c_out,sum);
input [7:0] x, y;
input c_in;
output c_out;
output [7:0] sum;
(* dont_touch *)
wire [8:0] temp;
assign temp[0]=c_in;
assign c_out=temp[8];
genvar i;
generate for (i=0;i<8;i=i+1) begin
(*DONT_TOUCH = "TRUE"*) FA FAn(x[i],y[i],temp[i],temp[i+1],sum[i]);
end 
endgenerate 
endmodule

module shift8(
	input [7:0] a,
	output [7:0] r
    );
(* dont_touch *)
assign r = {a[6:0],a[7]};
endmodule

module and8(
	input [7:0] a,
	input [7:0] b,
	output [7:0] r);
(* dont_touch *)
assign r = a & b;
endmodule

module xor8(
 	input [7:0] a,
	input [7:0] b,
	output [7:0] r
    );
(* dont_touch *)
assign r = a ^ b;
endmodule

module FA(
input x,y,c_in,
output c_out,sum);

(*DONT_TOUCH = "TRUE"*) wire sum0,c_out0,c_out1;
HA HA0(x,y,c_out0,sum0);

HA HA1(sum0,c_in,c_out1,sum);
OR OR0(c_out1,c_out0,c_out);

endmodule

module AND(
input I1,I2,
output O);

assign O = I1 & I2;
endmodule


module OR( 
input I1, I2,
output O);

assign O = I1 | I2;
endmodule


module HA( //halfadder 
input x,y,
output c_out,sum);

EXOR EXOR0(x,y,sum);
AND AND0(x,y,c_out);
endmodule

module EXOR(
input I1,I2,
output O);
LUT2# (.INIT(4'b0110))lut(.O(O),.I0(I1),.I1(I2)); 

endmodule