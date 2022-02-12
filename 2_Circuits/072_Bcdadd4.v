module top_module( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum 
);

wire [4:0] c_temp;

assign c_temp[0] = cin;
assign cout = c_temp[4];

generate
    genvar i;
    for (i = 0; i < 4; i = i+1) begin : adders
        bcd_fadd u_bcd_fadd (
            .a          (a[i*4+3 -: 4]  ), 
            .b          (b[i*4+3 -: 4]  ), 
            .cin        (c_temp[i]      ), 
            .cout       (c_temp[i+1]    ), 
            .sum        (sum[i*4+3 -: 4])
        );
    end
endgenerate

endmodule