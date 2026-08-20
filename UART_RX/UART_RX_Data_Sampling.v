module UART_RX_Data_Sampling 
(
    input                           data_samp_en,
    input                           RX_IN,
    input           [5:0]           Prescale,
    input                           CLK,RST,
    input           [4:0]           edge_cnt,
    output  reg                     sampled_bit
);

    reg             sampled_bit_comp;
    reg     [2:0]   Middle_bits;
    reg     [2:0]   Middle_bits_comp;

always @(posedge CLK or negedge RST) begin

    if (!RST) begin
        sampled_bit <= 1'b0; 
    end
    else begin
        sampled_bit <= sampled_bit_comp; 
    end

end


always @(posedge CLK or negedge RST) begin

    if (!RST) begin
        Middle_bits <= 3'b111; 
    end
    else begin
        Middle_bits <= Middle_bits_comp; 
    end

end


always @(*) begin

if (data_samp_en) begin
    case (Prescale)
    //saveing the values of the 3 middle bits into a reg to compare between there values after
        6'd8: begin
            Middle_bits_comp [0] = ( edge_cnt [2:0] == 3'd3 )? RX_IN: Middle_bits[0];
            Middle_bits_comp [1] = ( edge_cnt [2:0] == 3'd4 )? RX_IN: Middle_bits[1];
            Middle_bits_comp [2] = ( edge_cnt [2:0] == 3'd5 )? RX_IN: Middle_bits[2];
        end

        6'd16: begin
            Middle_bits_comp [0] = ( edge_cnt [3:0] == 4'd7 )? RX_IN: Middle_bits[0];
            Middle_bits_comp [1] = ( edge_cnt [3:0] == 4'd8 )? RX_IN: Middle_bits[1];
            Middle_bits_comp [2] = ( edge_cnt [3:0] == 4'd9 )? RX_IN: Middle_bits[2];
        end

        6'd32: begin 
            Middle_bits_comp [0] = ( edge_cnt [4:0] == 5'd15 )? RX_IN: Middle_bits[0];
            Middle_bits_comp [1] = ( edge_cnt [4:0] == 5'd16 )? RX_IN: Middle_bits[1];
            Middle_bits_comp [2] = ( edge_cnt [4:0] == 5'd17 )? RX_IN: Middle_bits[2];
        end
        default: Middle_bits_comp = 3'b111;
    endcase
end
else
    Middle_bits_comp = 3'b111;

end

always @(*) begin

    //save the middle bit to be send to the serializer
    if (data_samp_en) begin
        case (Prescale)
            6'd4: begin
                sampled_bit_comp = ( edge_cnt [1:0] == 2'd2 )? RX_IN: 1'b0 ;

            end
            default: begin
                sampled_bit_comp =  ( Middle_bits [1:0] == 2'b11 ) || 
                                    ( Middle_bits [2:1] == 2'b11 ) || 
                                    ( {Middle_bits [2] , Middle_bits [0]}== 2'b11 );
            end
        endcase
    end
    else
        sampled_bit_comp = 3'b0;

end
endmodule