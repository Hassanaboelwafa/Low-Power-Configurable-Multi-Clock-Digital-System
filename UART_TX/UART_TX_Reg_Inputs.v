module UART_TX_Reg_Inputs #(parameter DATA_WIDTH = 8)
(  
    input       [DATA_WIDTH-1:0]    P_DATA,
    input                           DATA_VALID,
    input                           PAR_EN,
    input                           PAR_TYP,
    input                           CLK,RST,
    input                           Busy,
    output  reg [DATA_WIDTH-1:0]    P_DATA_reg,
    output  reg                     PAR_EN_reg,
    output  reg                     PAR_TYP_reg
);

   
//the reg inputs contains the registers that lock on the P_DATA, PAR_TYP and PAR_EN values
// and does not allow any value to replace them until the busy signal is off and data valid signal became high again 
always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        P_DATA_reg <= 'b0; 
        PAR_EN_reg <= 'b0;
        PAR_TYP_reg <= 'b0;
    end
    else begin
        if (DATA_VALID && !Busy) begin
            P_DATA_reg <= P_DATA; 
            PAR_EN_reg <= PAR_EN;
            PAR_TYP_reg <= PAR_TYP;
        end
    end
end
endmodule