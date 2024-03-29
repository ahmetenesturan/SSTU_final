`timescale 1ns / 1ps
module CU(
    input clk,
    input reset,
    input start,
    input CO,
    input Z,
    output reg WE,
    output reg Busy,
    output reg [1:0] InsSel,
    output reg [2:0] InMuxAdd,
    output reg [3:0] OutMuxAdd,
    output reg [3:0] RegAdd,
    output reg [7:0] CUconst
    );

    reg [4:0] s;

    //reg mult_cnt;
    //reg div_cnt;

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
            //mult_cnt <= 0;
            //div_cnt <= 0;
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
            5: begin //write sum to reg1, 2A
                InMuxAdd <= 3; //read alu out
                RegAdd <= 1;
                WE <= 1;
                s <= 6;
            end
            6: begin  //write sum to reg1, 3A
                InMuxAdd <= 3; //read alu out
                RegAdd <= 1;
                WE <= 1;
                s <= 7;
            end
            7: begin  //write sum to reg1, 4A
                InMuxAdd <= 3; //read alu out
                RegAdd <= 1;
                WE <= 1;
                s <= 8;
            end
            8: begin  //write sum to reg1, 5A
                InMuxAdd <= 3; //read alu out
                RegAdd <= 1;
                WE <= 1;
                s <= 9;
            end
            9: begin  //write sum to reg5, 6A, mult finished here
                InMuxAdd <= 3; //read alu out
                RegAdd <= 5;
                WE <= 1;
                s <= 10;
            end
            10: begin  //calc 6A + B, aluinA = 6A, which is reg5
                InMuxAdd <= 4; //read reg
                OutMuxAdd <= 5; //use reg5
                RegAdd <= 1; //write to aluinA
                WE <= 1;
                s <= 11;               
            end
            11: begin  //aluinB = B, which is reg4
                InMuxAdd <= 4; //read reg
                OutMuxAdd <= 4; //use reg4
                RegAdd <= 2; //write to aluinB
                WE <= 1;
                s <= 12;  
            end
            12: begin //alu calcs 6A + B, write result to reg6
                InMuxAdd <= 3; //read alu out
                RegAdd <= 6; //reg6
                WE <= 1;
                s <= 13;
            end
            13: begin //begin to division 3, reg7 is the division counter reg
                InMuxAdd <= 4; //reg read mode
                OutMuxAdd <= 6; //read reg6
                RegAdd <= 1; //write reg1, aluin_a
                WE <= 1;
                InsSel <= 3;
                s <= 14;
            end
            14: begin //set div const
                CUconst <= 8'b1111_1101; //-3 for substraction
                InMuxAdd <= 2; //const mode
                RegAdd <= 2; //write reg2, aluinB
                WE <= 1;
                InsSel <= 3;
                s <= 15;                
            end
            15: begin //left bit shift, to check if the result is negative, 15 16 are used in this part
                if(CO) begin //result is negative, should use prev result, read div counter reg: reg7
                    InMuxAdd <= 4;
                    OutMuxAdd <= 7;
                    RegAdd <= 1;
                    WE <= 1;
                    s <= 20;
                    
                end
                else begin //make the sub
                    InsSel <= 2; //add mode 
                    InMuxAdd <= 3; //read alu out
                    RegAdd <= 8; //write to reg8
                    WE <= 1;
                    s <= 16;
                end
            end
            16: begin //increment the div counter, read div counter reg7
                InMuxAdd <= 4;
                OutMuxAdd <= 7;
                RegAdd <= 1; //write to aluinA
                WE <= 1;
                s <= 17;
            end
            17: begin //read counter, read +1
                CUconst <= 1;
                InMuxAdd <= 2;
                RegAdd <= 2; //write to aluinB
                WE <= 1;
                InsSel <= 2; //add mode
                s <= 18;
            end
            18: begin //write res to counter
                InMuxAdd <= 3; //read alu
                WE <= 1;
                RegAdd <= 7; //write to reg7
                s <= 19;
            end
            19: begin //read the dividend, which is in reg 8
                OutMuxAdd <= 8;
                InMuxAdd <= 4; //read reg
                WE <= 1;
                RegAdd <= 1; //write to aluinA
                s <= 14; //set -3 const and do the division again
            end
            20: begin //finish state
                CUconst <= 8'b1111_1111; //-1 for substraction
                InMuxAdd <= 2; //const mode
                RegAdd <= 2; //write reg0, aluinA
                WE <= 1;
                InsSel <= 2;
                s <= 21;
            end
            21: begin
                InMuxAdd <= 3; //read alu
                RegAdd <= 0; //output
                WE <= 1;
                s <= 22;
            end
            22: begin
                WE <= 0; //disable write
                Busy <= 0;
                //s <= 0; //go to initial state
            end
            endcase
        end
        
    end

endmodule
