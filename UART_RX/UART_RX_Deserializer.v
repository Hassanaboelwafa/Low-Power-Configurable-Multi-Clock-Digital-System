module UART_RX_Deserializer #(parameter DATA_WIDTH = 8)
(
    input                           sampled_bit,
    input                           deser_en,
    input       [3:0]               bit_cnt,
    input                           bit_done,
    input                           CLK,RST,
    output  reg [DATA_WIDTH-1:0]    P_DATA
);

always @(posedge CLK or negedge RST) begin

    if (!RST) begin
        P_DATA <= 1'b0;
    end
    else begin
        //saving the bits sampled into there corresponding bit to be read parallel
        if (deser_en && bit_done && |bit_cnt)
            P_DATA [bit_cnt-1] <= sampled_bit;
    end

end


endmodule