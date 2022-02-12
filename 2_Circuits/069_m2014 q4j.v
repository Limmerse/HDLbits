module top_module (
    input [3:0] x,
    input [3:0] y, 
    output reg [4:0] sum
);

integer i;
reg [3:0] cout;

always @(*) begin
    sum[0] = x[0] ^ y[0];
    cout[0] = x[0] & y[0];
    for (i = 1; i < 4; i = i+1) begin
        sum[i] = x[i] ^ y[i] ^ cout[i-1];
        cout[i] = x[i] & y[i] | x[i] & cout[i-1] | y[i] & cout[i-1]; 
    end
    sum[4] = cout[3];
end

// This circuit is a 4-bit ripple-carry adder with carry-out.
	// assign sum = x+y;	// Verilog addition automatically produces the carry-out bit.

	// Verilog quirk: Even though the value of (x+y) includes the carry-out, (x+y) is still considered to be a 4-bit number (The max width of the two operands).
	// This is correct:
	// assign sum = (x+y);
	// But this is incorrect:
	// assign sum = {x+y};	// Concatenation operator: This discards the carry-out

endmodule