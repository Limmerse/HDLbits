module top_module (
    input x, 
    input y, 
    output z
);

reg [3:0] z_reg;

task A;
    input x, y;
    output z;
    begin
        z = (x ^ y) & x;
    end
endtask

task B;
    input x, y;
    output z;   
    begin
        z = x ^ ~y;
    end
endtask

always @(*) begin
    A(x, y, z_reg[0]);
    B(x, y, z_reg[1]);
    A(x, y, z_reg[2]);
    B(x, y, z_reg[3]);
end

assign z = (z_reg[0] | z_reg[1]) ^ (z_reg[2] & z_reg[3]);

endmodule
