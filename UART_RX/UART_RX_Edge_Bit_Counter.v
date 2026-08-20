module UART_RX_Edge_Bit_Counter #(parameter DATA_WIDTH = 8)
(
    input                           enable,
    input           [5:0]           Prescale,
    input                           count_rst,

    input                           CLK,RST,
    output  reg     [3:0]           bit_cnt,
    output  reg     [4:0]           edge_cnt,
    output                          bit_done
);

    reg     [3:0]           bit_cnt_comp;
    reg     [4:0]           edge_cnt_comp;
    reg     [4:0]           clock_edge_cnt;

always @(posedge CLK or negedge RST) begin

    if (!RST) begin
        bit_cnt <= 4'b0;
        edge_cnt <= 6'b0;
    end
    else begin
        bit_cnt <= bit_cnt_comp;
        edge_cnt <= edge_cnt_comp;
    end

end

always @(posedge CLK or negedge RST) begin

    //using a counter to observe clock edges and then calculate bit_cnt and edge_cnt according to it
    if (!RST) begin
        clock_edge_cnt <= 4'b0;
    end else begin
     if (enable)
        clock_edge_cnt <= clock_edge_cnt + 1'b1;
    else
        clock_edge_cnt <= 6'b0 ;
    end

end
always @(*) begin
    
    //using enable signal and prescale to choose when to increment the edge value 
    //as prescale give longer period the edge transtion become slower and sampling of the middle bits
    //become further from each other but still the negedge RX_IN signal is sampled
    //as clock_edge_cnt[1:0] reaches 2'b11 for prescale 8 the edge_cnt increment which give quarter the freq of the main clk
    //as clock_edge_cnt[0] toggles for prescale 16 the edge_cnt increment which give half the freq of the main clk
    //as for prescale 32 the edge_cnt increment with every clock edge which give 1 to 1 ratio to the freq of the main clk
    if (enable) begin
        case (Prescale)
            6'd4: begin
                edge_cnt_comp = ( &clock_edge_cnt [2:0] )? edge_cnt + 1'b1: edge_cnt;
            end

            6'd8: begin
                edge_cnt_comp = ( &clock_edge_cnt [1:0] )? edge_cnt + 1'b1: edge_cnt;
            end

            6'd16: begin
                edge_cnt_comp = ( clock_edge_cnt [0] )? edge_cnt + 1'b1: edge_cnt;
            end

            6'd32: begin 
                edge_cnt_comp = clock_edge_cnt + 1'b1;
            end
            default: edge_cnt_comp = 4'b0;
        endcase
    end
    else
        edge_cnt_comp = 4'b0;
end

//bit_cnt incremnt as clock_edge_cnt reaches 32 and reset if count_rst is asserted
always @(*) begin
    if ( (bit_cnt == 4'd11) | count_rst ) begin
        bit_cnt_comp = 4'b0 ;
    end
    else if (enable) begin
        bit_cnt_comp = ( &clock_edge_cnt [4:0] )? bit_cnt + 1'b1: bit_cnt;
    end
    else
        bit_cnt_comp = 4'b0;
end

//bit_done send on  clock cycle signal that indicates the end of the bit and that the data is ready to be used
assign bit_done = ( &clock_edge_cnt [4:0] ) ;

endmodule