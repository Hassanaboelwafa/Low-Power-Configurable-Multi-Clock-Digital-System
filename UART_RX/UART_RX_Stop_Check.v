module UART_RX_Stop_Check #(parameter STOP_BIT = 1)
(
    input           stp_chk_en,
    input           sampled_bit,
    input           CLK,RST,
    output  reg     stp_err    

);

wire stp_err_comp;

assign stp_err_comp = (sampled_bit != STOP_BIT );


always @(posedge CLK or negedge RST) begin

    if (!RST) begin
        stp_err <= 1'b0;
    end
    else begin
        if (stp_chk_en )
            stp_err <= stp_err_comp;
    end

end

endmodule