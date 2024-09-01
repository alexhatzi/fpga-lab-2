`timescale 1ns/1ps 



module lab2 (
      input clk
    , input but1
    , input but2
    , output logic [7:0] cathode
    , output logic [3:0] anode 
    , output logic debugBUT_LED
    , output logic debugDISP_LED
    , output logic [3:0] red
    , output logic [3:0] green
    , output logic [3:0] blue
    , output logic hsync
    , output logic vsync
) ;


     
  logic but_clk                 ; 
  logic segment_clk             ; 

  logic digit_clk               ;
  logic [3:0] btn_cnt [1:0]     ;    
  logic [7:0] cathode_trk [1:0] ;
  logic [3:0] r_color           ; 
  logic [3:0] g_color           ; 
  logic [3:0] b_color           ; 


clk_divider #(.CLK_COUNT(6250000))  
    u_button_clock
    (    .clk       (clk    )
    ,    .sample_clk(but_clk)
    ) ; 


clk_divider #(.CLK_COUNT(200000)) //  250 Hz (100 MHz / (250*2))
    u_segment_clk
    (    .clk       (    clk    )
    ,    .sample_clk(segment_clk)
    ) ; 
    
    

buttoncount
    #(.MAX_DIGIT(8))
    u_buttoncount
    (
        .sample_clk  ( but_clk  )
    ,   .but1        ( but1     )
    ,   .but2        ( but2     )
    ,   .but1counter (btn_cnt[0])
    ,   .but2counter (btn_cnt[1])
    ) ; 



seg_decoder u_segdecoder_1
    ( .clk      ( clk           ) 
    , .butcnt   ( btn_cnt[0]    )
    , .cathode  ( cathode_trk[0])
    );

 



    // 7 Segment Display
    always@(posedge clk) begin
        cathode [7:0] = cathode_trk[0]  ;
        anode   [1:0] = 2'b10           ; 
    end



// VGA Driver
display_driver u_display_driver 
        ( .clk          (clk          )
        , .r_color      (r_color      )
        , .g_color      (g_color      )
        , .b_color      (b_color      )
        , .red          (red          )
        , .green        (green          )
        , .blue         (blue          )
        , .H_SYNC       (hsync        )
        , .V_SYNC       (vsync        )
        ) ; 


    always@(posedge clk) begin
        case (btn_cnt[0]) 
            4'b0000 : begin        // Black
                r_color <= 4'b0000 ; 
                g_color <= 4'b0000 ; 
                b_color <= 4'b0000 ; 
            end
            4'b0001 : begin      // White
                r_color <= 4'b1111 ; 
                g_color <= 4'b1111 ; 
                b_color <= 4'b1111 ; 
            end
            4'b0010 : begin       // Red
                r_color <= 4'b1111 ; 
                g_color <= 4'b0000 ; 
                b_color <= 4'b0000 ; 
            end
            4'b0011 : begin      // Green
                r_color <= 4'b0000 ; 
                g_color <= 4'b1111 ; 
                b_color <= 4'b0000 ; 
            end
            4'b0100 : begin      // Blue
                r_color <= 4'b0000 ; 
                g_color <= 4'b0000 ; 
                b_color <= 4'b1111 ; 
            end
            4'b0101 : begin         // Yellow
                r_color <= 4'b1111 ; 
                g_color <= 4'b1111 ; 
                b_color <= 4'b0000 ; 
            end
            4'b0110 : begin         // Cyan 
                r_color <= 4'b0000 ; 
                g_color <= 4'b1111 ; 
                b_color <= 4'b1111 ; 
            end
            4'b0111 : begin        // Magenta
                r_color <= 4'b1111 ; 
                g_color <= 4'b0000 ; 
                b_color <= 4'b1111 ; 
            end
            4'b1000 : begin         // idk
                r_color <= 4'b0011 ; 
                g_color <= 4'b0111 ; 
                b_color <= 4'b1111 ; 
            end
            default : begin         // Black ? 
                r_color <= 4'b0011 ; 
                g_color <= 4'b0111 ; 
                b_color <= 4'b1111 ; 
            end
            
            
        
        endcase
    end







//// Debug fixes
   // Tie to ground 
   assign anode [3:2] = '1 ; 



   // Debug LEDs
   always@(posedge but_clk)
   debugBUT_LED = ~debugDISP_LED ; 

   always@(posedge segment_clk)
   debugDISP_LED = ~debugDISP_LED ; 





endmodule 