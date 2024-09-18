`timescale 1ns / 1ps

module tb_correlator;

    // Inputs
    reg clk;
    reg reset;
    reg [61:0] received_sss;
    reg [61:0] local_sss;

    // Outputs
    wire [31:0] correlation_result;

    // Instantiate the Unit Under Test (UUT)
    correlator uut (
        .clk(clk),
        .reset(reset),
        .received_sss(received_sss),
        .local_sss(local_sss),
        .correlation_result(correlation_result)
    );

    // Clock generation
    always #10 clk = ~clk;  // 50 MHz clock

    // Test sequence
    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        received_sss = 62'b1010101010101010101010101010101010101010101010101010101010101010; // Example pattern
        local_sss = 62'b1010101010101010101010101010101010101010101010101010101010101010; // Same as received

        // Wait for global reset
        #100;
        reset = 0;

        // Test with matching sequence
        #100;
        local_sss = 62'b0101010101010101010101010101010101010101010101010101010101010101; // Different pattern

        // Test with non-matching sequence
        #100;
        $finish;
    end
      
endmodule
