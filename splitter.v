`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2024 20:54:58
// Design Name: 
// Module Name: splitter
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


module DataSplitter(
    input wire clock,        // Clock signal
    input wire valid,        // Input valid signal
    input wire [31:0] tdata, // 32-bit input data
    output reg [15:0] data0, // First 16-bit output data
    output reg [15:0] data1  // Second 16-bit output data
);

// On every positive edge of the clock, check if the input is valid
// If valid, split the data into two parts
always @(posedge clock) begin
    if (valid) begin
        data0 <= tdata[15:0];  // Assign lower 16 bits to data0
        data1 <= tdata[31:16]; // Assign upper 16 bits to data1
    end
end

endmodule