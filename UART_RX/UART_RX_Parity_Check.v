module UART_RX_Parity_Check 
(
    input           par_chk_en,
    input           par_save_bit,
    input           sampled_bit,
    input           bit_done,
    input           PAR_TYP,
    input           CLK,RST,
    output  reg     par_err    
);

    //a reg to calculate the parity bit
    reg     parity_Xor;
    reg    parity_Xor_comp;

    wire     par_err_comp;

    wire    parity_calculated;
    
// to be able to use one xor gate in both even and odd parity type 
assign parity_calculated = (PAR_TYP)? parity_Xor : ~parity_Xor;



always @(posedge CLK or negedge RST) begin

    if (!RST) 
    begin
        parity_Xor <= 1'b0;
        par_err <= 1'b0;
    end
    else begin
        if (par_chk_en && bit_done) 
        begin
            parity_Xor <= parity_Xor_comp;
        end
        //if the parity is not caluclated and the results was saved 
        //the bit used to save the computed parity is reset to be ready for the next transmation
        else if ( ~(par_chk_en | par_save_bit) )
        begin
            parity_Xor <= 1'b0;
        end
        
        //when the parity is being recived the par_err saves the parity check value
        if (par_save_bit && bit_done)
        begin
            par_err <= par_err_comp;
        end
    end

end

always @(*) begin

    //when the bit is done sampled it is XORed with the accumulative computed parity  
    if (par_chk_en && bit_done) 
    begin
        parity_Xor_comp = sampled_bit ^ parity_Xor;
    end
    else
        parity_Xor_comp = parity_Xor;

end


assign par_err_comp = (par_save_bit)? (parity_calculated != sampled_bit): par_err;

endmodule