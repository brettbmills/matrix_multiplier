`timescale 1ns / 1ps

module matrix_val_sel(
    input [1:0] matrix_loc,
    input [19:0] matrix_Z,
    input clk,
    output reg [15:0] matrix_val_out
    );
    reg [15:0] matrix_val;
    reg [10:0] matrix_val_pad;
    reg [3:0]  matrix_addr_val;
    wire [11:0] matrix_val_dec;
    wire not_used;
    wire clkd;
    
    initial matrix_val_pad = 10'b0000000000;
    always@ *
    begin
        if      (matrix_loc == 4'h0) matrix_val = {matrix_val_pad, matrix_Z[4:0]};
        else if (matrix_loc == 4'h1) matrix_val = {matrix_val_pad, matrix_Z[9:5]};
        else if (matrix_loc == 4'h2) matrix_val = {matrix_val_pad, matrix_Z[14:10]};
        else if (matrix_loc == 4'h3) matrix_val = {matrix_val_pad, matrix_Z[19:15]};
    end
    
    // Assign A,B,C,D values
    initial matrix_addr_val = 4'h0;
    always@ *
    begin
        case(matrix_loc)
            matrix_loc == 2'h0: begin matrix_addr_val = 4'ha; end 
            matrix_loc == 2'h1: begin matrix_addr_val = 4'hb; end 
            matrix_loc == 2'h2: begin matrix_addr_val = 4'hc; end 
            matrix_loc == 2'h3: begin matrix_addr_val = 4'hd; end
       endcase          
    end
    
    clk_gen_BCD_matrix      BCD_clk (.clk(clk), .clk_div(clkd));
    bin2BCD_4dig_matrix getVal  (.clk(clk), .matrix_val(matrix_val), .matrix_val_dec(matrix_val_dec));
    
    initial matrix_val_out = 4'h0000;
    always @(posedge clkd)
    begin
        matrix_val_out <= {matrix_addr_val, matrix_val_dec};
    end
    
endmodule
