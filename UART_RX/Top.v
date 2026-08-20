module Top #(   parameter DATA_WIDTH = 8,
                parameter START_BIT = 0,
                parameter STOP_BIT = 1)
(
    input                           CLK,RST,
    input                           RX_IN,
    input                           PAR_EN,
    input             [5:0]         Prescale,
    input                           PAR_TYP,
    output                          DATA_VALID,
    output                          Parity_Error,
    output                          Stop_Error,
    output     [DATA_WIDTH-1:0]     P_DATA   
);
    wire            enable;
    wire    [3:0]   bit_cnt;
    wire            bit_done;
    wire    [4:0]   edge_cnt;
    wire            sampled_bit;
    wire            strt_glitch;
    wire            par_err;
    wire            stp_err;
    wire            par_chk_en;
    wire            par_save_bit;
    wire            count_rst;
    wire            strt_chk_en;
    wire            stp_chk_en;
    wire            deser_en;
    wire            data_samp_en;
    
    
UART_RX_FSM FSM
(
    .RX_IN(RX_IN),
    .CLK(CLK),
    .RST(RST),
    .PAR_EN(PAR_EN),
    .enable(enable),
    .bit_cnt(bit_cnt),
    .bit_done(bit_done),
    .strt_glitch(strt_glitch),
    .par_err(par_err),
    .stp_err(stp_err),
    .par_chk_en(par_chk_en),
    .par_save_bit(par_save_bit),
    .count_rst(count_rst),
    .strt_chk_en(strt_chk_en),
    .stp_chk_en(stp_chk_en),
    .deser_en(deser_en),
    .data_samp_en(data_samp_en),
    .DATA_VALID(DATA_VALID),
    .Parity_Error(Parity_Error),
    .Stop_Error(Stop_Error)
);

UART_RX_Edge_Bit_Counter  Edge_Counter
(
    .enable(enable),
    .count_rst(count_rst),
    .Prescale(Prescale),
    .CLK(CLK),
    .RST(RST),
    .bit_cnt(bit_cnt),
    .edge_cnt(edge_cnt),
    .bit_done(bit_done)
);

UART_RX_Data_Sampling Data_Sampler
(
    .data_samp_en(data_samp_en),
    .RX_IN(RX_IN),
    .Prescale(Prescale),
    .CLK(CLK),
    .RST(RST),
    .edge_cnt(edge_cnt),
    .sampled_bit(sampled_bit)
);

UART_RX_Deserializer Deserializer
(
    .sampled_bit(sampled_bit),
    .deser_en(deser_en),
    .bit_cnt(bit_cnt),
    .bit_done(bit_done),
    .CLK(CLK),
    .RST(RST),
    .P_DATA(P_DATA)
);

UART_RX_Parity_Check Parity_Checker
(
    .par_chk_en(par_chk_en),
    .par_save_bit(par_save_bit),
    .sampled_bit(sampled_bit),
    .bit_done(bit_done),
    .PAR_TYP(PAR_TYP),
    .CLK(CLK),
    .RST(RST),
    .par_err(par_err)    
);

UART_RX_Start_Check Start_Checker
(
    .strt_chk_en(strt_chk_en),
    .sampled_bit(sampled_bit),
    .CLK(CLK),
    .RST(RST),
    .strt_glitch(strt_glitch)  
);

UART_RX_Stop_Check Stop_Checker
(
    .stp_chk_en(stp_chk_en),
    .sampled_bit(sampled_bit),
    .CLK(CLK),
    .RST(RST),
    .stp_err(stp_err)    
);
endmodule