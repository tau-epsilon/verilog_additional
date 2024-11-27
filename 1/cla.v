module carry_lookahead_adder (
    input [3:0] A, // 4-bit input A
    input [3:0] B, // 4-bit input B
    input Cin,     // Carry input
    output [3:0] S, // Sum output
    output Cout     // Carry output
);
    wire [3:0] G; // Generate
    wire [3:0] P; // Propagate
    wire [3:0] C; // Carry

    // Generate and Propagate
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : genprop
            assign G[i] = A[i] & B[i]; // Generate
            assign P[i] = A[i] ^ B[i]; // Propagate
        end
    endgenerate

    // Carry Lookahead Logic
    assign C[0] = Cin; // Initial carry in
    generate
        for (i = 1; i < 4; i = i + 1) begin : carry_logic
            assign C[i] = G[i-1] | (P[i-1] & C[i-1]); // Carry generation
        end
    endgenerate

    // Sum Calculation
    generate
        for (i = 0; i < 4; i = i + 1) begin : sum_logic
            assign S[i] = P[i] ^ C[i]; // Sum output
        end
    endgenerate

    // Final carry out
    assign Cout = C[3];

endmodule

