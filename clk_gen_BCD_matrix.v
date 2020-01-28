`timescale 1ns / 1ps

module clk_gen_BCD_matrix(
    input clk,
    output clk_div
    );
    reg [25:0]Q;

    initial
     Q = 0;

    // use zero for simulation 
    //assign clk_div = Q[0]; // 50 MHz -> 50MHz
    // use twenty for actual implementation
    assign clk_div = Q[8]; // 100 MHz -> 

    always@(posedge clk)   
        begin
            Q <= Q + 1;
        end    
    
    
endmodule
