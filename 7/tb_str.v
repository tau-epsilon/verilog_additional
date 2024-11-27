module test_string_concat;
    reg [63:0] str1; // Input string 1
    reg [63:0] str2; // Input string 2
    wire [127:0] result; // Concatenated result

    // Instantiate the string_concat module
    string_concat uut (
        .str1(str1),
        .str2(str2),
        .result(result)
    );

    initial begin
        // Initialize strings
        str1 = "Hello,  ";
        str2 = "World!";
        
        // Wait for result
        #10;
        
        // Display results
        $display("String 1: %s", str1);
        $display("String 2: %s", str2);
        $display("Concatenated Result: %s", result);
        
        $stop;
    end
endmodule
