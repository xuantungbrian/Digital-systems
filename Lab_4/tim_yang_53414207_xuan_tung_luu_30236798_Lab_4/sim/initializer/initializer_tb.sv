module initializer_tb();
	logic start, clk;
	logic [7:0] q;
	logic [7:0] data, address;
	logic finish, wren;
	initializer DUT(
		.start(start),
		.clk(clk), 
		.q(q), 
		.data(data), 
		.address(address),
		.finish(finish),
		.wren(wren));
	initial begin
		forever begin
			clk = 0; #5;
			clk = 1; #5;
		end
	end

	initial begin
		start = 1;
		#20;
		start = 0;
		#100;
		$stop;
	end
endmodule
