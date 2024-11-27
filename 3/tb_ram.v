module tb_RAM;
    reg clk;                   // Clock signal for synchronization
    reg RW;                    // Read/Write signal
    reg [3:0] address;         // Address signal
    reg [7:0] datain;          // Data input
    wire [7:0] dataout;        // Data output

    // Instantiate the RAM module with the clock input
    RAM uut (
        .clk(clk), 
        .RW(RW), 
        .address(address), 
        .datain(datain), 
        .dataout(dataout)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // Toggle clock every 5 time units
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0; RW = 0; address = 4'b0000; datain = 8'b11111111;
        
        // Open dump file for waveform output
        $dumpfile("RAM.vcd");
        $dumpvars(0, test_RAM);
        
        // Monitor output
        $monitor("At time %t: dataout = %b", $time, dataout);

        // Write operations (on rising clock edge)
        #10 RW = 1; address = 4'b0000; datain = 8'b11111111;  // Write data to address 0
        #10 RW = 1; address = 4'b0001; datain = 8'b11111000;  // Write data to address 1
        #10 RW = 0; address = 4'b0000; datain = 8'b00000000;  // Read from address 0 (output should be 11111111)
        #10 RW = 0; address = 4'b0001; datain = 8'b00000000;  // Read from address 1 (output should be 11111000)
        #10 RW = 1; address = 4'b0000; datain = 8'b00000001;  // Write new data to address 0
        #10 RW = 0; address = 4'b0000; datain = 8'b00000000;  // Read from address 0 (output should be 00000001)
        
        #20 $finish;  // End simulation after a period of time
    end
endmodule
