module shuffle(input logic start, clk, reset_n,
				input logic [7:0] q,
				input logic [23:0] secret_key,
				output logic [7:0] data, address,
				output logic finish, wren);
				
	logic [4:0] state /*synthesis keep*/;
	logic [7:0] temp_val_i, temp_addr_i, temp_val_j, temp_addr_j;
	
	
	//state = {padding[1:0], wren, finish}
	parameter idle = 5'b00000;
	parameter wait_s_i = 5'b00100;
	parameter read_s_i = 5'b01000;
	parameter wait_s_j = 5'b01100;
	parameter read_s_j = 5'b10000;
	parameter write_s_ij = 5'b00010;
	parameter counting = 5'b01010;
	parameter done = 5'b00001;
	
	
	assign finish = state[0];
	assign wren = state[1];
	
	
	always_ff @(posedge clk, negedge reset_n)
		if(!reset_n) state <= idle;
		else 
		case(state)
			idle: 		if (start) begin
								state <= read_s_i;
								data <= 0;
								address <= 0;
							end
							else begin	
								state <= idle;
								data <= 0;
								address <= 0;
								temp_val_i <= 0;
								temp_addr_i <= 0;
								temp_val_j <= 0;
								temp_addr_j <= 0;
							end
			wait_s_i:	state <= read_s_i;
			read_s_i: 	begin
								state <= wait_s_j;
								temp_val_i <= q;
								temp_addr_i <= address;
								case(address%3)
									8'd0:		begin
													temp_addr_j <= temp_addr_j + q + secret_key[23:16]; //change based on secret key
													address <= temp_addr_j + q + secret_key[23:16];
												end
									8'd1: 	begin
													temp_addr_j <= temp_addr_j + q + secret_key[15:8];
													address <= temp_addr_j + q + secret_key[15:8];
												end
									8'd2: 	begin	
													temp_addr_j <= temp_addr_j + q + secret_key[7:0];
													address <= temp_addr_j + q + secret_key[7:0];
												end
									default:	begin
													temp_addr_j <= temp_addr_j + q + 0; //change based on secret key
													address <= temp_addr_j + q + 0;
												end
								endcase
							end
			wait_s_j:	state <= read_s_j;
			read_s_j:	begin
								state <= write_s_ij; 
								data <= temp_val_i;
								temp_val_j <= q;
							end
			write_s_ij:	begin
								state <= counting; 
								data <= temp_val_j;
								address <= temp_addr_i;
							end	
			counting: 	if (address >= 8'd255) begin	
								state <= done;
								data <= 0;
								address <= 0;
							end
							else begin
								state <= wait_s_i;
								address <= address + 1'b1;
							end
			done: 		begin
								state <= idle;
								data <= 0;
								address <= 0;
								temp_val_i <= 0;
								temp_addr_i <= 0;
								temp_val_j <= 0;
								temp_addr_j <= 0;
							end
			default: 	begin 
								state <= idle;
								data <= 0;
								address <= 0;
								temp_val_i <= 0;
								temp_addr_i <= 0;
								temp_val_j <= 0;
								temp_addr_j <= 0;
							end
		endcase
	
endmodule