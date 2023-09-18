`timescale 1ns/1ps
module stimulus_class();

  logic 	Start;
  logic 	reset;
  logic [63:0] Key;
  logic [55:0] count;
  logic [63:0] plaintext, ciphertext;
  
  localparam [55:0] count1Threshold = 2**23;
  logic 	   Found;   
  
  logic 	   clk;   
  
  integer 	   outputFilePointer;
  integer 	   testVectorFilePointer;
  
  logic [31:0] vectornum;   

  // Plaintext: 5eb98cbc40c4b52f Ciphertext: a35e08ca3783f128
  // Ciphertext for key count 0: ef3756c1a9f551fe
  
  assign plaintext = 64'h5eb98cbc40c4b52f;
  assign ciphertext = 64'ha35e08ca3783f128;

  top dut (clk, Start, reset, plaintext, ciphertext, count, Key, Found);

  initial 
    begin	
	  clk = 1'b0;
	  forever #5 clk = ~clk;
    end

  initial
    begin
	  vectornum = 0;
	  outputFilePointer = $fopen("count1.out");
	end
	  

  always @(posedge clk) 
    begin
    //$fdisplay(outputFilePointer, "%h %b | %h", Key, Found, count);
	  if (Found == 1'b1) begin
      #10
		$fdisplay(outputFilePointer, "%h %b | %h", Key, Found, count);
		$display("Found Key1!");
    #100;
		$stop();
      end
	end

  initial
    begin
	  // Initialize
	  #0   Start = 1'b0;	
	  #0   reset = 1'b1;
	  #32 reset = 1'b0;
	  #32  Start = 1'b1;
	  #20  Start = 1'b0;
	  
    end 

endmodule // tb
