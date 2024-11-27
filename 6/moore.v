module moore_fsm_counter (
    input clk,       // Clock signal
    input reset,     // Reset signal
    output reg out   // Output signal (1 bit)
);
    // Declare 2-bit state
    reg [1:0] state, next_state;  // 2-bit state register

    // State Transition Logic (Next-State Logic)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00;  // Reset to state 00
        else
            state <= next_state; // Transition to the next state
    end

    // Output Logic (Moore FSM)
    always @(state) begin
        case (state)
            2'b00: out = 0;  // State 00 -> Output is 0
            2'b01: out = 0;  // State 01 -> Output is 0
            2'b10: out = 1;  // State 10 -> Output is 1
            2'b11: out = 0;  // State 11 -> Output is 0
            default: out = 0; // Default case
        endcase
    end

    // Next-State Logic
    always @(state) begin
        case (state)
            2'b00: next_state = 2'b01; // From state 00 -> 01
            2'b01: next_state = 2'b10; // From state 01 -> 10
            2'b10: next_state = 2'b11; // From state 10 -> 11
            2'b11: next_state = 2'b00; // From state 11 -> 00 (wrap around)
            default: next_state = 2'b00; // Default case
        endcase
    end
endmodule
