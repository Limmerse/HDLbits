module uart_tx(
    //global clock
    input           clk,
    input           rst_n,
    //uart interface
    output reg      uart_tx,
    //user interface
    input   [31:0]  pinlv,
    input           pinlv_value
);

parameter BPS_9600 = 5208;
//count for bps_clk
reg [14:0] cnt_bps_clk;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt_bps_clk <= 1'b0;
    end else if (pinlv_value == 0) begin
        cnt_bps_clk <= 1'b0;
    end else if (cnt_bps_clk == BPS_9600 - 1) begin
        cnt_bps_clk <= cnt_bps_clk + 1'b1;
    end
end

reg  [31:0] cnt_bps_stop;
wire        stop_done;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt_bps_stop <= 0;
    end else if (state == STOP) begin
        cnt_bps_stop <= 0;
    end else if (cnt_bps_stop > 50_000_00) begin
        cnt_bps_stop <= 0;
    end else
        cnt_bps_stop <= cnt_bps_stop + 1'b1;
end

assign  stop_done = (cnt_bps_stop == 49_000_00) ? 1 : 0;
//clk for bps
reg bps_clk;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        bps_clk <= 1'b0;
    end else if (cnt_bps_clk == 1) begin
        bps_clk <= 1'b1;
    end else
        bps_clk <= 1'b0;
end
//cnt for bps
reg [14:0] bps_cnt;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        bps_cnt <= 1'b0;
    end else if (bps_cnt == 10) begin
        bps_cnt <= 0;
    end else if (bps_clk) begin
        bps_cnt <= bps_cnt + 1'b1;
    end else
        bps_cnt <= bps_cnt;
end
//tx state
localparam IDLE = 4'd0;
localparam TX_1 = 4'd1;
localparam TX_2 = 4'd2;
localparam TX_3 = 4'd3;
localparam TX_4 = 4'd4;
localparam STOP = 4'd5;
localparam STOP_1 = 4'd6;
//cnt state
reg [3:0] state;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        state <= IDLE;
    else if (state == STOP_1 && stop_done)
        state <= IDLE;
    else if (bps_cnt == 10 && (state != STOP_1))    
        state <= state + 1'b1;
end
//state
always @(posedge clk) begin
    if (bps_clk) begin
        case (state)
            IDLE : //'t' l -- h 
                begin
                    case (bps_cnt)
                        4'd0 : uart_tx <= 0; //begin

                        4'd1 : uart_tx <= 0; //data
                        4'd2 : uart_tx <= 0;
                        4'd3 : uart_tx <= 1;
                        4'd4 : uart_tx <= 0;
                        4'd5 : uart_tx <= 1;
                        4'd6 : uart_tx <= 1;
                        4'd7 : uart_tx <= 1;
                        4'd8 : uart_tx <= 0;

                        4'd9 : uart_tx <= 1; //stop
                        default : uart_tx <= 1;
                    endcase
                end
            TX_1 : //tx_1byte
                begin
                    case (bps_cnt)
                        4'd0 : uart_tx <= 0; //begin

                        4'd1 : uart_tx <= pinlv[24]; //data
                        4'd2 : uart_tx <= pinlv[25];
                        4'd3 : uart_tx <= pinlv[26];
                        4'd4 : uart_tx <= pinlv[27];
                        4'd5 : uart_tx <= pinlv[28];
                        4'd6 : uart_tx <= pinlv[29];
                        4'd7 : uart_tx <= pinlv[30];
                        4'd8 : uart_tx <= pinlv[31];

                        4'd9 : uart_tx <= 1; //stop
                        default : uart_tx <= 1;
                    endcase
                end
            TX_2 : //tx_1byte
                begin
                    case (bps_cnt)
                        4'd0 : uart_tx <= 0; //begin

                        4'd1 : uart_tx <= pinlv[16]; //data
                        4'd2 : uart_tx <= pinlv[17];
                        4'd3 : uart_tx <= pinlv[18];
                        4'd4 : uart_tx <= pinlv[19];
                        4'd5 : uart_tx <= pinlv[20];
                        4'd6 : uart_tx <= pinlv[21];
                        4'd7 : uart_tx <= pinlv[22];
                        4'd8 : uart_tx <= pinlv[23];

                        4'd9 : uart_tx <= 1; //stop
                        default : uart_tx <= 1;
                    endcase
                end
            TX_3 :
                begin
                    case (bps_cnt)
                        4'd0 : uart_tx <= 0; //begin

                        4'd1 : uart_tx <= pinlv[ 8]; //data
                        4'd2 : uart_tx <= pinlv[ 9];
                        4'd3 : uart_tx <= pinlv[10];
                        4'd4 : uart_tx <= pinlv[11];
                        4'd5 : uart_tx <= pinlv[12];
                        4'd6 : uart_tx <= pinlv[13];
                        4'd7 : uart_tx <= pinlv[14];
                        4'd8 : uart_tx <= pinlv[15];

                        4'd9 : uart_tx <= 1; //stop
                        default : uart_tx <= 1;
                    endcase
                end
            TX_4 :
                begin
                    case (bps_cnt)
                        4'd0 : uart_tx <= 0; //begin

                        4'd1 : uart_tx <= pinlv[0]; //data
                        4'd2 : uart_tx <= pinlv[1];
                        4'd3 : uart_tx <= pinlv[2];
                        4'd4 : uart_tx <= pinlv[3];
                        4'd5 : uart_tx <= pinlv[4];
                        4'd6 : uart_tx <= pinlv[5];
                        4'd7 : uart_tx <= pinlv[6];
                        4'd8 : uart_tx <= pinlv[7];

                        4'd9 : uart_tx <= 1; //stop
                        default : uart_tx <= 1;
                    endcase
                end
            STOP :
                begin
                    case (bps_cnt)
                        4'd0 : uart_tx <= 0; //begin

                        4'd1 : uart_tx <= pinlv[0]; //data
                        4'd2 : uart_tx <= pinlv[0];
                        4'd3 : uart_tx <= pinlv[0];
                        4'd4 : uart_tx <= pinlv[1];
                        4'd5 : uart_tx <= pinlv[1];
                        4'd6 : uart_tx <= pinlv[1];
                        4'd7 : uart_tx <= pinlv[1];
                        4'd8 : uart_tx <= pinlv[0];

                        4'd9 : uart_tx <= 1; //stop
                        default : uart_tx <= 1;
                    endcase
                end
            STOP_1 :
                begin
                    uart_tx <= 1;
                end
            default : uart_tx <= 1;
        endcase
    end 
    else
        uart_tx <= uart_tx;
end

endmodule