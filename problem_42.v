module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum
);

reg [99:0]  cout_reg;
reg [99:0]  sum_reg;

integer i;
always @(*) begin
    cout_reg = 0;
    sum_reg  = 0;
    {cout_reg[0], sum_reg[0]} = a[0] + b[0] + cin;
    for (i = 1; i < 100; i = i+1) begin
        {cout_reg[i], sum_reg[i]} = a[i] + b[i] + cout_reg[i-1];
    end
end

assign cout = cout_reg;
assign sum  = sum_reg;

endmodule
