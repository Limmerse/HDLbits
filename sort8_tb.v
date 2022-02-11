
module sort8_tst();

reg [8-1:0] i_d0 ;
reg [8-1:0] i_d1 ;
reg [8-1:0] i_d2 ;
reg [8-1:0] i_d3 ;
reg [8-1:0] i_d4 ;
reg [8-1:0] i_d5 ;
reg [8-1:0] i_d6 ;
reg [8-1:0] i_d7 ;
wire [8-1:0]o_d0 ;
wire [8-1:0]o_d1 ;
wire [8-1:0]o_d2 ;
wire [8-1:0]o_d3 ;
wire [8-1:0]o_d4 ;
wire [8-1:0]o_d5 ;
wire [8-1:0]o_d6 ;
wire [8-1:0]o_d7 ;

sort8 U_sort8(
.i_d0(i_d0),
.i_d1(i_d1),
.i_d2(i_d2),
.i_d3(i_d3),
.i_d4(i_d4),
.i_d5(i_d5),
.i_d6(i_d6),
.i_d7(i_d7),
.o_d0(o_d0),
.o_d1(o_d1),
.o_d2(o_d2),
.o_d3(o_d3),
.o_d4(o_d4),
.o_d5(o_d5),
.o_d6(o_d6),
.o_d7(o_d7)
);

initial
begin
i_d0=8'd23;
i_d1=8'd87;
i_d2=8'd3;
i_d3=8'd76;
i_d4=8'd1;
i_d5=8'd2;
i_d6=8'd3;
i_d7=8'd4;
end

endmodule