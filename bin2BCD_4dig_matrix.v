`timescale 1ns / 1ps

module bin2BCD_4dig_matrix(
    input clk,
    input [15:0] matrix_val,
    output reg [11:0] matrix_val_dec
    );
    
    reg [3:0] bit_cnt;
    wire [3:0] dout;
    wire [3:0] BCD3, BCD2, BCD1, BCD0;
//    reg [3:0] out3, out2, out1, out0;
    reg din;
    reg done;
    wire overflow;
    wire not_used;
    wire [4:0] not_used5;

    bin2BCD_1dig dig0 (.done(done), .d_in(din), .clk(clk), .d_out(dout[0]), .Q(BCD0));
    bin2BCD_1dig dig1 (.done(done), .d_in(dout[0]), .clk(clk), .d_out(dout[1]), .Q(BCD1));
    bin2BCD_1dig dig2 (.done(done), .d_in(dout[1]), .clk(clk), .d_out(dout[2]), .Q(BCD2));
    bin2BCD_1dig dig3 (.done(done), .d_in(dout[2]), .clk(clk), .d_out(dout[3]), .Q(BCD3));

    assign overflow = !(matrix_val > 16'h270F); // overflow = 9999(decimal)
    
    // cnt down from f->0
    initial bit_cnt = 4'h4;
    always @ (posedge clk)
    begin
      bit_cnt = bit_cnt - 1;
    end
    
    initial matrix_val_dec = 16'h0000;
    always @ (posedge clk)
    begin 
      if (done)
         matrix_val_dec <= {BCD3[2:0], BCD2[3:0], BCD1[3:0], BCD0[3:0], din};
    end
    
    
    always @ (bit_cnt, matrix_val)
    begin
      din = matrix_val[bit_cnt];
      done = (bit_cnt == 4'b0000);
    end
    
endmodule
