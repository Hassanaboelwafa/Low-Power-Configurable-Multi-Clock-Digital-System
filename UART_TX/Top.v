module Top #(parameter DATA_WIDTH = 8)
(  
    input [DATA_WIDTH-1:0]  P_DATA,
    input                   DATA_VALID,
    input                   PAR_EN,
    input                   PAR_TYP,
    input                   CLK,RST,
    output                  TX_OUT,
    output                  Busy
);


wire Ser_En, Ser_Done, Ser_Data;
wire [1:0] MUX_Sel;
wire Par_Bit;

wire [DATA_WIDTH-1:0] P_DATA_reg;
wire                  PAR_EN_reg;
wire                  PAR_TYP_reg;

UART_TX_Reg_Inputs reg_inputs 
(
    .P_DATA(P_DATA),
    .DATA_VALID(DATA_VALID),
    .PAR_EN(PAR_EN),
    .PAR_TYP(PAR_TYP),
    .Busy(Busy),
    .CLK(CLK),
    .RST(RST),
    .P_DATA_reg(P_DATA_reg),
    .PAR_EN_reg(PAR_EN_reg),
    .PAR_TYP_reg(PAR_TYP_reg)
);

Serializer Serial_Data
(
    .P_DATA(P_DATA_reg),
    .Ser_En(Ser_En),
    .CLK(CLK),
    .RST(RST),
    .Ser_Done(Ser_Done),
    .Ser_Data(Ser_Data)
);

Parity_Calc Parity
(
    .P_DATA(P_DATA_reg),
    .PAR_TYP(PAR_TYP_reg),
    .Par_Bit(Par_Bit)
);

UART_TX_FSM FSM
(
    .DATA_VALID(DATA_VALID),
    .PAR_EN(PAR_EN_reg),
    .Ser_En(Ser_En),
    .Ser_Done(Ser_Done),
    .CLK(CLK),
    .RST(RST),
    .MUX_Sel(MUX_Sel),
    .Busy(Busy)
);

UART_TX_MUX MUX
(
    .MUX_Sel(MUX_Sel),
    .Ser_Data(Ser_Data),
    .Busy(Busy),
    .DATA_VALID(DATA_VALID),
    .Par_Bit(Par_Bit),
    .TX_OUT(TX_OUT)
);
endmodule 