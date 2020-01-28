`timescale 1ns / 1ps

module matrix_gen(
    input [1:0] A,
    input [1:0] B,
    input [1:0] C,
    input [1:0] D,
    input clk,
    output reg [7:0] matrix_out
    );
    
    initial matrix_out = 8'h00;
    always @(posedge clk)
    begin
        matrix_out <= {D[1:0], C[1:0], B[1:0], A[1:0]};
    end    
    
endmodule
