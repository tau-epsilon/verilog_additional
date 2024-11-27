`timescale 1ns / 1ps

module tb_carry_lookahead_adder;

    reg [3:0] A;      // 4-bit input A
    reg [3:0] B;      // 4-bit input B
    reg Cin;          // Carry input
    wire [3:0] S;     // Sum output
    wire Cout;        // Carry output

    // Instantiate the Carry Lookahead Adder
    carry_lookahead_adder cla (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );

    initial begin
        // Display headers
        $display(" A     |  B     | Cin |  S     | Cout |");
        $display("---------------------------------------");

        // Loop through all possible values of A and B (16 values each)
        integer i, j, k;
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                for (k = 0; k < 2; k = k + 1) begin
                    A = i;          // Assign value to A
                    B = j;          // Assign value to B
                    Cin = k;        // Assign value to Cin
                    #10;            // Wait for 10 time units

                    // Display the results
                    $display(" %b | %b |  %b | %b |  %b |", A, B, Cin, S, Cout);
                end
            end
        end
        
        $finish; // End simulation
    end

endmodule
