module push_button(
    input clk,          // Clock signal
    input reset,        // Reset signal
    input button_in,    // Raw button input (may bounce)
    output reg led_out  // LED output toggled by button press
);
    reg [15:0] debounce_counter; // Counter for debouncing
    reg button_stable;           // Stable button signal
    reg button_last;             // Previous stable state

    // Debouncing logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            debounce_counter <= 0;
            button_stable <= 0;
            button_last <= 0;
            led_out <= 0;
        end else begin
            // Increment debounce counter if button is stable
            if (button_in == button_stable) begin
                if (debounce_counter < 16'hFFFF)
                    debounce_counter <= debounce_counter + 1;
            end else begin
                debounce_counter <= 0; // Reset counter if signal changes
            end

            // Update stable signal after counter exceeds threshold
            if (debounce_counter == 16'hFFFF) begin
                button_stable <= button_in;
            end

            // Toggle LED when a stable button press is detected
            if (button_stable && !button_last) begin
                led_out <= ~led_out; // Toggle LED on button press
            end

            // Store the last stable state
            button_last <= button_stable;
        end
    end
endmodule
