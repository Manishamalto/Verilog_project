module m_sequence_gen(
    output reg [30:0] seq,
    input [4:0] N  // Correct bit-width enforced in the port declaration
);
    integer i;
    always @ (N)  // Correct sensitivity to changes in N
    begin
        for (i = 0; i < 31; i = i + 1) begin
            seq[i] = $random % 2;
        end
    end
endmodule

