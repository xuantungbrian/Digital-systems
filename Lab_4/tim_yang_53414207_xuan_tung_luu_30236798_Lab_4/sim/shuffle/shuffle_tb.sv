module shuffle_tb();
	logic start, clk;
	logic [7:0] q;
	logic [7:0] data, address;
	logic finish, wren;
	logic [23:0] secret_key;

	shuffle DUT(
		.start(start),
		.clk(clk),
		.q(q),
		.secret_key(secret_key), 
		.data(data), 
		.address(address), 
		.finish(finish), 
		.wren(wren));

	initial begin
		clk = 0; #5;
		forever begin
			clk = 1; #5;
			clk = 0; #5;
		end
	end

	initial begin
		start = 1;
		secret_key = {14'b0, 10'b1001001001};
		q = 1;
		#25;
		start = 0;
		#10
		q = 2;
		#100;
		$stop;
	end
endmodule
