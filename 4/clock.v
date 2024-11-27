module clockgenerator(clkin,clkout,sel);
input clkin;
input [2:0] sel;
output reg clkout;
reg [4:0]count=5'd0;
always @(posedge clkin)
count=count+1;
always @(clkin or sel)
case(sel)
3'b000:clkout=0;
3'b001:clkout=clkin;
3'b010:clkout=count[0];
3'b011:clkout=count[1];
3'b100:clkout=count[2];
3'b101:clkout=count[3];
3'b110:clkout=count[4];
3'b111:clkout=1;
endcase
endmodule
