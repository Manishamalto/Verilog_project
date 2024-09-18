`timescale 1ns / 1ps

module tb_sss_generator;

    // Inputs
    reg clk;
    reg reset;
    reg [4:0] N_ID_2;

    // Outputs
    wire [61:0] sss;

    // Instantiate the Unit Under Test (UUT)
    sss_generator uut (
        .clk(clk),
        .reset(reset),
        .N_ID_2(N_ID_2),
        .sss(sss)
    );

    // Clock generation
    always #10 clk = ~clk;  // 50 MHz clock

    // Test sequence
    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        N_ID_2 = 0;

        // Wait for global reset
        #100;
        reset = 0;
        N_ID_2 = 5;  // Example N_ID_2 value

        // Wait for the sequence to stabilize
        #100;
        N_ID_2 = 2;  // Change N_ID_2 to another example

        // Observe changes in the sequence
        #100;
        $finish;
    end
      
endmodule
