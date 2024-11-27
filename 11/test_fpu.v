module test_simple_fpu;
    reg [7:0] a, b;      // 8-bit floating-point inputs
    reg op;              // Operation: 0 for Add, 1 for Sub
    wire [7:0] result;   // 8-bit floating-point result

    // Instantiate the FPU
    simple_fpu uut (
        .a(a),
        .b(b),
        .op(op),
        .result(result)
    );

    // Test sequence
    initial begin
        $monitor("Time: %0t | A: %b | B: %b | Op: %b | Result: %b",
                 $time, a, b, op, result);

        // Test addition: 1.5 + 2.5
        // 1.5 = 0 0111 100, 2.5 = 0 1000 010
        a = 8'b00111100; // 1.5
        b = 8'b01000010; // 2.5
        op = 0;          // Add
        #10;

        // Test subtraction: 3.0 - 1.0
        // 3.0 = 0 1000 000, 1.0 = 0 0111 000
        a = 8'b01000000; // 3.0
        b = 8'b00111000; // 1.0
        op = 1;          // Sub
        #10;

        // Test addition: -1.5 + 1.5
        // -1.5 = 1 0111 100, 1.5 = 0 0111 100
        a = 8'b10111100; // -1.5
        b = 8'b00111100; // 1.5
        op = 0;          // Add
        #10;

        // Test subtraction: 5.0 - 3.0
        // 5.0 = 0 1000 100, 3.0 = 0 1000 000
        a = 8'b01000100; // 5.0
        b = 8'b01000000; // 3.0
        op = 1;          // Sub
        #10;

        $stop;
    end
endmodule
