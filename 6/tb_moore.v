module test_moore_fsm_counter;
    reg clk;
    reg reset;
    wire out;

    // Instantiate the Moore FSM Counter
    moore_fsm_counter uut (
        .clk(clk),
        .reset(reset),
        .out(out)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // Toggle the clock every 5 time units
    end

    initial begin
        // Initialize
        clk = 0;
        reset = 1;   // Initially reset the FSM
        
        // Apply reset
        #10 reset = 0;  // Deassert reset after 10 time units
        
        // Test sequence
        #10;  // Check state 00
        #10;  // Check state 01
        #10;  // Check state 10 (output should be 1)
        #10;  // Check state 11
        #10;  // Check state 00 again (wrap around)
        
        #10 $stop;  // Stop the simulation
    end
endmodule
