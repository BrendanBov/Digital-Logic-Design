module FSM (clk, reset, L, R, LA, LB, LC, RA, RB, RC);

   input logic  clk;
   input logic  reset;
   input logic L, R;
   
   output logic LA, LB, LC, RA, RB, RC;

   typedef enum 	logic [3:0] {O, L1, L2, L3, R1, R2, R3, H1, H2, H3} statetype;
   statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= O;
     else       state <= nextstate;
   
   // next state logic
   always_comb
     case (state)
        O: begin
	  LA <= 1'b0;
    LB <= 1'b0;
    LC <= 1'b0;
    RA <= 1'b0;
    RB <= 1'b0;
    RC <= 1'b0;
    
	  if (!L*!R) nextstate <= O;
	  else if (L*!R)  nextstate <= L1;
    else if (R*!L)  nextstate <= R1;
    else if (L*R)  nextstate <= H1;
       end
       L1: begin
	  LA <= 1'b1;
    LB <= 1'b0;
    LC <= 1'b0;
    RA <= 1'b0;
    RB <= 1'b0;
    RC <= 1'b0;	  	  
	  nextstate <= L2;
       end
       L2: begin
	  LA <= 1'b1;
    LB <= 1'b1;
    LC <= 1'b0;
    RA <= 1'b0;
    RB <= 1'b0;
    RC <= 1'b0;		  	  
	  nextstate <= L3;
       end
       L3: begin
	  LA <= 1'b1;
    LB <= 1'b1;
    LC <= 1'b1;
    RA <= 1'b0;
    RB <= 1'b0;
    RC <= 1'b0;		  	  
	  nextstate <= O;
       end
       R1: begin
	  LA <= 1'b0;
    LB <= 1'b0;
    LC <= 1'b0;
    RA <= 1'b1;
    RB <= 1'b0;
    RC <= 1'b0;		  	  
	  nextstate <= R2;
       end
       R2: begin
	  LA <= 1'b0;
    LB <= 1'b0;
    LC <= 1'b0;
    RA <= 1'b1;
    RB <= 1'b1;
    RC <= 1'b0;		  	  
	  nextstate <= R3;
       end
       R3: begin
	  LA <= 1'b0;
    LB <= 1'b0;
    LC <= 1'b0;
    RA <= 1'b1;
    RB <= 1'b1;
    RC <= 1'b1;		  	  
	  nextstate <= O;
       end
       H1: begin
	  LA <= 1'b1;
    LB <= 1'b0;
    LC <= 1'b0;
    RA <= 1'b1;
    RB <= 1'b0;
    RC <= 1'b0;		  	  
	  nextstate <= H2;
       end
       H2: begin
	  LA <= 1'b1;
    LB <= 1'b1;
    LC <= 1'b0;
    RA <= 1'b1;
    RB <= 1'b1;
    RC <= 1'b0;		  	  
	  nextstate <= H3;
       end
       H3: begin
	  LA <= 1'b1;
    LB <= 1'b1;
    LC <= 1'b1;
    RA <= 1'b1;
    RB <= 1'b1;
    RC <= 1'b1;		  	  
	  nextstate <= O;
       end
       default: begin
	  LA <= 1'b0;
    LB <= 1'b0;
    LC <= 1'b0;
    RA <= 1'b0;
    RB <= 1'b0;
    RC <= 1'b0;		 	  	  
	  nextstate <= O;
       end
     endcase
   
endmodule
