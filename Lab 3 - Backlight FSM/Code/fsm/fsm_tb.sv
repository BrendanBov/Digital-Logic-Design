`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  reset;

   logic  L;
   logic  R;
   logic  LA;
   logic  LB;
   logic  LC;
   logic  RA;
   logic  RB;
   logic  RC;

   
   integer handle3;
   integer desc3;
   integer theTime;
   
   // Instantiate DUT
   FSM dut (clk, reset, L, R, LA, LB, LC, RA, RB, RC);   
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

     initial 
     begin	
	theTime = 0;
	forever #5 theTime += 5;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("fsm.out");
	// Tells when to finish simulation
     desc3 = handle3;
     $fdisplay(desc3, "       Time || Res L R || LA LB LC RA RB RC");
	#500 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#5 $fdisplay(desc3, "%d ||  %b  %b %b || %b  %b  %b  %b  %b  %b", 
		     theTime, reset, L, R, LA, LB, LC, RA, RB, RC);
     end   
   
   
   initial 
     begin      
	#0   reset = 1'b1;
     #0   L = 1'b0;
     #0   R = 1'b0;
	#20   reset = 1'b0;
     #0 L = 1'b1;
     #20 L = 1'b0;
     #0 R = 1'b1;
     #30 L = 1'b1;
     end

endmodule // FSM_tb

