module UART_TX_MUX #(   parameter START_BIT = 1'b0,
                        parameter STOP_BIT  = 1'b1)
(
    input   [1:0]   MUX_Sel,
    input           Ser_Data,
    input           Par_Bit,
    input           Busy,
    input           DATA_VALID,
    output  reg     TX_OUT
);


always @(*) begin

    
    if (!DATA_VALID && !Busy)
        TX_OUT = 'b1;

    else begin
    case(MUX_Sel)
    2'b00: TX_OUT = START_BIT;
    2'b01: TX_OUT = Ser_Data;
    2'b10: TX_OUT = Par_Bit;
    2'b11: TX_OUT = STOP_BIT;
    endcase
    end
end
endmodule