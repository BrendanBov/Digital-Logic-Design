module top (input logic 		clk, Start, reset,
			input logic [63:0] 	plaintext, ciphertext, 
			output logic [55:0] count,
			output logic [63:0] Key, 
			output logic 		FoundKeyNum);

  typedef enum  logic [1:0] {I, UC, S, FK} statetype;
   statetype state, nextstate;
   logic Up, en1, en2;

  logic [15:0] [55:0] numStart;
   assign numStart[0] = 56'h000000000116ca;
   //assign numStart[0] = 56'h00000000000000;
   assign numStart[1] = 56'h10000000000000;
   assign numStart[2] = 56'h20000000000000;
   assign numStart[3] = 56'h30000000000000;
   assign numStart[4] = 56'h40000000000000;
   assign numStart[5] = 56'h50000000000000;
   assign numStart[6] = 56'h60000000000000;
   assign numStart[7] = 56'h70000000000000;
   assign numStart[8] = 56'h80000000000000;
   assign numStart[9] = 56'h90000000000000;
   assign numStart[10] = 56'ha0000000000000;
   assign numStart[11] = 56'hb0000000000000;
   assign numStart[12] = 56'hc0000000000000;
   assign numStart[13] = 56'hd0000000000000;
   assign numStart[14] = 56'he0000000000000;
   assign numStart[15] = 56'hf0000000000000;

  logic [15:0] [63:0] Keys;
  logic [63:0] KeyR;

  logic [15:0] FoundKeyNums;
  

  combblock com0(clk, reset, Up, en1, en2, numStart[0], plaintext, ciphertext, count, Keys[0], FoundKeyNums[0]);
    combblock com1(clk, reset, Up, en1, en2, numStart[1], plaintext, ciphertext, , Keys[1], FoundKeyNums[1]);
    combblock com2(clk, reset, Up, en1, en2, numStart[2], plaintext, ciphertext, , Keys[2], FoundKeyNums[2]);
    combblock com3(clk, reset, Up, en1, en2, numStart[3], plaintext, ciphertext, , Keys[3], FoundKeyNums[3]);
    combblock com4(clk, reset, Up, en1, en2, numStart[4], plaintext, ciphertext, , Keys[4], FoundKeyNums[4]);
    combblock com5(clk, reset, Up, en1, en2, numStart[5], plaintext, ciphertext, , Keys[5], FoundKeyNums[5]);
    combblock com6(clk, reset, Up, en1, en2, numStart[6], plaintext, ciphertext, , Keys[6], FoundKeyNums[6]);
    combblock com7(clk, reset, Up, en1, en2, numStart[7], plaintext, ciphertext, , Keys[7], FoundKeyNums[7]);
    combblock com8(clk, reset, Up, en1, en2, numStart[8], plaintext, ciphertext, , Keys[8], FoundKeyNums[8]);
    combblock com9(clk, reset, Up, en1, en2, numStart[9], plaintext, ciphertext, , Keys[9], FoundKeyNums[9]);
    combblock com10(clk, reset, Up, en1, en2, numStart[10], plaintext, ciphertext, , Keys[10], FoundKeyNums[10]);
    combblock com11(clk, reset, Up, en1, en2, numStart[11], plaintext, ciphertext, , Keys[11], FoundKeyNums[11]);
    combblock com12(clk, reset, Up, en1, en2, numStart[12], plaintext, ciphertext, , Keys[12], FoundKeyNums[12]);
    combblock com13(clk, reset, Up, en1, en2, numStart[13], plaintext, ciphertext, , Keys[13], FoundKeyNums[13]);
    combblock com14(clk, reset, Up, en1, en2, numStart[14], plaintext, ciphertext, , Keys[14], FoundKeyNums[14]);
    combblock com15(clk, reset, Up, en1, en2, numStart[15], plaintext, ciphertext, , Keys[15], FoundKeyNums[15]);

  mux keyMux(FoundKeyNums, Keys, KeyR);

  flopenr #(64) flop2 (clk, reset, en2, KeyR, Key);

  assign FoundKeyNum = |FoundKeyNums;

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
