`timescale 1ns / 1ps
module tb ();

   logic [3:0]   A;
   logic [3:0]   B;
   logic 	Cin;
   logic    clk;

   logic [4:0] Sum;
   logic [4:0] Sum_corr;
   
  // instantiate device under test
   //silly dut1 (a, b, cin, s, cout);
   //logic [2:0] c;
   
	/*silly dut1(cin, a[0], b[0], Sum[0], c[0]);
	silly dut2(c[0], a[1], b[1], Sum[1], c[1]);
	silly dut3(c[1], a[2], b[2], Sum[2], c[2]);
	silly dut4(c[2], a[3], b[3], Sum[3], Sum[4]);*/

	rca dut(A, B, Cin, Sum);

	assign Sum_corr = A + B + Cin;


integer handle3;
integer desc3;
integer i;

initial
	begin
		handle3 = $fopen("rca.out");
		desc3 = handle3;
		#1250 $finish;
	end

initial
	begin
		for(i = 0; i < 200; i = i + 1)
			begin

				@(posedge clk)
					begin
						A = $random;
						B = $random;
						Cin = $random;
					end
				@(negedge clk)
					begin
					$fdisplay(desc3, "%h %h %h || %h | %h | %b", A, B, Cin, Sum, Sum_corr, (Sum == Sum_corr));
					end
				end
			end


   // 2 ns clock
   initial 
     begin	
	clk = 1'b1;
	forever #10 clk = ~clk;
     end

/*
   initial
     begin
    
	#0   a = 4'b1011;	
	#0   b = 4'b1010;
	#0   cin = 1'b0;

	end

	/*

	#20  a = 1'b1;
	#0   b = 1'b0;
	#0   cin = 1'b0;

	#20  a = 1'b0;
	#0   b = 1'b1;
	#0   cin = 1'b0;

	#20  a = 1'b1;
	#0   b = 1'b1;
	#0   cin = 1'b0;

	#0   a = 1'b0;	
	#0   b = 1'b0;
	#0   cin = 1'b1;

	#20  a = 1'b1;
	#0   b = 1'b0;
	#0   cin = 1'b1;

	#20  a = 1'b0;
	#0   b = 1'b1;
	#0   cin = 1'b1;

	#20  a = 1'b1;
	#0   b = 1'b1;
	#0   cin = 1'b1;	

	


	
     end

	 logic [3:0] A, B;
	 logic Cin;

	 logic [4:0] Sum;
	 logic [4:0] Sum_correct;

	 logic clk;
	 logic [31:0] errors;
	 logic [31:0] vectornum

	 integer handle3;
	 integers desc3;
	 integer i, j, k;

	 silly dut1 (A, B, Cin, Sum);
	 assign Sum_correct = A + B + Cin;

	 initial
	 	begin
			clk = 1'b1;
			forever #5 clk = ~clk;
		end

	initial
		begin
			handle3 = $fopen("rca4.out");
			vectornum = 0;
			errors = 0;
			desc3 = handle3;

		end

	initial
		begin
			for(j = 0; j < 4; j = j + 1)
				begin
					for(i = 0; i < 4; i + 1)
						vegin
							@(posedge clk)
								begin
									A = $random;
									B = $random;
									Cin = $random;
								end
								@(negedge clk)
									begin
										vectornum = vectornum + 1;
										if(Sum != Sum_correct)
											begin
												errors = errors + 1;
												$display("Error: %h %h || %h != %h",
													A, B, Sum, Sum_correct);
											end
											#0 $fdisplay(desc3, "%h %)*/

 


	 


   
endmodule
