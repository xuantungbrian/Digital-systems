module fsm_tb ();
	logic clk, flash_mem_waitrequest, flash_mem_readdatavalid, fsm_stim, stop;
	logic [3:0]   flash_mem_byteenable;
	logic flash_mem_read;
	
	fsm DUT(
	.clk(clk), 
	.fsm_stim(fsm_stim),
	.flash_mem_waitrequest(flash_mem_waitrequest),
	.flash_mem_readdatavalid(flash_mem_readdatavalid),
	.flash_mem_byteenable(flash_mem_byteenable),
	.flash_mem_read(flash_mem_read),
	.stop(stop));
	
	initial begin //create clock wave until $stop
		clk = 0; #5;
		forever begin
			clk=1; #5;
			clk=0; #5;
		end
	end
	
	initial begin
		fsm_stim = 1'b1;
		stop = 1'b0;
		flash_mem_waitrequest = 1'b0;
		flash_mem_readdatavalid = 1'b0;

		#20;

		flash_mem_waitrequest = 1'b1;

		#10

		flash_mem_waitrequest = 1'b0;
		flash_mem_readdatavalid = 1'b1;
		fsm_stim = 1'b0;

		#10

		flash_mem_readdatavalid = 1'b0;

		#40

		fsm_stim = 1'b1;
		stop = 1'b0;
		flash_mem_waitrequest = 1'b0;
		flash_mem_readdatavalid = 1'b0;

		#20;

		flash_mem_waitrequest = 1'b1;

		#10

		flash_mem_waitrequest = 1'b0;
		flash_mem_readdatavalid = 1'b1;
		fsm_stim = 1'b0;

		#10

		flash_mem_readdatavalid = 1'b0;
		
		#30
		fsm_stim = 1'b1;
		stop = 1'b1;
		#30
		$stop;
	end
endmodule