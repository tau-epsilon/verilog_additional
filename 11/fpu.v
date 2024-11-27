module simple_fpu (
    input [7:0] a,       // 8-bit floating-point input A
    input [7:0] b,       // 8-bit floating-point input B
    input op,            // Operation: 0 for Add, 1 for Sub
    output reg [7:0] result // 8-bit floating-point result
);
    reg sign_a, sign_b, sign_result;       // Sign bits
    reg [3:0] exp_a, exp_b, exp_result;    // Exponent bits
    reg [3:0] exp_diff;                    // Exponent difference
    reg [4:0] aligned_mantissa_b;          // Aligned Mantissa B
    reg [4:0] mantissa_a, mantissa_b;      // Mantissa bits (4 bits for leading 1)
    reg [5:0] mantissa_sum;                // Sum of mantissas (1 extra bit for overflow)

    always @(*) begin
        // Parse inputs
        sign_a = a[7];
        exp_a = a[6:3];
        mantissa_a = {1'b1, a[2:0]}; // Add implicit leading 1 for normalized mantissa

        sign_b = b[7];
        exp_b = b[6:3];
        mantissa_b = {1'b1, b[2:0]}; // Add implicit leading 1 for normalized mantissa

        // Align the exponents
        if (exp_a > exp_b) begin
            exp_diff = exp_a - exp_b;
            aligned_mantissa_b = mantissa_b >> exp_diff;
            exp_result = exp_a;
        end else begin
            exp_diff = exp_b - exp_a;
            aligned_mantissa_b = mantissa_a >> exp_diff;
            mantissa_a = mantissa_b;
            exp_result = exp_b;
            sign_a = sign_b; // Adjust sign for the larger number
        end

        // Perform operation based on signs and op
        if (op ^ sign_b) begin
            mantissa_sum = mantissa_a + aligned_mantissa_b; // Addition
        end else begin
            if (mantissa_a >= aligned_mantissa_b) begin
                mantissa_sum = mantissa_a - aligned_mantissa_b;
            end else begin
                mantissa_sum = aligned_mantissa_b - mantissa_a;
                sign_result = ~sign_a; // Flip the result sign
            end
        end

        // Normalize the result
        if (mantissa_sum[5]) begin
            mantissa_sum = mantissa_sum >> 1;
            exp_result = exp_result + 1;
        end else begin
            while (!mantissa_sum[4] && exp_result > 0) begin
                mantissa_sum = mantissa_sum << 1;
                exp_result = exp_result - 1;
            end
        end

        // Assemble result
        result = {sign_result, exp_result, mantissa_sum[3:0]};
    end
endmodule
