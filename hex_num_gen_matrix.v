`timescale 1ns / 1ps

module hex_num_gen_matrix(
    input [15:0] sw,
    input [3:0] digit_sel,
    output reg [3:0] hex_num
    );
    // for simulation
    //initial
    //    hex_num = 4'b1110;
    
    // check witch anode digit_sel is
    // then assign its switches (sw[15:0])
    always@ *
    begin
        if (digit_sel == 4'b1110) hex_num = sw[3:0];
        else if (digit_sel == 4'b1101) hex_num = sw[7:4];
        else if (digit_sel == 4'b1011) hex_num = sw[11:8];
        else if (digit_sel == 4'b0111) hex_num = sw[15:12];
    end
    
endmodule
