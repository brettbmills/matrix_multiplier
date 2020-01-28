`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////

module matrix_mult_top(
    input clk,
    input [15:0] sw,
    input btnC,
    input btnU,
    input btnD,
    input btnL,
    input btnR,
    output [3:0] an,
    output [6:0] seg,
    output dp,
    output [15:0] led
    );
    
    // matrix_gen
    reg [1:0] Ax, Bx, Cx, Dx; // X matrix values
    reg [1:0] Ay, By, Cy, Dy; // Y matrix values
    reg [4:0] Az, Bz, Cz, Dz; // Z matrix values
    // matrices
    wire [7:0]  matrix_X, matrix_Y;
    wire [19:0] matrix_Z;
    // get some more values
    wire [3:0]  matrix_loc;
    wire [15:0] matrix_val_out;
    // determinant
    wire [3:0] deter;
    // placeholder for addr to accomodate 16bit
    reg [11:0] addr_zero;
    
    wire [15:0] data_in_mem;        //Data for the input memory bank.
    wire [15:0] data_out_mem;       //Data for the output memory bank.
    wire [15:0] sum_data;           //The sum of the two halves of the input memory data.  It is stored in the output memory bank.
    wire clk_deb;                   //The debouncer clock (100MHz/(2^16).
    wire inc_addr, dec_addr;        //Increment/decrement the memory address by one or clear the address.
    wire sel_input, sel_output;     //Select the input or output memory bank.
    wire execute;                   //Execute is combined with other buttons to perform a task.
       
    reg wr_in_mem, rd_in_mem;       //Read and write mode for the input memory bank.
    reg wr_out_mem, rd_out_mem;     //Read and write mode for the output memory bank.
    reg we_in, we_out;              //Write enables for the input and output memory banks.
    reg oe_in, oe_out;              //Output enables for the input and output memory banks.
    reg [15:0] disp_data;           //Data sent to the 7-segment display.
                                    //Modified to 20bit to accomodate the matrix_Z
    reg sel_in_mem;                 //Registerred memory bank select.
    reg inc_addr_one, dec_addr_one; //Address operations
    reg rst_addr, inc_addr_all;     //Address operations   
    reg inc_addr_tm1, dec_addr_tm1; //Address operations (delayed by one clock cycle)
    reg [3:0] addr, addr_out_mem;   //Address for input and output memory locations.
                                    //The output memory address lags the input address by one clock cycle
    
    wire [4:0] not_used;            // for JA in SSEG
    // delays for pipeline
    reg [3:0] addr_out_mem1, addr_out_mem2; // delays for multiplier?
    reg [1:0] matrix_addr; // 4 locations for each of the 16 addresses
    reg mem_out_addr_en, mem_in_addr_en;
    
    wire clk_div;
    
    
    
    
    //////////////////////////////////////////////////////////////////////////////////    
    sseg_x4_top_matrix sseg_matrix (.clk(clk), .btnC(1'b0), .sw(disp_data), .seg(seg), .an(an), .dp(dp));
    
    debounce_div div1   (.clk(clk), .clk_deb(clk_deb));
    btn_debounce up     (.clk(clk_deb), .btn_in(btnU), .btn_status(inc_addr));
    btn_debounce down   (.clk(clk_deb), .btn_in(btnD), .btn_status(dec_addr));
    btn_debounce left   (.clk(clk_deb), .btn_in(btnL), .btn_status(sel_input));
    btn_debounce right  (.clk(clk_deb), .btn_in(btnR), .btn_status(sel_output));
    btn_debounce center (.clk(clk_deb), .btn_in(btnC), .btn_status(execute));
    
    memory in_mem (.we(we_in), .oe(oe_in), .clk(clk), .data(data_in_mem), .addr(addr));
//    memory out_mem (.we(we_out), .oe(oe_out), .clk(clk), .data(data_out_mem), .addr(addr_out_mem));
    out_mem64_matrix out_mem64 (.oe(oe_out), .we(we_out), .clk(clk_div), .data(data_out_mem), .addr(addr), .matrix_addr(matrix_addr));
        
    matrix_gen  X (.A(Ax), .B(Bx), .C(Cx), .D(Dx), .clk(clk), .matrix_out(matrix_X));
    matrix_gen  Y (.A(Ay), .B(By), .C(Cy), .D(Dy), .clk(clk), .matrix_out(matrix_Y));
    matrix_mult Z (.X(matrix_X), .Y(matrix_Y), .Z(matrix_Z), .deter(deter), .clk(clk));
    
    matrix_loc_sel loc_sel (.clk(clk), .btnC(1'b0), .matrix_loc(matrix_loc));
    matrix_val_sel val_sel (.matrix_loc(matrix_addr), .matrix_Z(matrix_Z), .clk(clk), .matrix_val_out(matrix_val_out));
    
    
    clk_div_universal clk_divider (.clk(clk), .clk_div(clk_div));
    //////////////////////////////////////////////////////////////////////////////////
    
    

    //////////////////////////////////////////////////////////////////////////////////
    assign data_in_mem = we_in?sw:16'hZZZZ;            //If we_in is enabled then store data from switches to data_in_mem. Otherwise,
                                                       //set switch inputs to high impedance inside the chip so that the memory can 
                                                       //drive the bi-directional bus.
    
    
    assign data_out_mem = we_out?matrix_val_out:16'hZZZZ;   //If we_out is enabled then store the result data into the output memory. 
                                                            //Otherwise, the sum_data (matrix_val_out, for my project) bus is set to high 
                                                            //impedance inside the chip so that the output memory can drive that 
                                                            //bi-directional bus to light the seven segment display.
    //////////////////////////////////////////////////////////////////////////////////


    //////////////////////////////////////////////////////////////////////////////////
    // assign input sw to corresponding x-values (A, B, C, D) in the matrix
    initial {Ax, Bx, Cx, Dx} = 2'h0;
    always @(posedge clk)
    begin
        {Dx[1:0], Cx[1:0], Bx[1:0], Ax[1:0]} <= data_in_mem[7:0];
    end
    
    // assign input sw to corresponding y-values (A, B, C, D) in the matrix
    initial {Ay, By, Cy, Dy} = 2'h0;
    always @(posedge clk)
    begin
        {Dy[1:0], Cy[1:0], By[1:0], Ay[1:0]} <= data_in_mem[15:8];
    end
    //////////////////////////////////////////////////////////////////////////////////
    
    //////////////////////////////////////////////////////////////////////////////////
    // Modified display select options
    // left btn = mem addr
    // right btn = Z matrix (result)
    //////////////////////////////////////////////////////////////////////////////////
    // initialize addr_zero
    initial addr_zero = 12'h000;
    always @ (sel_in_mem, data_in_mem, data_out_mem) //Selecting the display data
    begin
      if (sel_in_mem)                    //"sel_in_mem is registered so after the right or left buttons are pressed, the state is rememberred
          disp_data = {addr_zero, addr}; // NOTE: addr=4bits and disp_data=16bits, I may need to concatenate or something?
      else
          disp_data = data_out_mem;
    end
    // show what's in matrices X (led [7:0]) & Y (led [15:8]) on the leds
    // using leds to be able to show all 8 values within each respective matrix
    assign led[15:0] = data_in_mem;
    
    //////////////////////////////////////////////////////////////////////////////////
    // Brother Jack's code
    // Needs modified for my project
    //////////////////////////////////////////////////////////////////////////////////
    always @ (execute, sel_input, sel_in_mem, sel_output)  //Input and output memory mode configuration
    begin 
      wr_in_mem = execute && sel_input;    //"execute" is the de-bounced center button, "sel_input" is the debounced left button.
                                           //When both buttons are pressed, configure the memory busses so it is possible to
                                           //write to the input memory.
      rd_in_mem = !execute && sel_in_mem;  //"sel_in_mem" is the registerred version of "sel_input" (it doesn't go away when the
                                           //button is released). It is generated from a set/reset flip flop.
      wr_out_mem = execute && sel_output;  //When both "execute" (center button) and "set_output" (right button) are pressed,
                                           //configure the memory busses so it is possible to write to the output memory.
      rd_out_mem = !execute && !sel_in_mem;//"sel_in_mem" is registerred "false" when "sel_output" (right button is pressed).
                                           //Here we only have two states: select input memory, or select output memory.
      
      if (wr_in_mem)  //configure the memory busses so it is possible to write to the input memory bank.
      begin
        we_in = 1'b1;
        oe_in = 1'b0;
        we_out = 1'b0;
        oe_out = 1'b0;
        mem_in_addr_en = 1'b0;
        mem_out_addr_en = 1'b0;
      end
      else if (rd_in_mem) //configure the memory busses so it is possible to read from the input memory bank.
      begin
        we_in = 1'b0;
        oe_in = 1'b1;
        we_out = 1'b0;
        oe_out = 1'b0;
        mem_in_addr_en = 1'b1;
        mem_out_addr_en = 1'b0;
      end
      else if (wr_out_mem) //configure the memory busses so it is possible to write to the output memory bank.
      begin
        we_in = 1'b0;
        oe_in = 1'b1;      //enable the output of the input memory bank so it can drive the adder, which drives the input to the
                           //output memory bank
        we_out = 1'b1;
        oe_out = 1'b0;
        mem_in_addr_en = 1'b0;
        mem_out_addr_en = 1'b0;
      end
      else if (rd_out_mem)  //configure the memory busses so it is possible to read from the output memory bank.
      begin
        we_in = 1'b0;
        oe_in = 1'b0;
        we_out = 1'b0;
        oe_out = 1'b1;
        mem_in_addr_en = 1'b0;
        mem_out_addr_en = 1'b1;
      end
      else
      begin
        we_in = 1'b0;       //default
        oe_in = 1'b0;
        we_out = 1'b0;
        oe_out = 1'b0;
        mem_in_addr_en = 1'b0;
        mem_out_addr_en = 1'b0;
      end
    end
      

    
    always @ (posedge clk, posedge sel_output, posedge sel_input) //Registerring the input/output memory bank buttons
    begin
      if (sel_output) sel_in_mem <= 1'b0;
      else if (sel_input) sel_in_mem <= 1'b1;
    end
    
    always @ (inc_addr, inc_addr_tm1, execute, sel_output, dec_addr, dec_addr_tm1) // Address operations
    begin
      inc_addr_one = inc_addr && !inc_addr_tm1;  //Generates a single increment pulse (lasting one clock cycle) no matter 
                                                 //how long the increment button is pressed.
      dec_addr_one = dec_addr && !dec_addr_tm1;  //Generates a single decrement pulse (lasting one clock cycle).
      inc_addr_all = sel_output && execute;      //While these two buttons are pressed simultaneously, "in_addr_all" remains true.
                                                 //This is not a pulse.
      rst_addr = inc_addr && dec_addr;           //Pressing these two buttons resets the address.
    end
    
    always @ (posedge clk) //Address signals delayed by one clock cycle.
    begin
      inc_addr_tm1 <= inc_addr;  //Create a delayed version of "inc_addr" so an increment pulse may be generated.
      dec_addr_tm1 <= dec_addr;  //Create a delayed version of "dec_addr" so a decrement pulse may be generated.
      
//      // my implemented delay
      addr_out_mem <= addr_out_mem1;  // extra flip flop for delay on pipelining
////      addr_out_mem1 <= addr_out_mem2;
      
      addr_out_mem1 <= addr;          //Create a delayed version of "addr" for the output memory address so that the 
                                      //input and output memory blocks align (the sum is written one clock cycle after 
                                      //the input memory block is read).
    end
    
    initial addr = 4'h0;   //Address generator implementation
    always @ (posedge clk)
    begin
        if (rst_addr && mem_in_addr_en) addr <= 4'h0;
        else if (dec_addr_one && (addr > 4'h0) && mem_in_addr_en) addr <= addr - 1;
        else if ((inc_addr_one || inc_addr_all) && (addr < 4'hF) && mem_in_addr_en) addr <= addr + 1;
    end
    
//    initial addr_out_mem = 4'ha;   //Address Memory Out generator implementation
//    always @ (posedge clk)
//    begin
//        if (rst_addr && mem_out_addr_en) addr_out_mem <= 4'ha;
//        else if (dec_addr_one && (addr_out_mem > 4'ha) && mem_out_addr_en) addr_out_mem <= addr_out_mem - 1;
//        else if ((inc_addr_one || inc_addr_all) && (addr_out_mem < 4'hd) && mem_out_addr_en) addr_out_mem <= addr_out_mem + 1;
//    end
    
    initial matrix_addr = 2'h0;   //Matrix Address (A,B,C,D) generator implementation
    always @ (posedge clk)
    begin
        if (rst_addr && mem_out_addr_en) matrix_addr <= 2'h0;
        else if (dec_addr_one && (matrix_addr > 2'h0) && mem_out_addr_en) matrix_addr <= matrix_addr - 1;
        else if ((inc_addr_one || inc_addr_all) && (matrix_addr < 2'h3) && mem_out_addr_en) matrix_addr <= matrix_addr + 1;
    end

    //////////////////////////////////////////////////////////////////////////////////


endmodule
