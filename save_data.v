`timescale 1ns / 1ps

module save_data;
    // Registers for inputs
    reg [15:0] data1_in;
    reg [15:0] data2_in;

    // File handle
    integer file_handle;

    // Clock to simulate data changes
    reg clk;

    // Initial setup for clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle clock every 5 ns
    end

    // Initial block to open file and manage simulation
    initial begin
        // Open file to write. "w" mode overwrites the file each time the simulation runs.
        file_handle = $fopen("captured_data.txt", "w");
        if (file_handle == 0) begin
            $display("Error opening file.");
            $finish;
        end

        // Start simulation tasks or input driving
        @(posedge clk) drive_inputs(16'hAAAA, 16'h5555);  // Simulate data input on posedge of clk
        @(posedge clk) drive_inputs(16'hCCCC, 16'h3333);
        @(posedge clk) drive_inputs(16'hFFFF, 16'h0000);

        // Finish simulation
        @(posedge clk);
        $fclose(file_handle);
        $finish;
    end

    // Task to drive inputs and log data
    task drive_inputs;
        input [15:0] d1, d2;
        begin
            data1_in = d1;
            data2_in = d2;
            // Log data to file
            $fwrite(file_handle, "Data1: %h, Data2: %h\n", data1_in, data2_in);
        end
    endtask
endmodule
