module rca(input logic [3:0] a,b, logic cin, output logic [4:0] Sum);

    logic [2:0] c;

    silly dut1(cin, a[0], b[0], Sum[0], c[0]);
	silly dut2(c[0], a[1], b[1], Sum[1], c[1]);
	silly dut3(c[1], a[2], b[2], Sum[2], c[2]);
	silly dut4(c[2], a[3], b[3], Sum[3], Sum[4]);


endmodule