//Instantiate module Full Adder with inputs a b cin and outputs sum and cout
module fulladder(input logic a, b, cin,
	output logic sum, cout);

//sum is on if one or three inputs are on
assign sum = a ^ b ^ cin;

//cout is on if two inputs are on
assign cout = a & b | 
	a & cin | 
	b & cin;

endmodule

