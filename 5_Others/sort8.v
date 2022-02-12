/*
//给定8个数，以及若干二输入比较器。
//要求在单周期内实现8个数的排序，
//并使用最好的比较器个数。
*/
module sort8 #(
    parameter DW = 8
)(
    input       [DW-1:0]    i_d0,
    input       [DW-1:0]    i_d1,
    input       [DW-1:0]    i_d2,
    input       [DW-1:0]    i_d3,
    input       [DW-1:0]    i_d4,
    input       [DW-1:0]    i_d5,
    input       [DW-1:0]    i_d6,
    input       [DW-1:0]    i_d7,

    output reg  [DW-1:0]    o_d0,
    output reg  [DW-1:0]    o_d1,
    output reg  [DW-1:0]    o_d2,
    output reg  [DW-1:0]    o_d3,
    output reg  [DW-1:0]    o_d4,
    output reg  [DW-1:0]    o_d5,
    output reg  [DW-1:0]    o_d6,
    output reg  [DW-1:0]    o_d7
);

function [DW*2-1:0] max;
    input [DW-1:0]  data0;
    input [DW-1:0]  data1;
    begin
        max = data0 <= data1 ? {data1, data0} : {data0, data1};
    end
endfunction

function [DW*4-1:0] max_4;
    input   [DW-1:0] d0;
    input   [DW-1:0] d1;
    input   [DW-1:0] d2;
    input   [DW-1:0] d3;

    reg     [DW-1:0] r0;
    reg     [DW-1:0] r1;
    reg     [DW-1:0] r2;
    reg     [DW-1:0] r3;
    reg     [DW-1:0] r4;
    reg     [DW-1:0] r5;
    reg     [DW-1:0] r6;
    reg     [DW-1:0] r7;
    reg     [DW-1:0] r8;
    reg     [DW-1:0] r9;

    begin
        {r0,r1} = max(d0,d1);
        {r2,r3} = max(d2,d3);
        {r4,r5} = max(r0,r2);
        {r6,r7} = max(r1,r3);
        {r8,r9} = max(r6,r5);
        max_4 = {r4, r8, r9, r7};
    end
endfunction

// reg [DW*4-1:0]  max_4_r;
// always @(*) begin
//     max_4_r = max_4(i_d0, i_d1, i_d2, i_d3);
// end

// assign o_d0 = max_4_r[ 7: 0];
// assign o_d1 = max_4_r[15: 8];
// assign o_d2 = max_4_r[23:16];
// assign o_d3 = max_4_r[31:24];

//8输入比较
reg [DW-1:0] m0, m1, m2, m3, m4, m5, m6, m7, m8, m9;
reg [DW-1:0] m10, m11, m12, m13, m14, m15, m16, m17, m18, m19;

always @(*) begin
    {m0, m1, m2, m3} = max_4 (i_d0, i_d1, i_d2, i_d3);
    {m4, m5, m6, m7} = max_4 (i_d4, i_d5, i_d6, i_d7);
    {m8, m9, m10, m11} = max_4 (m0, m1, m4, m5);
    {m12, m13, m14, m15} = max_4 (m2, m3, m6, m7);
    {m16, m17, m18, m19} = max_4 (m10, m11, m12, m13);

    o_d0 = m15;
    o_d1 = m14;
    o_d2 = m19;
    o_d3 = m18;
    o_d4 = m17;
    o_d5 = m16;
    o_d6 = m9;
    o_d7 = m8;
end

endmodule