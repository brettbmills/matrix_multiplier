`timescale 1ns / 1ps

module seven_seg_matrix(
    input [3:0] sw,
    output reg [6:0] seg,
    output dp,
    output [3:0] an
    );
    assign an = 4'b1110;
    assign dp = 1'b1;
    
    // for simulation
    //initial
    //    seg = 7'b1000000;
    
    always @(sw)
    begin
        if (sw == 4'h0) seg = 7'b1000000;
        else if (sw == 4'h1) seg = 7'b1111001;
        else if (sw == 4'h2) seg = 7'b0100100;
        else if (sw == 4'h3) seg = 7'b0110000;
        else if (sw == 4'h4) seg = 7'b0011001;
        else if (sw == 4'h5) seg = 7'b0010010;
        else if (sw == 4'h6) seg = 7'b0000010;
        else if (sw == 4'h7) seg = 7'b1111000;
        else if (sw == 4'h8) seg = 7'b0000000;
        else if (sw == 4'h9) seg = 7'b0010000;
        else if (sw == 4'ha) seg = 7'b0001000;
        else if (sw == 4'hb) seg = 7'b0000011;
        else if (sw == 4'hc) seg = 7'b0100111;
        else if (sw == 4'hd) seg = 7'b0100001;
        else if (sw == 4'he) seg = 7'b0000110;
        else if (sw == 4'hf) seg = 7'b0001110; 
    end

endmodule
