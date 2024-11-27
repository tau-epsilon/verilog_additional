module simple_risc_proc (
    input clk,             // Clock signal
    input reset,           // Reset signal
    input [15:0] instr,    // 16-bit instruction
    output reg [15:0] result, // Result of the operation
    output reg [15:0] regA,  // Register A
    output reg [15:0] regB   // Register B
);
    // Opcode definitions
    parameter ADD = 4'b0001;
    parameter SUB = 4'b0010;
    parameter MUL = 4'b0011;
    parameter DIV = 4'b0100;

    reg [3:0] opcode;       // 4-bit opcode
    reg [15:0] operand1;    // First operand
    reg [15:0] operand2;    // Second operand

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset registers
            regA <= 16'b0;
            regB <= 16'b0;
            result <= 16'b0;
        end else begin
            // Decode instruction
            opcode <= instr[15:12]; // High 4 bits are opcode
            operand1 <= instr[11:6]; // Next 6 bits are operand1
            operand2 <= instr[5:0];  // Last 6 bits are operand2

            // Execute instruction
            case (opcode)
                ADD: result <= operand1 + operand2; // Addition
                SUB: result <= operand1 - operand2; // Subtraction
                MUL: result <= operand1 * operand2; // Multiplication
                DIV: result <= (operand2 != 0) ? operand1 / operand2 : 16'hFFFF; // Division, avoid divide-by-zero
                default: result <= 16'h0000; // Default result
            endcase

            // Store operands for reference
            regA <= operand1;
            regB <= operand2;
        end
    end
endmodule
