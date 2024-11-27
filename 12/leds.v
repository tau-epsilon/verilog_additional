module led_blink (
    input clk,
    input [1:0] speed,
    output reg led
);
    reg [31:0] counter;

    always @(posedge clk) begin
        counter <= counter + 1;
        case (speed)
            2'b00: led <= counter[23];
            2'b01: led <= counter[25];
            2'b10: led <= counter[27];
            2'b11: led <= counter[29];
        endcase
    end
endmodule
