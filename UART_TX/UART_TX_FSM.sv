module UART_TX_FSM 
(
    input                   DATA_VALID,
    input                   PAR_EN,
    input                   Ser_Done,
    input                   CLK,RST,
    output  reg             Ser_En,
    output  reg     [1:0]   MUX_Sel,
    output  reg             Busy
);

//using enums to display the state names on the wave-form
typedef enum reg [2:0] {
IDLE_STATE       = 'b000,
START_STATE = 'b001,
SEND_STATE  = 'b010,
PARITY_STATE     = 'b011,
END_STATE   = 'b100
} State;

State Current_State,Next_State;

//FSM current state handling 
always @(posedge CLK or negedge RST) begin
    if(!RST) begin
        Current_State <= IDLE_STATE;
    end
    else begin
        Current_State <= Next_State;
    end
end

//NEXT state handling
always @(*) begin

//default value for Next_State
    Next_State = IDLE_STATE;

    case(Current_State) 
    //IDLE_STATE resume as long as data valid stay low and when the data valid signal assert high
    // it goes to START_STATE
        IDLE_STATE: begin   
            if (DATA_VALID) 
            Next_State = START_STATE;
            else 
            Next_State = IDLE_STATE;
        end

        //START_STATE is the state that send the starting bit and then it goes to SEND_STATE
        START_STATE: begin
            Next_State = SEND_STATE;
        end

        //SEND_STATE is a 8 clock cycles state that send the acual P_data 
        //acording to the value of PAR_EN value captured at high data valid it decides whether to
        //go to PARITY_STATE or to the END_STATE
        SEND_STATE: begin  
            if(Ser_Done) begin
                if(PAR_EN)  
                Next_State = PARITY_STATE;
                else
                Next_State = END_STATE;
                end
            else 
            Next_State = SEND_STATE;
        end

        //PARITY_STATE is the state that send the even or odd party bit acording to PAR_TYP value  
        PARITY_STATE: begin
            Next_State = END_STATE;
        end

        //END_STATE is the state that send the stop bit it either goes to IDLE_STATE if data valid is not asserted high
        // or goes to START_STATE to allow back-to-back data sending
        END_STATE: begin    
            if(DATA_VALID)
            Next_State = START_STATE;
            else
            Next_State = IDLE_STATE;
        end
        default: Next_State = IDLE_STATE;
    endcase
end


always @(*) begin

    //default values for the FSM output signals
    Ser_En = 'b0;
    MUX_Sel = 'b00;
    Busy = 'b1;

    //moore FSM
    case(Current_State) 

        IDLE_STATE: begin
            Busy = 'b0;
            Ser_En = 'b0;    
        end

        START_STATE: begin
            MUX_Sel = 'b00; 
            //to let the next clock cycle directly get the value of the first bit of the data in the next clock cycle
            Ser_En = 'b1; 
        end

        SEND_STATE: begin  
            MUX_Sel = 'b01; 
            //to resume sending until ser_done is sent from the serializer
            Ser_En = 'b1;       
        end

        PARITY_STATE: begin
            MUX_Sel = 'b10;   
        end

        END_STATE: begin    
            MUX_Sel = 'b11;
            //informing the Reg_inputs to cupture new data if there is any
            Busy = 'b0;
        end

        default: begin
            Ser_En = 'b0;
            MUX_Sel = 'b00;
            Busy = 'b0;
        end
    endcase
end

endmodule