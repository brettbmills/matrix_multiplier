`timescale 1ns / 1ps

module clk_gen_matrix(
    input clk,
    input rst,
    output clk_div
    );
    reg [25:0]Q;

    initial
     Q = 0;

    // use zero for simulation 
    //assign clk_div = Q[0]; // 50 MHz -> 50MHz
    // use twenty for actual implementation
    assign clk_div = Q[13]; // 100 MHz -> 

    always@(posedge clk, posedge rst)   
        begin
        if (rst)
            Q <= 0;
        else
            Q <= Q + 1;
        end
        
endmodule
