reg [7:0] memory [0:7];  // 8 locations of 8-bit memory

    // Asynchronous read
    always @ (*) begin
        if (RW == 0) begin
            dataout = memory[address];  // Read from memory
        end
    end

    // Synchronous write (on positive clock edge)
    always @ (posedge clk) begin
        if (RW == 1) begin
            memory[address] = datain;  // Write to memory
        end
    end
endmodule
