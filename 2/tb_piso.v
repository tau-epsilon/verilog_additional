module tb_Piso;
    reg clk;
    reg reset;
    reg load;
    reg [7:0] parallel_in;
    wire serial_out;
Piso piso(
        .clk(clk),
        .reset(reset),
        .load(load),
        .parallel_in(parallel_in),
        .serial_out(serial_out)
    );
	 initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        load = 0;
        parallel_in = 8'b10101010;

        // Release reset
        #5 reset = 0;
	 
        // Load data into PISO
        load = 1; #10; // Load the parallel data
        load = 0; #10;

        // Shift out bits
        repeat (8) begin
            #10; // Wait for clock cycle to shift out the next bit
            $display("PISO Serial Output: %b", serial_out); 
				end
				end
			 always #5 clk = ~clk; // Clock generation

endmodule
