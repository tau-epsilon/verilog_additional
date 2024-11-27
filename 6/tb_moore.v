module tb_Moore;

    // Testbench signals
    reg din;
    reg clk;
    reg reset;
    wire y;

    // Instantiate the SequenceDetectorMoore module
    Moore uut (
        .din(din),
        .clk(clk),
        .reset(reset),
        .y(y)
    );

    // Clock generation (period = 10 time units)
    always #5 clk = ~clk; // Toggle clock every 5 time units (period = 10)
// Stimulus generation
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 0;
        din = 0;

        // Apply reset
        reset = 1;
        #10 reset = 0;

        // Test sequence: 001001
        // Expected to detect sequence at the end
        din = 0; #10;
        din = 0; #10;
        din = 1; #10;
        din = 0; #10;
        din = 0; #10;
        din = 1; #10;
		        // Test another sequence
        // Test sequence: 011
        // Expected not to detect sequence
        din = 0; #10;
        din = 1; #10;
        din = 1; #10;

        // Reset and test again
        reset = 1; #10;
        reset = 0;

        // Test sequence: 010
        // Expected not to detect sequence
        din = 0; #10;
        din = 1; #10;
        din = 0; #10;
    end

    // Monitor output
    initial begin
        $monitor("At time %t, din = %b, y = %b, nextState = %b", $time, din, y, uut.nextState);
    end

endmodule
