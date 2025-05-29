module fsm_addr(input logic clk, input logic [7:0] kbd_received_ascii_code,
					output logic [22:0] addr, output logic stopp);
	parameter normal = 2'b01;
	parameter backward = 2'b10;
	parameter stop = 2'b11;
	
	parameter character_A =8'h41;
	parameter character_B =8'h42;
	parameter character_C =8'h43;
	parameter character_D =8'h44;
	parameter character_E =8'h45;
	parameter character_F =8'h46;
	parameter character_G =8'h47;
	parameter character_H =8'h48;
	parameter character_I =8'h49;
	parameter character_J =8'h4A;
	parameter character_K =8'h4B;
	parameter character_L =8'h4C;
	parameter character_M =8'h4D;
	parameter character_N =8'h4E;
	parameter character_O =8'h4F;
	parameter character_P =8'h50;
	parameter character_Q =8'h51;
	parameter character_R =8'h52;
	parameter character_S =8'h53;
	parameter character_T =8'h54;
	parameter character_U =8'h55;
	parameter character_V =8'h56;
	parameter character_W =8'h57;
	parameter character_X =8'h58;
	parameter character_Y =8'h59;
	parameter character_Z =8'h5A;
	
	
	logic direction;
	logic [1:0] state;
	reg count = 1'b0;
	
	always_ff @(posedge clk)  
		case (state)
			normal: if (kbd_received_ascii_code == character_B) begin//pressing B at normal state
							state <= backward;
							direction <= 1;
							stopp <= 0;
							count <= ~count;
							if (addr == 0 && count == 0)
								addr = 23'h7FFFF;
							else if (count)
								addr <= addr - 1'h1;
							else 
								addr <= addr;
						end
						else if (kbd_received_ascii_code == character_D) begin//pressing D at normal state
							state <= stop;
							direction <= direction;
							addr <= addr;
							stopp <= 1;
							count <= count;
						end
						else begin //no keys or unimportant keys pressed at normal state
							state <= state;
							direction <= direction;
							count <= ~count;
							stopp <= 0;
							if (addr == 23'h7FFFF && count == 1)
								addr <= 0;
							else if (count)
								addr <= addr + 1'h1;
							else 
								addr <= addr;
						end
						
			backward: if (kbd_received_ascii_code == character_F) begin //pressing F at backward state
							state <= normal;
							direction <= 0;
							stopp <= 0;
							count <= ~count;
							if (addr == 23'h7FFFF && count == 1)
								addr <= 0;
							else if (count)
								addr <= addr + 1'h1;
							else 
								addr <= addr;
						end
						else if (kbd_received_ascii_code == character_D) begin //pressing D at backward state
							state <= stop;
							direction <= direction;
							addr <= addr;
							stopp <= 1;
						end
						else begin //no keys or unimportant keys pressed at backward state
							count <= ~count;
							state <= state;
							direction <= direction;
							stopp <= 0;
							if (addr == 0 && count == 0)
								addr = 23'h7FFFF;
							else if (count)
								addr <= addr - 1'h1;
							else 
								addr <= addr;
						end
						
			stop: if (kbd_received_ascii_code == character_E && direction == 1) begin //pressing E at stop state
						state <= backward;															  		 //with direction backward
						direction <= direction;
						if (addr == 0)
							addr = 23'h7FFFF;
						else
							addr <= addr - 1'h1;
						stopp <= 0;
					end
					else if (kbd_received_ascii_code == character_E && direction == 0) begin //pressing E at stop state
						state <= normal;																		 //with direction forward
						direction <= direction;
						if (addr == 23'h7FFFF)
							addr <= 0;
						else
							addr <= addr + 1'h1;
						stopp <= 0;
					end
					else if (kbd_received_ascii_code == character_B) begin
						direction <= 1;
					end
					else if (kbd_received_ascii_code == character_F) begin
						direction <= 0;
					end
					else begin //no keys or unimportant keys pressed at stop state
						state <= stop;
						direction <= direction;
						addr <= addr;
						stopp <= 1;
					end
			default: begin //default, also the state at the beginning
							state <= stop;
							direction <= 0;
							addr <= 0;
							stopp <= 1;
							count <= count;
						end	
		endcase
endmodule