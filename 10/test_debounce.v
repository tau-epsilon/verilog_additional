module test_push_button;
    reg clk;             // Clock signal
    reg reset;           // Reset signal
    reg button_in;       // Simulated button input
    wire led_out;        // LED output

    // Instantiate the push_button module
    push_button uut (
        .clk(clk),
        .reset(reset),
        .button_in(button_in),
        .led_out(led_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units clock period
    end

    // Test sequence
    initial begin
        // Monitor outputs
        $monitor("Time: %0t | Reset: %b | Button: %b | LED: %b",
                 $time, reset, button_in, led_out);

        // Initialize
        reset = 1;
        button_in = 0;
        #20 reset = 0;

        // Simulate button press with bounce
        #30 button_in = 1; // Press
        #10 button_in = 0; // Bounce
        #10 button_in = 1; // Press stable
        #50 button_in = 0; // Release

        // Simulate another button press with bounce
        #70 button_in = 1; // Press
        #10 button_in = 0; // Bounce
        #10 button_in = 1; // Press stable
        #50 button_in = 0; // Release

        // End simulation
        #100 $stop;
    end
endmodule
