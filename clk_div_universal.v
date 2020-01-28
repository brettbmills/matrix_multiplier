`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2019 05:42:35 PM
// Design Name: 
// Module Name: clk_div_universal
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_div_universal(
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
