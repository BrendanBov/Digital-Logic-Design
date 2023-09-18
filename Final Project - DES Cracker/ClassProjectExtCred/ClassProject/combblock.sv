module combblock(input logic clk, reset, Up, en1, en2,
input logic [55:0] numStart,
input logic [63:0] 	plaintext, ciphertext,
output logic [55:0] count,
output logic [63:0] Key, 
output logic 		FoundKeyNum);

    logic [63:0] ciphertextR, ciphertextS;

    UDL_Count #(56) counterMod (clk, reset, Up, 1'b0, 1'b0, numStart, count);
    genParity8 parityMod(count, Key);
    DES desMod (Key, plaintext, 1'b1, ciphertextR);

    flopenr #(64) flop1 (clk, reset, en1, ciphertextR, ciphertextS); //en1
    //flopenr #(64) flop2 (clk, reset, en2, KeyR, Key); //en2

    comparator #(64) compare (ciphertext, ciphertextS, FoundKeyNum);


endmodule