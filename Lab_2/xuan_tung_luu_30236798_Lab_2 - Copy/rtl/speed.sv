module speed(input logic speed_up_event, speed_down_event, speed_reset_event, clk,
					output logic [31:0] div_clk_count);
	logic lock;
	always_ff @(posedge clk)
		if (!lock) begin
			lock <= 1;
			div_clk_count <= 32'd613;
		end
		else if (speed_up_event)
			div_clk_count <= div_clk_count - 32'd10;
		else if (speed_down_event)
			div_clk_count <= div_clk_count + 32'd10;
		else if (speed_reset_event)
			div_clk_count <= 32'd613;
		else
			div_clk_count <= div_clk_count;
endmodule