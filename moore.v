module Moore(din,clk,reset,y);
input din,clk,reset;
output reg y;
parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100, S5=3'b101, S6=3'b110, S7=3'b111;
reg [2:0] nextState;
always @(posedge clk)
begin
if(reset)
begin
nextState=S0;
y=0;
end
else
begin
case(nextState)
S0:
begin
y=0;
if(din==0)
nextState=S1;
else
nextState=S0;
end
S1:
begin
y=0;
if(din==0)
nextState=S2;
else
nextState=S3;
end

S2:
begin
y=0;
if(din==0)
nextState=S4;
else
nextState=S3;
end

S3:
begin
y=0;
if(din==0)
nextState=S5;
else
nextState=S0;
end

S4:
begin
y=0;
if(din==0)
nextState=S4;
else
nextState=S6;
end
S5:
begin

y=0;
if(din==0)
nextState=S2;
else
nextState=S7;
end

S6:
begin
y=1;
if(din==0)
nextState=S5;
else
nextState=S0;
end

S7:
begin
y=1;
if(din==0)
nextState=S5;
else
nextState=S0;
end
endcase
end
end
endmodule
