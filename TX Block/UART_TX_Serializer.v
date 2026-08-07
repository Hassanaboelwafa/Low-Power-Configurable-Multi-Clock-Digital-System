module Serializer #(parameter DATA_WIDTH = 8)
(
    input   [DATA_WIDTH-1:0]    P_DATA,
    input                       Ser_En,
    input                       CLK,RST,
    output                      Ser_Done,
    output     reg              Ser_Data
);

reg [3:0] Counter;
reg [3:0] next_count;
reg ser_data_out;

//send ser_done as counter done send all the P_data bits
assign Ser_Done = (Counter == DATA_WIDTH);

always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        Counter <= 'b0;
        Ser_Data <= 'b0;
    end
    else begin
        Ser_Data <= ser_data_out;
        Counter <= next_count;
    end
end

always @(*) begin
    //default value for ser_data_out
    ser_data_out = 'b0;

    //as long as Ser_En is asserted high and the P_DATA bits is not finished transmiting the 
    //data will still be sent
    if ((Counter != DATA_WIDTH) && Ser_En) begin
            ser_data_out = P_DATA [Counter];
            next_count = Counter + 'b1;
        end

        else if (Counter == DATA_WIDTH) begin
            //reseting the counter value if all P_DATA bits is sent
            next_count = 'b0;
        end
        else
        next_count = Counter;
end
endmodule