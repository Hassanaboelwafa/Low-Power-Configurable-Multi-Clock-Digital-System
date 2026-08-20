module UART_RX_FSM 
(
    input                           RX_IN,
    input                           CLK,RST,
    input                           PAR_EN,
    input                   [3:0]   bit_cnt,
    input                           bit_done,
    input                           strt_glitch,
    input                           par_err,
    input                           stp_err,
    output          reg             enable,
    output          reg             par_chk_en,
    output          reg             count_rst,  // to reset bit counter in stop and idle states
    output          reg             par_save_bit, // to allow the parity bit to know when the parity bit is being recived
    output          reg             strt_chk_en,
    output          reg             stp_chk_en,
    output          reg             deser_en,
    output          reg             data_samp_en,
    output          reg             DATA_VALID,
    output                          Parity_Error,
    output                          Stop_Error


);

typedef enum reg [2:0] 
{
    IDLE_STATE = 3'b000,
    START_CHECK_STATE = 3'b001,
    RECIVE_DATA_STATE = 3'b010,
    PARITY_CHECK_STATE = 3'b011,
    STOP_CHECK_STATE = 3'b100
} State;

State Current_State, Next_State;


// to indicat that both start and data has finished being recieved
wire Data_Recived;
assign Data_Recived = ((bit_cnt == 4'd9) ) ;

always @(posedge CLK or negedge RST) begin

    if(!RST) begin
        Current_State <= IDLE_STATE;
    end
    else begin
        Current_State <= Next_State;
    end
    
end



always @(*) begin

    Next_State = IDLE_STATE;

    case (Current_State)

        IDLE_STATE : begin
            if ( !RX_IN ) begin
                Next_State = START_CHECK_STATE;
            end
            else begin
                Next_State = IDLE_STATE; 
            end
        end

        START_CHECK_STATE : begin
            case( {bit_done,strt_glitch} )
                2'b10: Next_State = RECIVE_DATA_STATE;
                2'b11: Next_State = IDLE_STATE;
                default: Next_State = START_CHECK_STATE;   
            endcase
        end
        
        RECIVE_DATA_STATE : begin
            case( {Data_Recived,PAR_EN} )
                2'b10: Next_State = STOP_CHECK_STATE;
                2'b11: Next_State = PARITY_CHECK_STATE;
                default: Next_State = RECIVE_DATA_STATE;   
            endcase
        end

        PARITY_CHECK_STATE : begin
            case( {bit_done,par_err} )
                2'b10: Next_State = STOP_CHECK_STATE;
                2'b11: Next_State = STOP_CHECK_STATE;
                default: Next_State = PARITY_CHECK_STATE;   
            endcase
        end
        STOP_CHECK_STATE : begin
           case( {bit_done,RX_IN} )
                2'b10: Next_State = START_CHECK_STATE;
                2'b11: Next_State = IDLE_STATE;
                default: Next_State = STOP_CHECK_STATE;   
            endcase
        end 
    endcase

end

always @(*) begin

    par_chk_en = 1'b0;
    count_rst = 1'b0;
    par_save_bit = 1'b0;
    strt_chk_en = 1'b0;
    stp_chk_en = 1'b0;
    deser_en = 1'b0;
    data_samp_en = 1'b1;
    enable = 1'b1;
    DATA_VALID =  ~(Parity_Error | Stop_Error | strt_glitch);
    case (Current_State)

        IDLE_STATE : begin
            enable = 1'b0;
            count_rst = 1'b1;
            data_samp_en = 1'b0;
        end

        START_CHECK_STATE : begin
            strt_chk_en = 1'b1;
            DATA_VALID =  1'b0;
        end
        
        RECIVE_DATA_STATE : begin
            par_chk_en = 1'b1;
            deser_en = 1'b1;
            DATA_VALID =  1'b0;
        end

        PARITY_CHECK_STATE : begin
            par_save_bit = 1'b1;
            DATA_VALID =  1'b0;
        end

        STOP_CHECK_STATE : begin
            stp_chk_en = 1'b1;
            count_rst = 1'b1;
        end 
        default: begin
            par_chk_en = 1'b0;
            strt_chk_en = 1'b0;
            stp_chk_en = 1'b0;
            deser_en = 1'b0;
            data_samp_en = 1'b0;
        end
    endcase

end

assign Parity_Error = par_err;
assign Stop_Error = stp_err;    
endmodule