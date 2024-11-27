module Sipo (
    input clk,
    input reset,
    input serial_in,
    output reg [7:0] parallel_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            parallel_out <= 8'b0; // Reset output
        end else begin
            parallel_out <= {parallel_out[6:0], serial_in}; // Shift left and input new bit
        end
    end
endmodule
