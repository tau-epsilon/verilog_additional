module mealy_fsm_counter (
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

    // Output Logic (Mealy FSM)
    always @(state) begin
        if (state == 2'b10) // If the state is 10 (binary 2), output 1
            out = 1;
        else
            out = 0;  // Otherwise, output 0
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
