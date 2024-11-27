module test_traffic_light;
    reg clk;       // Clock signal
    reg reset;     // Reset signal
    wire [2:0] light; // Traffic light output

    // Instantiate the traffic light module
    traffic_light uut (
        .clk(clk),
        .reset(reset),
        .light(light)
    );

    // Clock generation: 10 time units period
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Test sequence
    initial begin
        $monitor("Time: %0t | Reset: %b | Light: %b (Red: %b, Yellow: %b, Green: %b)",
                 $time, reset, light, light[2], light[1], light[0]);

        // Initialize
        reset = 1;
        #10; // Wait for 10 time units
        
        reset = 0;
        #100; // Run for 100 time units

        $stop; // End simulation
    end
endmodule
