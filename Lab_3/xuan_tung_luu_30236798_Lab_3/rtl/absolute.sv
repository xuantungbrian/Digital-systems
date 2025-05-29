module absolute(input logic [7:0] in, output logic [7:0] out);
	always_comb
		if (in[7]) 
			out = ~(in - 1'b1);
		else 	
			out = in;
endmodule