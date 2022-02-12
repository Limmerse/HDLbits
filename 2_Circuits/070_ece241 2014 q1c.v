module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //

    // assign s = ...
    // assign overflow = ...
//先做符号位拓展，然后进位位和最高位做异或运算
wire [8:0] t;
assign t = {a[7], a} + {b[7], b};
assign s = t[7:0];
assign overflow = t[8] ^ t[7];

endmodule