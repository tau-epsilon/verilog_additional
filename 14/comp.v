module comparator_4bit (
    input [3:0] a, 
    input [3:0] b, 
    output reg equal,
    output reg greater,
    output reg less
);
    always @(*) begin
        if (a == b) begin
            equal = 1;
            greater = 0;
            less = 0;
        end else if (a > b) begin
            equal = 0;
            greater = 1;
            less = 0;
        end else begin
            equal = 0;
            greater = 0;
            less = 1;
        end
    end
endmodule

module comparator_8bit (
    input [7:0] a, 
    input [7:0] b,
    output equal,
    output greater,
    output less
);
    wire equal_high, equal_low;
    wire greater_high, greater_low;
    wire less_high, less_low;

    // 4-bit comparators for the high and low 4 bits
    comparator_4bit cmp_high (
        .a(a[7:4]), 
        .b(b[7:4]), 
        .equal(equal_high), 
        .greater(greater_high), 
        .less(less_high)
    );
    
    comparator_4bit cmp_low (
        .a(a[3:0]), 
        .b(b[3:0]), 
        .equal(equal_low), 
        .greater(greater_low), 
        .less(less_low)
    );
    
    // Logic to combine the results of the 4-bit comparators
    assign equal = equal_high && equal_low;
    assign greater = greater_high || (equal_high && greater_low);
    assign less = less_high || (equal_high && less_low);
    
endmodule
