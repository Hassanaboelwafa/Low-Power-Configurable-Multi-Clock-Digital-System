`timescale 1ns/100ps
module UART_RX_tb ();

    reg                      RX_CLK_tb,RST_tb;
    reg                      RX_IN_tb;
    reg                      PAR_EN_tb;
    reg             [5:0]    Prescale_tb;
    reg                      PAR_TYP_tb;
    wire                     DATA_VALID_tb;
    wire                     Parity_Error_tb;
    wire                     Stop_Error_tb;
    wire            [7:0]    P_DATA_tb; 

    reg                      TX_CLK_tb;


integer i,Current_testcase;
parameter TX_CLOCK_PERIOD = (1 / 115.2)*(10**6);
parameter RX_CLOCK_PERIOD = TX_CLOCK_PERIOD / 32;

always #(TX_CLOCK_PERIOD/2.0) TX_CLK_tb = ~TX_CLK_tb;

always #(RX_CLOCK_PERIOD/2.0) RX_CLK_tb = ~RX_CLK_tb;

Top DUT
(
    .CLK(RX_CLK_tb),
    .RST(RST_tb),
    .RX_IN(RX_IN_tb),
    .PAR_EN(PAR_EN_tb),
    .Prescale(Prescale_tb),
    .PAR_TYP(PAR_TYP_tb),
    .DATA_VALID(DATA_VALID_tb),
    .Parity_Error(Parity_Error_tb),
    .Stop_Error(Stop_Error_tb),
    .P_DATA(P_DATA_tb)   
);


initial begin
    
    //Testcase 0: Reset and check the values of the outputs
    Reset();
    
    
    Current_testcase = 100;

    //Testcase 0.1: checking the effect of start glitchs, check if the design can neglect and filter glitchs
    //the current state of the fsm should go to idle state from start state since it is a glitch 
    @(negedge RX_CLK_tb);
        RX_IN_tb = 0;
    @(negedge RX_CLK_tb);
        RX_IN_tb = 1;
    repeat(31)
        @(negedge RX_CLK_tb);

    @(posedge TX_CLK_tb);
    check_data_out('h0,0,0,0);

    Current_testcase = 1;


//Testcases using Prescale = 8 
Prescale_tb = 'd8;

    //********** Testcases where the data send is corrct **********

        //Testcase 1: expected states transtions
        // idle - start - recive data - odd parity - stop state then return to idle
            insert_data('hfe,1,1,1,1);
            check_data_out('hfe,0,0,1);
                @(posedge TX_CLK_tb);

        //Testcase 2: expected states transtions
        // idle - start - recive data - even parity - stop state then it goes back-to-back to start state 
            insert_data('hfe,1,0,0,1);
            check_data_out('hfe,0,0,1);

        //Testcase 3: expected states transtions 
        //(back-to-back recive data from stop to start state)
        // start - recive data - even parity - stop state  
            insert_data('hdf,1,0,0,1);
            check_data_out('hdf,0,0,1);

        //Testcase 4: expected states transtions 
        //(back-to-back recive data from stop to start state and no parity)
        // start - recive data - stop state  
            insert_data('hdf,0,0,1,1);
            check_data_out('hdf,0,0,1);
                @(posedge TX_CLK_tb);

    //********** Testcases where the data send is wrong **********

        //Testcase 5: expected states transtions with wrong parity 
        // idle - start - recive data - odd parity - stop state then return to idle
            insert_data('hfe,1,0,1,1);
            check_data_out('hfe,1,0,0);
                @(posedge TX_CLK_tb);

        //Testcase 6: expected states transtions with wrong stop
        // idle - start - recive data - even parity - stop state then it goes back-to-back to start state 
            insert_data('hfe,1,0,0,0);
            check_data_out('hfe,0,1,0);

        //Testcase 7: expected states transtions with wrong parity and stop
        //(back-to-back recive data from stop to start state)
        // start - recive data - even parity - stop state  
            insert_data('hdf,1,0,1,0);
            check_data_out('hdf,1,1,0);

        //Testcase 8: expected states transtions with correct parity and stop
        //(back-to-back recive data from stop to start state)
        // start - recive data - stop state  
            insert_data('hdf,1,0,0,1);
            check_data_out('hdf,0,0,1);



//Testcases using Prescale = 16 
Prescale_tb = 'd16;

    //********** Testcases where the data send is corrct **********

        //Testcase 9: expected states transtions
        // idle - start - recive data - odd parity - stop state then return to idle
            insert_data('h12,1,1,0,1);
            check_data_out('h12,0,0,1);
                @(posedge TX_CLK_tb);

        //Testcase 10: expected states transtions
        // idle - start - recive data - even parity - stop state then it goes back-to-back to start state 
            insert_data('h26,1,0,0,1);
            check_data_out('h26,0,0,1);

        //Testcase 11: expected states transtions 
        //(back-to-back recive data from stop to start state)
        // start - recive data - even parity - stop state  
            insert_data('h87,1,0,1,1);
            check_data_out('hd87,0,0,1);

        //Testcase 12: expected states transtions 
        //(back-to-back recive data from stop to start state and no parity)
        // start - recive data - stop state  
            insert_data('hd56,0,0,1,1);
            check_data_out('h56,0,0,1);
                @(posedge TX_CLK_tb);

    //********** Testcases where the data send is wrong **********

        //Testcase 13: expected states transtions with wrong parity 
        // idle - start - recive data - odd parity - stop state then return to idle
            insert_data('h99,1,0,0,1);
            check_data_out('h99,1,0,0);
                @(posedge TX_CLK_tb);

        //Testcase 14: expected states transtions with wrong stop
        // idle - start - recive data - even parity - stop state then it goes back-to-back to start state 
            insert_data('h33,1,0,1,0);
            check_data_out('h33,0,1,0);

        //Testcase 15: expected states transtions with wrong parity and stop
        //(back-to-back recive data from stop to start state)
        // start - recive data - even parity - stop state  
            insert_data('h01,1,0,1,0);
            check_data_out('h01,1,1,0);

        //Testcase 16: expected states transtions with correct parity and stop
        //(back-to-back recive data from stop to start state)
        // start - recive data - stop state  
            insert_data('h92,1,0,0,1);
            check_data_out('h92,0,0,1);


//Testcases using Prescale = 32 
Prescale_tb = 'd32;

    //********** Testcases where the data send is corrct **********

        //Testcase 17: expected states transtions
        // idle - start - recive data - odd parity - stop state then return to idle
            insert_data('hfe,1,1,1,1);
            check_data_out('hfe,0,0,1);
                @(posedge TX_CLK_tb);

        //Testcase 18: expected states transtions
        // idle - start - recive data - even parity - stop state then it goes back-to-back to start state 
            insert_data('hfe,1,0,0,1);
            check_data_out('hfe,0,0,1);

        //Testcase 19: expected states transtions 
        //(back-to-back recive data from stop to start state)
        // start - recive data - even parity - stop state  
            insert_data('hdf,1,0,0,1);
            check_data_out('hdf,0,0,1);

        //Testcase 20: expected states transtions 
        //(back-to-back recive data from stop to start state and no parity)
        // start - recive data - stop state  
            insert_data('hdf,0,0,1,1);
            check_data_out('hdf,0,0,1);
                @(posedge TX_CLK_tb);

    //********** Testcases where the data send is wrong **********

        //Testcase 21: expected states transtions with wrong parity 
        // idle - start - recive data - odd parity - stop state then return to idle
            insert_data('hfe,1,0,1,1);
            check_data_out('hfe,1,0,0);
                @(posedge TX_CLK_tb);

        //Testcase 22: expected states transtions with wrong stop
        // idle - start - recive data - even parity - stop state then it goes back-to-back to start state 
            insert_data('hfe,1,0,0,0);
            check_data_out('hfe,0,1,0);

        //Testcase 23: expected states transtions with wrong parity and stop
        //(back-to-back recive data from stop to start state)
        // start - recive data - even parity - stop state  
            insert_data('hdf,1,0,1,0);
            check_data_out('hdf,1,1,0);

        //Testcase 24: expected states transtions with correct parity and stop
        //(back-to-back recive data from stop to start state)
        // start - recive data - stop state  
            insert_data('hdf,1,0,0,1);
            check_data_out('hdf,0,0,1);

    $stop;


end


task Reset();
begin

    i = 0;
    Current_testcase = 0;
    RX_CLK_tb = 'b1;
    TX_CLK_tb = 'b1;
    RST_tb = 'b1;
    RX_IN_tb= 'b1;
    PAR_EN_tb= 'b0;
    Prescale_tb= 'b0;
    PAR_TYP_tb= 'b0;

    @(posedge TX_CLK_tb);

        RST_tb = 'b0;
    @(posedge TX_CLK_tb);

        RST_tb = 'b1;
    @(posedge TX_CLK_tb);


    $display("Testcase %0d RESET at time %0t:",Current_testcase,$time);

    if ( | P_DATA_tb ) begin
        $display("Testcase %0d P_DATA Reset: Failed --- P_DATA DUT = %0h ",Current_testcase,P_DATA_tb);
        $stop;
    end
    else begin
        $display("Testcase %0d P_DATA Reset: Successed --- P_DATA DUT = %0h",Current_testcase,P_DATA_tb);     
    end

    if ( Parity_Error_tb ) begin
        $display("Testcase %0d Parity Error Reset: Failed --- Parity_Error DUT = %0h",Current_testcase,Parity_Error_tb);
        $stop;
    end
    else begin
        $display("Testcase %0d Parity Error Reset: Successed --- Parity_Error DUT = %0h",Current_testcase,Parity_Error_tb);
    end
    
    if ( Stop_Error_tb ) begin
        $display("Testcase %0d Stop Error Reset: Failed --- Stop_Error DUT = %0h \n",Current_testcase,Stop_Error_tb);
        $stop;
    end
    else begin
        $display("Testcase %0d Stop Error Reset: Successed --- Stop_Error DUT = %0h \n",Current_testcase,Stop_Error_tb);
            
    end
    Current_testcase = Current_testcase + 1;  
end
endtask


task insert_data (  
                    input [7:0] serail_data_in,
                    input       parity_en,
                    input       parity_type,
                    input       parity_bit,
                    input       stop_bit
                    );
begin
        PAR_TYP_tb = parity_type;
         PAR_EN_tb= parity_en;
    
        RX_IN_tb = 0;
    @(posedge TX_CLK_tb);
        

    for (i = 0 ;i < 8;i = i+1) begin
        RX_IN_tb = serail_data_in [i];
    @(posedge TX_CLK_tb);
            
    end

    if (PAR_EN_tb) begin
        RX_IN_tb = parity_bit;
    @(posedge TX_CLK_tb);
        
    end

    
        RX_IN_tb = stop_bit;
    @(posedge TX_CLK_tb);

    
end
endtask

task check_data_out (
                        input [7:0] Expected_parallel_data_in,
                        input       Expected_Parity_Error,
                        input       Expected_Stop_Error,
                        input       Expected_Data_Valid

                    );
begin
    $display("Testcase %0d Results at time %0t, Prescal = %0d:",Current_testcase,$time,Prescale_tb);

    if (Expected_parallel_data_in != P_DATA_tb) begin
        $display("Testcase %0d P_DATA: Failed --- P_DATA DUT = %0h, while P_DATA Expected  = %0h",Current_testcase,P_DATA_tb,Expected_parallel_data_in);
        $stop;
    end
    else begin
        $display("Testcase %0d P_DATA: Successed --- P_DATA DUT = %0h, while P_DATA Expected  = %0h",Current_testcase,P_DATA_tb,Expected_parallel_data_in);     
    end

    if ( Parity_Error_tb != Expected_Parity_Error ) begin
        $display("Testcase %0d Parity Error Check: Failed --- Parity_Error DUT = %0h, while Parity_Error Expected  = %0h",Current_testcase,Parity_Error_tb,Expected_Parity_Error);
        $stop;
    end
    else begin
        $display("Testcase %0d Parity Error Check: Successed --- Parity_Error DUT = %0h, while Parity_Error Expected  = %0h",Current_testcase,Parity_Error_tb,Expected_Parity_Error);
    end
    
    if ( Stop_Error_tb != Expected_Stop_Error ) begin
        $display("Testcase %0d Stop Error Check: Failed --- Stop_Error DUT = %0h, while Stop_Error Expected  = %0h ",Current_testcase,Stop_Error_tb,Expected_Stop_Error);
        $stop;
    end
    else begin
        $display("Testcase %0d Stop Error Check: Successed --- Stop_Error DUT = %0h, while Stop_Error Expected  = %0h ",Current_testcase,Stop_Error_tb,Expected_Stop_Error);
            
    end

    if ( DATA_VALID_tb != Expected_Data_Valid ) begin
        $display("Testcase %0d Data_valid Check: Failed --- Data_valid DUT = %0h, while Data_valid Expected  = %0h \n",Current_testcase,DATA_VALID_tb,Expected_Data_Valid);
        $stop;
    end
    else begin
        $display("Testcase %0d Data_valid Check: Successed --- Data_valid DUT = %0h, while Data_valid Expected  = %0h \n",Current_testcase,DATA_VALID_tb,Expected_Data_Valid);
            
    end
    Current_testcase = Current_testcase + 1;
end
endtask
endmodule