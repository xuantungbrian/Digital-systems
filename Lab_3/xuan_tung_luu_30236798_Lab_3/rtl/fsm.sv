module fsm (input logic clk, flash_mem_waitrequest, flash_mem_readdatavalid, fsm_stim, stop,
				output logic [3:0]   flash_mem_byteenable,
				output logic flash_mem_read,
				output logic [2:0] state_num);
				
	logic [2:0] state;	
	assign state_num = state;
	
	always_ff @(posedge clk, posedge stop) 
		case (state)
			3'd0: if (fsm_stim && !stop) begin 								//idle
						state <= 3'd1;
						flash_mem_byteenable <= 4'b0;
						flash_mem_read <= 1'b1;
					end
					else begin
						state <= 3'd0; 
						flash_mem_byteenable <= 4'b0;
						flash_mem_read <= 1'b0;
					end
			3'd1: if (!flash_mem_waitrequest || stop) begin 		 //read request = 1
						state <= 3'd1;
						flash_mem_byteenable <= 4'b0;
						flash_mem_read <= 1'b1;
					end
					else if (flash_mem_readdatavalid) begin 
						state <= 3'd2;
						flash_mem_byteenable <= 4'b0011;
						flash_mem_read <= 1'b0;
					end
					else begin
						state <= 3'd1;
						flash_mem_byteenable <= 4'b0;
						flash_mem_read <= 1'b1;
					end
			3'd2: 	if (!flash_mem_readdatavalid) begin 			//read request = 0, change byteenable to read data
							state <= 3'd3;
							flash_mem_byteenable <= 4'b0;
							flash_mem_read <= 1'b0;
						end
						else begin
							state <= 3'd2;
							flash_mem_byteenable <= 4'b0011;
							flash_mem_read <= 1'b0;
						end
			3'd3: begin 														//transition state, do nothing
						state <= 3'd4;
						flash_mem_byteenable <= 4'b0;
						flash_mem_read <= 1'b0;
					end
			3'd4: 	if (fsm_stim && !stop) begin 						//idle
							state <= 3'd5;
							flash_mem_byteenable <= 4'b0;
							flash_mem_read <= 1'b1;
						end
						else begin
							state <= 3'd4; 
							flash_mem_byteenable <= 4'b0;
							flash_mem_read <= 1'b0;
						end
			3'd5: 	if (!flash_mem_waitrequest  || stop) begin 	//read request = 1
							state <= 3'd5;
							flash_mem_byteenable <= 4'b0;
							flash_mem_read <= 1'b1;
						end
						else if (flash_mem_readdatavalid) begin
							state <= 3'd6;
							flash_mem_byteenable <= 4'b1100;
							flash_mem_read <= 1'b0;
						end
						else begin
							state <= 3'd5;
							flash_mem_byteenable <= 4'b0;
							flash_mem_read <= 1'b1;
						end
			3'd6: 	if (!flash_mem_readdatavalid) begin 			//byteenable = 1100, start reading
							state <= 3'd7;
							flash_mem_byteenable <= 4'b0;
							flash_mem_read <= 1'b0;
						end
						else begin
							state <= 3'd6;
							flash_mem_byteenable <= 4'b1100;
							flash_mem_read <= 1'b0;
						end
			3'd7: begin															//transition state, do nothing
							state <= 3'd0;
							flash_mem_byteenable <= 4'b0;
							flash_mem_read <= 1'b0;
						end
			default: begin
							state <= 3'd0; 
							flash_mem_byteenable <= 4'b0;
							flash_mem_read <= 1'b0;
						end
		endcase
endmodule