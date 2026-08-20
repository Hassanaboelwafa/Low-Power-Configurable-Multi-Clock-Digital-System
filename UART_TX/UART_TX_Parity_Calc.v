module Parity_Calc #(parameter DATA_WIDTH = 8)
(
    input [DATA_WIDTH-1:0]  P_DATA,
    input                   PAR_TYP,
    output  reg             Par_Bit
);

always @(*) begin
    if (PAR_TYP) 
        Par_Bit = ^ P_DATA;
    else 
        Par_Bit = ~^ P_DATA;

    end
endmodule