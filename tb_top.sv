`timescale 1ns/1ps




module tb_top ();




logic clk ; 
logic but1 ; 
logic but2 ; 


initial begin
 clk = '0 ; 
but1 = '0 ;
but2 = '0 ; 
end


logic [7:0] tbcathode ;
logic [3:0] tbanode   ; 
logic debugLED1       ;
logic debugLED2       ;
logic [3:0] red       ;
logic [3:0] green     ;
logic [3:0] blue      ;
logic hsync           ; 
logic vsync           ;



lab2 UUT
 (.clk (clk)
 ,.but1(but1)
 ,.but2(but2)
 ,.cathode(tbcathode)
 ,.anode   (tbanode)
 ,.debugBUT_LED(debugLED1)
 ,.debugDISP_LED(debugLED2)
 ,.red(red)
 ,.green(green)
 ,.blue(blue)
 ,.hsync(hsync)
 ,.vsync(vsync)
) ; 






always #1 clk = ~clk ; 
always #5 but1 = ~clk ; 




endmodule