`timescale 1ns / 1ps




module buttoncount 
    #(
    parameter MAX_DIGIT = 9 
    )
    (input sample_clk
    ,input   but1
    ,input   but2
    ,output logic [3:0] but1counter
    ,output logic [3:0] but2counter
    )  ; 

initial but1counter = '0 ; 
initial but2counter = '0 ;  


always@(posedge sample_clk) begin

    if (but1 == 1'b1 )
     begin
        if(but1counter == MAX_DIGIT)
        but1counter <= 4'd0 ;
        else
        but1counter <= but1counter + 1'b1 ;  
     end

    if (but2 == 1'b1 )
     begin
        if(but2counter == MAX_DIGIT)
        but2counter <= 4'd0 ; 
        else
        but2counter <= but2counter + 1'b1 ; 
     end

 end


endmodule 