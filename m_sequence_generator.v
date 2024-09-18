module m_sequence_generator(
    input clk,
    input reset,
    output reg [30:0] m_seq
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            m_seq <= 31'b1;  // Non-zero initial state
        end else begin
            m_seq <= {m_seq[29:0], m_seq[30] ^ m_seq[27]}; // Example feedback polynomial x^31 + x^28 + 1
        end
    end
endmodule
