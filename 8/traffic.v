module traffic_light(
    input clk,            // Clock signal
    input reset,          // Reset signal
    output reg [2:0] light // 3-bit output: [Red, Yellow, Green]
);
    // Define state encoding
    parameter RED = 3'b100;
    parameter YELLOW = 3'b010;
    parameter GREEN = 3'b001;

    reg [1:0] state; // State register: 2 bits to represent 3 states

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // Reset to RED state
        end else begin
            case (state)
                2'b00: state <= 2'b01; // RED -> GREEN
                2'b01: state <= 2'b10; // GREEN -> YELLOW
                2'b10: state <= 2'b00; // YELLOW -> RED
                default: state <= 2'b00; // Default to RED
            endcase
        end
    end

    // Output logic based on state
    always @(*) begin
        case (state)
            2'b00: light = RED;    // RED
            2'b01: light = GREEN;  // GREEN
            2'b10: light = YELLOW; // YELLOW
            default: light = RED;  // Default to RED
        endcase
    end
endmodule
