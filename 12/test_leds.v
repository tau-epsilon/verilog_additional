module test_led_blink;
    reg clk;
    reg [1:0] speed;
    wire led;

    led_blink uut (
        .clk(clk),
        .speed(speed),
        .led(led)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        speed = 2'b00; #1000;
        speed = 2'b01; #1000;
        speed = 2'b10; #1000;
        speed = 2'b11; #1000;
        $stop;
    end
endmodule
