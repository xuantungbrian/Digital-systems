module main_DDS_tb();
	logic clk;
	logic reset;
	reg [11:0] sin_out = 12'b0;
	reg [11:0] cos_out = 12'b0;
	reg [11:0] squ_out = 12'b0;
	reg [11:0] saw_out = 12'b0; 

	waveform_gen DUT( 
	.clk(clk),
	.reset(reset),
	.en(1'b1),
	.phase_inc(32'd258),
	.sin_out(sin_out),
	.cos_out(cos_out),
	.squ_out(squ_out),
	.saw_out(saw_out)); 

	initial begin
		forever begin
			clk = 0; #1;
			clk = 1; #1;
		end
	end

	initial begin
		reset = 1; #1;
		reset = 0; #5;
		reset = 1;
	end
endmodule
