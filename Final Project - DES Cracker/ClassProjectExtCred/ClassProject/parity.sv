module genParity8(input logic [55:0] in, output logic [63:0] out);
  genvar                         index;
  for(index = 0; index < 8; index++) begin
    genParity genParity(.in(in[7*index +: 7]), .out(out[8*index +: 8]));
  end
endmodule

module genParity(input logic [6:0] in, output logic [7:0] out);
  assign out[0] = ~^in;
  assign out[7:1] = in;
endmodule
