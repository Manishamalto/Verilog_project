module sss_gen(
    output reg [61:0] sss,
    input [4:0] N_ID_2,  // Correct bit-width for input
    input slot
);
    wire [30:0] s0_base, s1_base;
    wire [30:0] s0, s1;
    wire [4:0] shift_amount;

    // Pass a fixed bit-width to m_sequence_gen
    m_sequence_gen gen0(s0_base, 5'd5);  // Using a 5-bit wide decimal constant
    m_sequence_gen gen1(s1_base, 5'd5);  // Using a 5-bit wide decimal constant

    assign shift_amount = N_ID_2 % 5'd31;  // Modulus with a 5-bit constant

    cyclic_shift shift0(s0, s0_base, shift_amount);
    cyclic_shift shift1(s1, s1_base, shift_amount);

    always @ (s0, s1, slot) begin
        if (slot % 2 == 0) begin
            sss = {s0, s1};
        end else begin
            sss = {s1, s0};
        end
    end
endmodule
