module tb_clockgenerator;

    // Testbench signals
    reg clkin;
    reg [2:0] sel;
    wire clkout;

    // Instantiate the ClockGenerator module
    clockgenerator uut (
        .clkin(clkin),
        .clkout(clkout),
        .sel(sel)
    );
    always #5 clkin = ~clkin; // Toggle clock every 5 time units (period = 10)

    // Stimulus generation
    initial begin
        // Initialize inputs
        clkin = 0;
        sel = 3'b000;
        #10 sel = 3'b001;  // Direct clock output
        #10 sel = 3'b010;  // Divide by 2
        #10 sel = 3'b011;  // Divide by 4
        #10 sel = 3'b100;  // Divide by 8
        #10 sel = 3'b101;  // Divide by 16
        #10 sel = 3'b110;  // Divide by 32
        #10 sel = 3'b111;  // Always high

        // Finish the simulation
    end

    // Monitor output
    initial begin
        $monitor("At time %t, sel = %b, clkout = %b", $time, sel, clkout);
    end
endmodule
