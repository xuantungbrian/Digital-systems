module LFSR_tb();
	logic clk;
	logic [4:0] lfsr;
	LFSR DUT(.clk(clk), .lfsr(lfsr));
	
	initial begin
		forever begin
			clk = 0; #5;
			clk = 1; #5;
		end
	end

	initial begin
		#300;
		$stop;
	end
endmodule
