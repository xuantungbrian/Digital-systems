module note_selector (input logic CLK_50M, input logic [9:0] SW,
								output logic sel_note, output logic [23:0] sel_note_name);
								
	//numbers
	parameter character_0 =8'h30;
	parameter character_1 =8'h31;
	parameter character_2 =8'h32;
	parameter character_3 =8'h33;
	parameter character_4 =8'h34;
	parameter character_5 =8'h35;
	parameter character_6 =8'h36;
	parameter character_7 =8'h37;
	parameter character_8 =8'h38;
	parameter character_9 =8'h39;


	//Uppercase Letters
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

	//Lowercase Letters
	parameter character_lowercase_a= 8'h61;
	parameter character_lowercase_b= 8'h62;
	parameter character_lowercase_c= 8'h63;
	parameter character_lowercase_d= 8'h64;
	parameter character_lowercase_e= 8'h65;
	parameter character_lowercase_f= 8'h66;
	parameter character_lowercase_g= 8'h67;
	parameter character_lowercase_h= 8'h68;
	parameter character_lowercase_i= 8'h69;
	parameter character_lowercase_j= 8'h6A;
	parameter character_lowercase_k= 8'h6B;
	parameter character_lowercase_l= 8'h6C;
	parameter character_lowercase_m= 8'h6D;
	parameter character_lowercase_n= 8'h6E;
	parameter character_lowercase_o= 8'h6F;
	parameter character_lowercase_p= 8'h70;
	parameter character_lowercase_q= 8'h71;
	parameter character_lowercase_r= 8'h72;
	parameter character_lowercase_s= 8'h73;
	parameter character_lowercase_t= 8'h74;
	parameter character_lowercase_u= 8'h75;
	parameter character_lowercase_v= 8'h76;
	parameter character_lowercase_w= 8'h77;
	parameter character_lowercase_x= 8'h78;
	parameter character_lowercase_y= 8'h79;
	parameter character_lowercase_z= 8'h7A;
	
	logic Do1, Re, Mi, Fa, Sol, La, Si, Do2;
	logic [2:0] sel;
	assign sel = SW[3:1];

	//Do1 (523Hz)
	Clk_divider  
	Gen_Do1
	(
	.inclk(CLK_50M),
	.outclk(Do1),
	.outclk_Not(),
	.div_clk_count(32'hBAB9), //change this if necessary to suit your module
	.Reset(1'h1)); 

	//Re (587Hz)
	Clk_divider 
	Gen_Re
	(
	.inclk(CLK_50M),
	.outclk(Re),
	.outclk_Not(),
	.div_clk_count(32'hA65D), //change this if necessary to suit your module
	.Reset(1'h1)); 

	//Mi (659Hz)
	Clk_divider  
	Gen_Mi
	(
	.inclk(CLK_50M),
	.outclk(Mi),
	.outclk_Not(),
	.div_clk_count(32'h9430), //change this if necessary to suit your module
	.Reset(1'h1)); 

	//Fa (698Hz)
	Clk_divider 
	Gen_Fa
	(
	.inclk(CLK_50M),
	.outclk(Fa),
	.outclk_Not(),
	.div_clk_count(32'h8BE9), //change this if necessary to suit your module
	.Reset(1'h1)); 

	//Sol (783Hz)
	Clk_divider 
	Gen_Sol
	(
	.inclk(CLK_50M),
	.outclk(Sol),
	.outclk_Not(),
	.div_clk_count(32'h7CB8), //change this if necessary to suit your module
	.Reset(1'h1)); 

	//La (880Hz)
	Clk_divider  
	Gen_La
	(
	.inclk(CLK_50M),
	.outclk(La),
	.outclk_Not(),
	.div_clk_count(32'h6EF9), //change this if necessary to suit your module
	.Reset(1'h1)); 

	//Si (987Hz)
	Clk_divider 
	Gen_Si
	(
	.inclk(CLK_50M),
	.outclk(Si),
	.outclk_Not(),
	.div_clk_count(32'h62F1), //change this if necessary to suit your module
	.Reset(1'h1)); 

	//Do2 (1046Hz)
	Clk_divider 
	Gen_Do2
	(
	.inclk(CLK_50M),
	.outclk(Do2),
	.outclk_Not(),
	.div_clk_count(32'h5D5D), //change this if necessary to suit your module
	.Reset(1'h1)); 


	always_ff @(posedge CLK_50M)
		case (sel)
			3'd0: begin
						sel_note <= Do1;
						sel_note_name <= {character_D, character_lowercase_o, character_1};
					end
			3'd1: begin
						sel_note <= Re;
						sel_note_name <= {character_R, character_lowercase_e};
					end
			3'd2: begin
						sel_note <= Mi;
						sel_note_name <= {character_M, character_lowercase_i};
					end
			3'd3: begin
						sel_note <= Fa;
						sel_note_name <= {character_F, character_lowercase_a};
					end
			3'd4: begin
						sel_note <= Sol;
						sel_note_name <= {character_S, character_lowercase_o, character_lowercase_l};
					end	
			3'd5: begin 
						sel_note <= La;
						sel_note_name <= {character_L, character_lowercase_a};
					end
			3'd6: begin
						sel_note <= Si;
						sel_note_name <= {character_S, character_lowercase_i};
					end
			3'd7: begin
						sel_note <= Do2;
						sel_note_name <= {character_D, character_lowercase_o, character_2};
					end
			default: begin
							sel_note <= 1'bx;
							sel_note_name <= {character_N, character_lowercase_o, character_lowercase_n, character_lowercase_e};
						end
		endcase
endmodule