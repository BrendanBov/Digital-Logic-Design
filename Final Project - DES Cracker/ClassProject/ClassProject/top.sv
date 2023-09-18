module top (input logic 		clk, Start, reset,
			input logic [63:0] 	plaintext, ciphertext, 
			output logic [55:0] count,
			output logic [63:0] Key, 
			output logic 		FoundKeyNum);

  typedef enum  logic [1:0] {I, UC, S, FK} statetype;
   statetype state, nextstate;
   logic Up, en1, en2;
   logic [63:0] ciphertextR, ciphertextS, KeyR;
 
   //flopenr #(64) flop1 (clk, reset, en1, ciphertextR, ciphertextS);
   //flopenr #(64) flop2 (clk, reset, en2, KeyR, Key);
/*
   UDL_Count #(56) counterMod (clk, reset, Up, 1'b0, 1'b0, 56'h00000000000000, count);
   genParity8 parityMod(.in(count), .out(Key));
   DES desMod (Key, plaintext, 1'b1, ciphertextR);
   comparator #(64) compare (ciphertext, ciphertextR, FoundKeyNum);
  */


   UDL_Count #(56) counterMod (clk, reset, Up, 1'b0, 1'b0, 56'h00000000000000, count);
   genParity8 parityMod(count, KeyR);
   DES desMod (KeyR, plaintext, 1'b1, ciphertextR);

   flopenr #(64) flop1 (clk, reset, en1, ciphertextR, ciphertextS); //en1
   flopenr #(64) flop2 (clk, reset, en2, KeyR, Key); //en2

   comparator #(64) compare (ciphertext, ciphertextS, FoundKeyNum);
  
  
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= I;
     else       state <= nextstate;
 
     // next state logic
   always_comb
     case (state)

        I: begin
    Up <= 1'b0;
    en1 <= 1'b0;
    en2 <= 1'b0;
  if (!Start) nextstate <= I;
  else nextstate <= UC;
       end

       UC: begin
  Up <= 1'b1;
    en1 <= 1'b0;
    en2 <= 1'b0;        
    nextstate <= S;
       end

       S: begin
  Up <= 1'b0;
    en1 <= 1'b1;
    en2 <= 1'b0;
    if (!FoundKeyNum) nextstate <= UC;
  else nextstate <= FK;
       end

       FK: begin
  Up <= 1'b0;
    en1 <= 1'b0;
    en2 <= 1'b1;
    if (Start) nextstate <= FK;
  else nextstate <= I;
       end

     endcase

endmodule // top
