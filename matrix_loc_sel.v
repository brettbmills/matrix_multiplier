`timescale 1ns / 1ps

module matrix_loc_sel(
    input clk,
    input btnC,
    output reg [3:0] matrix_loc
    );    
    
    reg [1:0]sel;
    
    // for simulation
    //initial
    //    sel = 0;
    
    // 2-bit counter
    always @(posedge clk, posedge btnC)
    begin
        if (btnC)
            sel <= 0;
        else
            sel <= sel + 1;
    end       
    
    always@ *
    begin
        case(sel)
            2'b00: matrix_loc = 4'ha;
            2'b01: matrix_loc = 4'hb;
            2'b10: matrix_loc = 4'hc;
            2'b11: matrix_loc = 4'hd;
        endcase
    end 
     
endmodule
