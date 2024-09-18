module correlator(
    input clk,
    input reset,
    input [61:0] received_sss,
    input [61:0] local_sss,
    output reg [31:0] correlation_result
);
    integer j;

    always @(posedge clk) begin
        if (reset) begin
            correlation_result <= 32'b0;
        end else begin
            correlation_result <= 32'b0;
            for (j = 0; j < 62; j = j + 1) begin
                correlation_result <= correlation_result + (received_sss[j] == local_sss[j]);
            end
        end
    end
endmodule
