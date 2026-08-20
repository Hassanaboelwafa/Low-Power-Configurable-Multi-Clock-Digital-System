module UART_RX_Start_Check #(parameter START_BIT = 0)
(
    input           strt_chk_en,
    input           sampled_bit,
    input           CLK,RST,
    output  reg     strt_glitch    

);

wire strt_glitch_comp;

assign strt_glitch_comp = (sampled_bit != START_BIT );


always @(posedge CLK or negedge RST) begin

    if (!RST) begin
        strt_glitch <= 1'b0;
    end
    else begin
        if (strt_chk_en)
            strt_glitch <= strt_glitch_comp;
    end

end

endmodule