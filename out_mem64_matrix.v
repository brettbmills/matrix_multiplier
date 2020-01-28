`timescale 1ns / 1ps

module out_mem64_matrix(
    input wire oe, we, clk,
    inout wire [15:0] data,
    input wire [3:0] addr,
    input wire [1:0] matrix_addr
    );
    
    reg [15:0] mem[63:0];
    reg [15:0] data_temp;
    reg [15:0] mem_temp[3:0];
    reg [5:0]  addr_temp;
    
//    initial addr_temp = 5'b00000;
//    always @(posedge clk)
//    begin
//        addr_temp <= {addr, matrix_addr};
//    end
  
    assign data = (oe && !we) ? data_temp:16'hzzzz;
    
//    always@(posedge clk)
//    begin
//        if(we) 
//        begin
//            mem[addr] <= data;
//        end
//        else if(oe) data_temp <= mem[addr];
//    end


    // really long, I'm not sure how to simplify...
    always @(posedge clk)
    case (addr)
        addr == 4'h0:   if (matrix_addr == 2'h0) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h1) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h2) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h3) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
        addr == 4'h1:   if (matrix_addr == 2'h0) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h1) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h2) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h3) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
        addr == 4'h2:   if (matrix_addr == 2'h0) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h1) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h2) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h3) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
        addr == 4'h3:   if (matrix_addr == 2'h0) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h1) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h2) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h3) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
        addr == 4'h4:   if (matrix_addr == 2'h0) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h1) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h2) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h3) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
        addr == 4'h5:   if (matrix_addr == 2'h0) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h1) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h2) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h3) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
        addr == 4'h6:   if (matrix_addr == 2'h0) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h1) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h2) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h3) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
        addr == 4'h7:   if (matrix_addr == 2'h0) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h1) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h2) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h3) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
        addr == 4'h8:   if (matrix_addr == 2'h0) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h1) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h2) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h3) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
        addr == 4'ha:   if (matrix_addr == 2'h0) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h1) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h2) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h3) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
        addr == 4'hb:   if (matrix_addr == 2'h0) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h1) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h2) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h3) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
        addr == 4'hc:   if (matrix_addr == 2'h0) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h1) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h2) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h3) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
        addr == 4'hd:   if (matrix_addr == 2'h0) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h1) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h2) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h3) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
        addr == 4'he:   if (matrix_addr == 2'h0) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h1) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h2) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h3) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
        addr == 4'hf:   if (matrix_addr == 2'h0) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h1) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h2) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
                        else if (matrix_addr == 2'h3) 
                        begin
                            if(we) begin mem[addr] <= data; end
                            else if(oe) data_temp <= mem[addr];
                        end
    endcase        




//    function addr_sel;
//        input oe, we, clk;
//        input [15:0] data;
//        input [3:0] addr;
//        input [1:0] matrix_addr;
//        reg [15:0] mem[63:0];
//        input [15:0] data_temp;
        
//        if (matrix_addr == 2'h0) 
//        begin
//            if(we) begin mem[addr] = data; end
//            else if(oe) data_temp = mem[addr];
//        end
//        else if (matrix_addr == 2'h1) 
//        begin
//            if(we) begin mem[addr] = data; end
//            else if(oe) data_temp = mem[addr];
//        end
//        else if (matrix_addr == 2'h2) 
//        begin
//            if(we) begin mem[addr] = data; end
//            else if(oe) data_temp = mem[addr];
//        end
//        else if (matrix_addr == 2'h3) 
//        begin
//            if(we) begin mem[addr] = data; end
//            else if(oe) data_temp = mem[addr];
//        end
//     endfunction
      
endmodule
