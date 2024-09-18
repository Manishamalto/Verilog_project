module cyclic_shift(
    output reg [30:0] seq_out,
    input [30:0] seq_in,
    input [4:0] shift
);
    integer i;
    always @ (*) begin
        for (i = 0; i < 31; i = i + 1) begin
            seq_out[i] = seq_in[(i + shift) % 31];
        end
    end
endmodule
