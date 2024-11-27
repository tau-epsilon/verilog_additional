module tb_pipo_shift_register;
    reg clk;
    reg reset;
    reg load;
    reg [7:0] parallel_in;
    wire [7:0] parallel_out;

    // Instantiate the PIPO shift register
    Pipo pipo(
        .clk(clk),
        .reset(reset),
        .load(load),
        .parallel_in(parallel_in),
        .parallel_out(parallel_out)
    );
	  initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        load = 0;
        
        parallel_in = 8'b11001100;

        // Release reset
        #5 reset = 0;

        // Load data into PIPO
        load = 1; #10; 
        load = 0; #10;

        // Check output after loading data
        $display("PIPO Output: %b", parallel_out); // Should be 11001100

        // Finish simulation
        $finish;
    end
	 always #5 clk = ~clk; // Clock generation

endmodule
