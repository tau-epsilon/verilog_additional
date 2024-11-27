module test_fibonacci_gen;
    reg clk;
    reg reset;
    wire [31:0] fib;

    fibonacci_gen uut (
        .clk(clk),
        .reset(reset),
        .fib(fib)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1; #10;
        reset = 0; #200;
        $stop;
    end
endmodule
