//Instantiate module Full Adder with inputs a b cin and outputs sum and cout
module silly(input logic a, b, cin,
	output logic s, cout);

//sum is on if one or three inputs are on
assign s = a ^ b ^ cin;

//cout is on if two inputs are on
assign cout = a & b | 
	a & cin | 
	b & cin;

endmodule