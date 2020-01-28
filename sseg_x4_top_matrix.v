`timescale 1ns / 1ps

module sseg_x4_top_matrix(
    input clk,
    input btnC,
    input [19:0] sw,
    output [6:0] seg,
    output [3:0] an,
    output dp,
    input [4:0] JA
    );
    
    wire clkd;          // for clk_gen, digit_selector
    wire [3:0]not_used; // for seven_seg
    wire [3:0]hex_num;  // for seven_seg, hex_num_gen
    
    assign an = JA[3:0];
    assign clkd = JA[4];
    
    clk_gen_matrix        U0 (.clk(clk), .rst(btnC), .clk_div(clkd));
    digit_selector_matrix U1 (.clk(clkd), .rst(btnC), .digit_sel(an)); 
    seven_seg_matrix      U2 (.sw(hex_num), .seg(seg), .an(not_used), .dp(dp));
    hex_num_gen_matrix    U3 (.digit_sel(an), .sw(sw), .hex_num(hex_num));
    
endmodule
