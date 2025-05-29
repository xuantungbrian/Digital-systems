module computeEncryptedByte_tb();
    logic start, clk, reset_n;
    logic [7:0] e_address;
    logic [7:0] e_q;
    logic [7:0] s_data;
    logic [7:0] s_address;
    logic s_wren;
    logic [7:0] s_q;
    logic [7:0] d_data;
    logic [7:0] d_address;
    logic d_wren;
    logic invalid_ascii;
    logic finish;

    computeEncryptedByte DUT(
        start, clk, reset_n,
        e_address,
        e_q,
        s_data,
        s_address,
        s_wren,
        s_q,
        d_data,
        d_address,
        d_wren,
        invalid_ascii,
        finish);

    initial begin
		clk = 0; #5;
		forever begin
			clk = 1; #5;
			clk = 0; #5;
		end
    end
        
    initial begin
        #2;
        e_q <= 8'd24;
        s_q <= 8'd85;
        reset_n <= 1'b1;
        start = 1'b1;
        #30;
        start = 1'b0;
        #300
        $stop;
	end
endmodule