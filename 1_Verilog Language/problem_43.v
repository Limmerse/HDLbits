module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum
);

wire [399:0] cout_reg;

bcd_fadd bcd_fadd_inst0 (
    .a      ( a[3:0]        ),
    .b      ( b[3:0]        ),
    .cin    ( cin           ),
    .cout   ( cout_reg[0]   ),
    .sum    ( sum[3:0]      )
);

genvar i;
generate
    for (i = 4; i<400; i = i+4) 
        begin : bcd
            bcd_fadd bcd_fadd_inst0 (
                .a      ( a[i+3:i]      ),
                .b      ( b[i+3:i]      ),
                .cin    ( cout_reg[i-4] ),
                .cout   ( cout_reg[i]   ),
                .sum    ( sum[i+3:i]    )
            );
        end
endgenerate

assign cout = cout_reg[396];

endmodule
