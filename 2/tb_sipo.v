module tb_Sipo;
reg clk;
    reg reset;
    reg serial_in;
    reg load;
    wire [7:0] parallel_out;

    // Instantiate the SIPO Shift Register
    Sipo uut (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .load(load),
        .parallel_out(parallel_out)
    );

    // Clock generation (period = 10 time units)
    always begin
        #5 clk = ~clk;  // Toggle clock every 5 time units (period = 10)
    end
	 initial begin
	 clk= 0;
        reset = 0;
        serial_in = 0;
        load = 0;

        // Apply reset to initialize the shift register
        #5 reset = 1;
        #5 reset = 0;
		        // Test Case 1: Shift in 8 bits serially (1, 0, 1, 1, 0, 1, 0, 1)
        load = 1;
        serial_in = 1; #10;  // Shift in '1'
        serial_in = 0; #10;  // Shift in '0'
        serial_in = 1; #10;  // Shift in '1'
        serial_in = 1; #10;  // Shift in '1'
        serial_in = 0; #10;  // Shift in '0'
        serial_in = 1; #10;  // Shift in '1'
        serial_in = 0; #10;  // Shift in '0'
        serial_in = 1; #10;  // Shift in '1'
		  // Test Case 3: Reset the shift register
        reset = 1; #5;
        reset = 0; #5;
			        load = 1;
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;
        serial_in = 0; #10;

    end
	     initial begin
        $monitor("At time %t, parallel_out = %b", $time, parallel_out);
    end
