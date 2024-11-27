module Pipo(
    input clk,
    input reset,
    input load,
    input [7:0] parallel_in,
    output reg [7:0] parallel_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            parallel_out <= 8'b0; // Reset output
        end else if (load) begin
            parallel_out <= parallel_in; // Load parallel data directly to output
        end 
        // No shifting in PIPO mode, just loading data.
    end
endmodule
