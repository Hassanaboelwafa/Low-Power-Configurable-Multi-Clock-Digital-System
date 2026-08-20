`timescale 1ns/100ps
module UART_TX_tb();

    reg       [7:0]       P_DATA_tb;
    reg                   DATA_VALID_tb;
    reg                   PAR_EN_tb;
    reg                   PAR_TYP_tb;
    reg                   CLK_tb, RST_tb;
    wire                  TX_OUT_tb;
    wire                  Busy_tb;

reg START_BIT = 1'b0;
reg STOP_BIT  = 1'b1;

integer currect_Testcase,j;

reg [7:0] Recived_data;
wire parity_bit_Expec;

assign parity_bit_Expec = (PAR_TYP_tb)?  ^Recived_data : ~^ Recived_data;

Top UART_TX 
(  
    .P_DATA(P_DATA_tb),
    .DATA_VALID(DATA_VALID_tb),
    .PAR_EN(PAR_EN_tb),
    .PAR_TYP(PAR_TYP_tb),
    .CLK(CLK_tb),
    .RST(RST_tb),
    .TX_OUT(TX_OUT_tb),
    .Busy(Busy_tb)
);


always #2.5 CLK_tb = ~CLK_tb;


initial begin
    reset();
        
        //as the P_DATA/DATA_VALID changes it is expected that the the processed data remains the same across all simulation as busy is high
        //the P_DATA/DATA_VALID changes only when insert_between_loobs is high

        //Testcase 1: expected to have an IDLE_STATE then 11 cycle containing START - SEND - PARITY - STOP
            testcase('ha,1,1,1,1);

        //Testcase 2: expected to skip the idle state and start with START_STATE, also check the functionallty of PAR_TYP
            testcase('ha,1,1,0,1);

        //Testcase 3: expected to return for the IDLE_STATE and then resume with the normal cycle of START - DATA - PARITY - STOP 
            @(negedge CLK_tb);
            testcase('h44,1,1,0,0);

        //Testcase 4: expected to skip idle state and do 10 cycles skiping the PARITY_STATE
            testcase('hf4,1,0,0,1);

        //Testcase 5: expected to return fo the IDLE_STATE and skip the PARITY_STATE
            @(negedge CLK_tb);
            testcase('he4,1,0,1,0);

        //Testcase 6: expected to stay at IDLE_STATE - TX_OUT is high in IDLE and BUSY is low 
            repeat(10)
                @(negedge CLK_tb);

            check_state_out(1,0);

        //Testcase 7: test DATA_VALID functionallity as DATA_VALID is kept high
        insert_inputs('h55,1,1,1);
        DATA_VALID_tb = 1;
        P_DATA_tb = 'h44;
        check_out('h55,0);

    $stop;
end


//task to do the normal insert and check operation 
task testcase(  input [7:0] P_DATA_task,
                input       DATA_VALID_task,
                input       PAR_EN_task,
                input       PAR_TYP_task,
                input       insert_between_loobs);
begin
insert_inputs(P_DATA_task, DATA_VALID_task, PAR_EN_task, PAR_TYP_task);
check_out(P_DATA_task,insert_between_loobs);
end
endtask


task reset();
begin
    CLK_tb = 0;
    P_DATA_tb = 0;
    DATA_VALID_tb = 0;
    PAR_EN_tb = 0;
    PAR_TYP_tb = 0;
    RST_tb = 1;
    currect_Testcase = 0;

    @(negedge CLK_tb);
    RST_tb = 0;
    @(negedge CLK_tb);
    RST_tb = 1;

    if ( !TX_OUT_tb || Busy_tb ) begin
        $display("\nTestcase %0d: Reset failed",currect_Testcase);
        $stop;
    end
    else begin
        $display("\nTestcase %0d: Reset successed",currect_Testcase);
        currect_Testcase = currect_Testcase+1;
    end
end
endtask

//checks the current TX_OUT and Busy bits
task check_state_out(input Expec_TX_OUT, input Expec_Busy);
begin
    
    if (TX_OUT_tb != Expec_TX_OUT || Busy_tb != Expec_Busy) begin
        $display("\nTestcase %0d Failed at check state: at time = %0t --- P_DATA = %b, DATA_VALID = %b, PAR_EN = %b, PAR_TYP = %b, RST = %b, TX_OUT = %b, Busy = %b",currect_Testcase , $time, P_DATA_tb, DATA_VALID_tb, PAR_EN_tb, PAR_TYP_tb, RST_tb, TX_OUT_tb, Busy_tb);
            $stop;     
    end
    else begin
        $display("\nTestcase %0d successed at check state: at time = %0t --- P_DATA = %b, DATA_VALID = %b, PAR_EN = %b, PAR_TYP = %b, RST = %b, TX_OUT = %b, Busy = %b",currect_Testcase , $time, P_DATA_tb, DATA_VALID_tb, PAR_EN_tb, PAR_TYP_tb, RST_tb, TX_OUT_tb, Busy_tb);
            currect_Testcase = currect_Testcase+1;
    end
end
endtask

//task to check the normal seq of state with or without the parity bit
task check_out(input [7:0] Expec_Data_out , input insert_between_loobs);
begin


//checking the start bit
    if (TX_OUT_tb != START_BIT || !Busy_tb) begin
        $display("\nTestcase %0d Failed at Start bit: at time = %0t --- START_BIT = %b, Expected start bit = %b, DATA_VALID = %b, PAR_EN = %b, PAR_TYP = %b, RST = %b, Busy = %b",currect_Testcase , $time, TX_OUT_tb, START_BIT, DATA_VALID_tb, PAR_EN_tb, PAR_TYP_tb, RST_tb, Busy_tb);
        $stop;    
    end
    else begin
        $display("\nTestcase %0d successed at Start bit: at time = %0t --- START_BIT = %b, Expected start bit = %b, DATA_VALID = %b, PAR_EN = %b, PAR_TYP = %b, RST = %b, Busy = %b",currect_Testcase , $time, TX_OUT_tb, START_BIT, DATA_VALID_tb, PAR_EN_tb, PAR_TYP_tb, RST_tb, Busy_tb);
    end 


//changing the P_DATA/DATA_VALID inside the operation
    if (insert_between_loobs) begin
    P_DATA_tb ='haa;
    DATA_VALID_tb =1;
    end

//reads the tx serial output and then recombine it in a parallel reg
    Recived_data = 0;
    for(j = 0;j < 8;j = j+1) begin
        @(negedge CLK_tb);
        Recived_data[j] = TX_OUT_tb;
    end

//checking for the parallel out bits
    if (Recived_data != Expec_Data_out || !Busy_tb) begin
        $display("\nTestcase %0d Failed at Recived data: at time = %0t --- inserted P_DATA = %0h, Recived data = %0h, current P_DATA = %0h, DATA_VALID = %b, PAR_EN = %b, PAR_TYP = %b, RST = %b, Busy = %b",currect_Testcase , $time, Expec_Data_out, Recived_data, P_DATA_tb, DATA_VALID_tb, PAR_EN_tb, PAR_TYP_tb, RST_tb, Busy_tb);
        $stop;
    end
    else begin
        $display("\nTestcase %0d Successed at Recived data: at time = %0t --- inserted P_DATA = %0h, Recived data = %0h, current P_DATA = %0h, DATA_VALID = %b, PAR_EN = %b, PAR_TYP = %b, RST = %b, Busy = %b",currect_Testcase , $time, Expec_Data_out, Recived_data, P_DATA_tb, DATA_VALID_tb, PAR_EN_tb, PAR_TYP_tb, RST_tb, Busy_tb);
    end

//changing the P_DATA/DATA_VALID inside the operation
    if (insert_between_loobs) begin
        P_DATA_tb ='h43;
        DATA_VALID_tb =1;
    end


//checking the parity bit if the state is not skipped
    if (PAR_EN_tb) begin
        @(negedge CLK_tb);
    if (TX_OUT_tb != parity_bit_Expec) begin
        $display("\nTestcase %0d Failed at parity bit: at time = %0t --- parity bit = %b, Expected parity bit = %b, DATA_VALID = %b, PAR_EN = %b, PAR_TYP = %b, RST = %b, Busy = %b",currect_Testcase , $time, TX_OUT_tb, parity_bit_Expec, DATA_VALID_tb, PAR_EN_tb, PAR_TYP_tb, RST_tb, Busy_tb);
        $stop;
    end
    else begin
        $display("\nTestcase %0d Successed at parity bit: at time = %0t --- parity bit = %b, Expected parity bit = %b, DATA_VALID = %b, PAR_EN = %b, PAR_TYP = %b, RST = %b, Busy = %b",currect_Testcase , $time, TX_OUT_tb, parity_bit_Expec, DATA_VALID_tb, PAR_EN_tb, PAR_TYP_tb, RST_tb, Busy_tb); 
    end
    end

//changing the P_DATA/DATA_VALID inside the operation
    if (insert_between_loobs) begin
        P_DATA_tb ='h54;
        DATA_VALID_tb =0;
    end
//checking fo the stop bit
    @(negedge CLK_tb);
    if (TX_OUT_tb != STOP_BIT) begin
        $display("\nTestcase %0d Failed at Stop bit: at time = %0t --- STOP_BIT = %b, Expected stop bit = %b, DATA_VALID = %b, PAR_EN = %b, PAR_TYP = %b, RST = %b, Busy = %b",currect_Testcase , $time, TX_OUT_tb, STOP_BIT, DATA_VALID_tb, PAR_EN_tb, PAR_TYP_tb, RST_tb, Busy_tb);
            $stop;
    end
    else begin
        $display("\nTestcase %0d Successed at Stop bit: at time = %0t --- STOP_BIT = %b, Expected stop bit = %b, DATA_VALID = %b, PAR_EN = %b, PAR_TYP = %b, RST = %b, Busy = %b",currect_Testcase , $time, TX_OUT_tb, STOP_BIT, DATA_VALID_tb, PAR_EN_tb, PAR_TYP_tb, RST_tb, Busy_tb);
    end

    currect_Testcase = currect_Testcase+1;
end
endtask

//task to insert inputs with keeping the DATA_VALID high for one cycle
task insert_inputs( input [7:0] P_DATA_task,
                    input DATA_VALID_task,
                    input       PAR_EN_task,
                    input       PAR_TYP_task);
begin
    P_DATA_tb = P_DATA_task;
    DATA_VALID_tb = DATA_VALID_task;
    PAR_EN_tb = PAR_EN_task;
    PAR_TYP_tb = PAR_TYP_task;
    @(negedge CLK_tb);
    DATA_VALID_tb = 0;
end
endtask
endmodule