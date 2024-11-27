module test_simple_risc_proc;
    reg clk;              // Clock signal
    reg reset;            // Reset signal
    reg [15:0] instr;     // Instruction
    wire [15:0] result;   // Result of the operation
    wire [15:0] regA;     // Register A
    wire [15:0] regB;     // Register B

    // Instantiate the processor
    simple_risc_proc uut (
        .clk(clk),
        .reset(reset),
        .instr(instr),
        .result(result),
        .regA(regA),
        .regB(regB)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units clock period
    end

    // Test sequence
    initial begin
        // Monitor signals
        $monitor("Time: %0t | Reset: %b | Instr: %b | Opcode: %b | Operand1: %b | Operand2: %b | Result: %b",
                 $time, reset, instr, instr[15:12], instr[11:6], instr[5:0], result);

        // Initialize
        reset = 1;
        #10; // Wait for reset to propagate

        reset = 0;

        // Test ADD: 5 + 3 = 8
        instr = {4'b0001, 6'd5, 6'd3}; // Opcode: ADD, Operand1: 5, Operand2: 3
        #10;

        // Test SUB: 10 - 7 = 3
        instr = {4'b0010, 6'd10, 6'd7}; // Opcode: SUB, Operand1: 10, Operand2: 7
        #10;

        // Test MUL: 4 * 2 = 8
        instr = {4'b0011, 6'd4, 6'd2}; // Opcode: MUL, Operand1: 4, Operand2: 2
        #10;

        // Test DIV: 9 / 3 = 3
        instr = {4'b0100, 6'd9, 6'd3}; // Opcode: DIV, Operand1: 9, Operand2: 3
        #10;

        // Test DIV by zero: 5 / 0 = 16'hFFFF (Error)
        instr = {4'b0100, 6'd5, 6'd0}; // Opcode: DIV, Operand1: 5, Operand2: 0
        #10;

        $stop; // End simulation
    end
endmodule
