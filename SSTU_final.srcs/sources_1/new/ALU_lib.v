`timescale 1ns / 1ps

module subs(

    );
endmodule

module mux4(
	input [3:0]I0,
	input [3:0]I1,
	input [3:0]I2,
	input [3:0]I3,
	input [1:0]S,
	output reg [3:0]O
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