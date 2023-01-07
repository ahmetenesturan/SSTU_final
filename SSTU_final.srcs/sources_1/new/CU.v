`timescale 1ns / 1ps
module CU(
    input clk,
    input reset,
    input start,
    input CO,
    input Z,
    output Busy,
    output [1:0] InsSel,
    output [7:0] CUconst,
    output [3:0] InMuxAdd,
    output [3:0] OutMuxAdd,
    output [3:0] RegAdd,
    output WE);

    reg [3:0] s;

    reg mult_cnt;
    reg div_cnt;

    always @(posedge clk or posedge reset) begin

        if(reset) begin
            s <= 0;
            WE <= 0;
            Busy <= 0;
            InsSel <= 0;
            CUconst <= 0;
            InMuxAdd <= 0;
            OutMuxAdd <= 0;
            RegAdd <= 0;
            mult_cnt <= 0;
            div_cnt <= 0;
        end
        else begin
            case(s)
            0 : begin //reset
                if(start) begin
                    s <= 1;
                    Busy <= 1;
                end
            end
            1: begin //read A and write reg[3]
                InMuxAdd <= 0;
                RegAdd <= 3;
                WE <= 1;
                s <= 2;
            end
            2: begin //read B and write reg[4]
                InMuxAdd <= 1;
                RegAdd <= 4;
                WE <= 1;
                s <= 3;
            end
            3: begin //start of A * 6, aluinA = A
                OutMuxAdd <= 3;
                InMuxAdd <= 4;
                RegAdd <= 1;
                WE <= 1;
                s <= 4;
            end
            4: begin //aluinB = A
                OutMuxAdd <= 3;
                InMuxAdd <= 4;
                RegAdd <= 2;
                WE <= 1;
                s <= 5;
                InsSel <= 2; //read sum
            end
            5: begin //sum in ALU
                if(mult_cnt == 5) begin
                    InMuxAdd <= 3; //read alu out
                    RegAdd <= 0;
                    WE <= 1;
                    mult_cnt <= mult_cnt + 1;
                    s <= 6;
                end
                else begin
                    InMuxAdd <= 3; //read alu out
                    RegAdd <= 0;
                    WE <= 1;
                    mult_cnt <= mult_cnt + 1;
                end
            end
            6: begin

            end
            7: begin

            end
            8: begin

            end
            9: begin

            end
            10: begin

            end
            11: begin

            end
            12: begin

            end
            endcase
        end
        
    end

endmodule
