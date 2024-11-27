module string_concat (
    input [63:0] str1, // 8 characters
    input [63:0] str2, // 8 characters
    output reg [127:0] result // 16 characters
);
    always @(*) begin
        result = {str1, str2}; // Concatenate str1 and str2
    end
endmodule
