module fibonacci_gen (
    input clk,
    input reset,
    output reg [31:0] fib
);
    reg [31:0] a, b;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            a <= 0;
            b <= 1;
            fib <= 0;
        end else begin
            fib <= a + b;
            a <= b;
            b <= fib;
        end
    end
endmodule
