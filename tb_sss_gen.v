`timescale 1ns / 1ps

module tb_sss_gen;

    // Inputs
    reg [4:0] N_ID_2;
    reg slot;

    // Outputs
    wire [61:0] sss;

    // Instantiate the Unit Under Test (UUT)
    sss_gen uut (
        .sss(sss),
        .N_ID_2(N_ID_2),
        .slot(slot)
    );

    // Test scenarios
    initial begin
        // Initialize Inputs
        N_ID_2 = 0;  // Start with zero
        slot = 0;    // Even slot

        // Wait 10 ns for global reset to finish
        #10;
        
        // Applying different test cases
        N_ID_2 = 5'b00001; slot = 1'b0;  // Test Case 1
        #10;
        N_ID_2 = 5'b00010; slot = 1'b1;  // Test Case 2
        #10;
        N_ID_2 = 5'b00011; slot = 1'b0;  // Test Case 3
        #10;
        N_ID_2 = 5'b00100; slot = 1'b1;  // Test Case 4
        #10;

        // Complete the test
        $finish;
    end

    // Monitor outputs to observe behavior
    initial begin
        $monitor("At time %t, N_ID_2 = %d, slot = %d, sss = %b", $time, N_ID_2, slot, sss);
    end

endmodule
