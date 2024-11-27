module test_comparator_8bit;
    reg [7:0] a, b;
    wire equal, greater, less;

    comparator_8bit uut (
        .a(a),
        .b(b),
        .equal(equal),
        .greater(greater),
        .less(less)
    );

    initial begin
        // Test case 1: a = 8'b11001100, b = 8'b11001100 (Equal)
        a = 8'b11001100;
        b = 8'b11001100;
        #10;
        $display("a = %b, b = %b | Equal: %b, Greater: %b, Less: %b", a, b, equal, greater, less);

        // Test case 2: a = 8'b11100000, b = 8'b11001100 (Greater)
        a = 8'b11100000;
        b = 8'b11001100;
        #10;
        $display("a = %b, b = %b | Equal: %b, Greater: %b, Less: %b", a, b, equal, greater, less);

        // Test case 3: a = 8'b10101010, b = 8'b11001100 (Less)
        a = 8'b10101010;
        b = 8'b11001100;
        #10;
        $display("a = %b, b = %b | Equal: %b, Greater: %b, Less: %b", a, b, equal, greater, less);
        
        // Test case 4: a = 8'b11111111, b = 8'b00000000 (Greater)
        a = 8'b11111111;
        b = 8'b00000000;
        #10;
        $display("a = %b, b = %b | Equal: %b, Greater: %b, Less: %b", a, b, equal, greater, less);

        $stop;
    end
endmodule
