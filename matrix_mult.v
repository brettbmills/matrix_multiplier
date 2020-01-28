`timescale 1ns / 1ps

module matrix_mult(
    input [7:0] X,
    input [7:0] Y,
    output reg [19:0] Z,
    output reg [3:0]  deter,
    input clk
    );
    reg [1:0] Ax, Bx, Cx, Dx; // X matrix values
    reg [1:0] Ay, By, Cy, Dy; // Y matrix values
    reg [4:0] Az, Bz, Cz, Dz; // Z matrix values
    
    // assign X values (A, B, C, D)
    initial {Ax, Bx, Cx, Dx} = 2'h0;
    always @(posedge clk)
    begin
        {Dx[1:0], Cx[1:0], Bx[1:0], Ax[1:0]} <= X[7:0];
    end
    
    // assign Y values (A, B, C, D)
    initial {Ay, By, Cy, Dy} = 2'h0;
    always @(posedge clk)
    begin
        {Dy[1:0], Cy[1:0], By[1:0], Ay[1:0]} <= Y[7:0];
    end
    
    // perform operations
    always@ *
    begin
        Az <= (Ax * Ay) + (Bx * Cy);
        Bz <= (Ax * By) + (Bx * Dy);
        Cz <= (Cx * Ay) + (Dx * Cy);
        Dz <= (Cx * By) + (Dx * Dy);
        
//        deter <= (Az * Dz) - (Bz * Cz); // this needs work, need to account for 2s comp somehow
    end
        
    // Assign Az, Bz, Cz, Dz to the Z matrix
    initial {Az, Bz, Cz, Dz} = 2'h0;
    always @(posedge clk)
    begin
        Z[19:0] <= {Dz[4:0], Cz[4:0], Bz[4:0], Az[4:0]};
    end
    
endmodule
