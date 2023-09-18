 module mux( select, d, q );
 
 input logic [15:0] select;
 input logic [15:0] [63:0] d;
 output logic [63:0] q;

 always_comb begin
  case( select )
  /*0 : q = d[0];
  1 : q = d[1];
  2 : q = d[2];
  3 : q = d[3];*/

  /*16'h0000 : q = d[0];
  16'h0001 : q = d[1];
  16'h0010 : q = d[2];
  16'h0011 : q = d[3];
  16'b0100 : q = d[4];
  4'b0101 : q = d[5];
  4'b0110 : q = d[6];
  4'b0111 : q = d[7];
  4'b1000 : q = d[8];
  4'b1001 : q = d[9];
  4'b1010 : q = d[10];
  4'b1011 : q = d[11];
  4'b1100 : q = d[12];
  4'b1101 : q = d[13];
  4'b1110 : q = d[14];
  4'b1111 : q = d[15];*/

  16'b0000000000000001 : q = d[0];
  16'b0000000000000010 : q = d[1];
  16'b0000000000000100 : q = d[2];
  16'b0000000000001000 : q = d[3];
  16'b0000000000010000 : q = d[4];
  16'b0000000000100000 : q = d[5];
  16'b0000000001000000 : q = d[6];
  16'b0000000010000000 : q = d[7];
  16'b0000000100000000 : q = d[8];
  16'b0000001000000000 : q = d[9];
  16'b0000010000000000 : q = d[10];
  16'b0000100000000000 : q = d[11];
  16'b0001000000000000 : q = d[12];
  16'b0010000000000000 : q = d[13];
  16'b0100000000000000 : q = d[14];
  16'b1000000000000000 : q = d[15];
  default : q = 64'h0000000000000000;
  
  endcase
 end

endmodule

/*
module generic_mux #(parameter WIDTH = 1, 
                     parameter NUMBER = 2, 
                     localparam SELECT_W = $clog2(NUMBER)) 
 (input logic [SELECT_W-1:0] sel, 
  input logic [WIDTH-1:0] mux_in [NUMBER-1:0],                   
  output logic [WIDTH-1:0] out);
  
  assign out = mux_in[sel];
    
endmodule    
*/