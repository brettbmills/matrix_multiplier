`timescale 1ns / 1ps

module digit_selector_matrix(
    input clk,
    input rst,
    output reg [3:0] digit_sel
    );
    reg [1:0]sel;
    
    // for simulation
    //initial
    //    sel = 0;
    
    // 2-bit counter
    always @(posedge clk, posedge rst)
    begin
        if (rst)
            sel <= 0;
        else
            sel <= sel + 1;
    end       
    
    always@ *
    begin
        case(sel)
            2'b00: digit_sel = 4'b1110; // low asserting for anode
            2'b01: digit_sel = 4'b1101;
            2'b10: digit_sel = 4'b1011;
            2'b11: digit_sel = 4'b0111;
        endcase
    end    
    
endmodule
