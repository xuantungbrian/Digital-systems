`default_nettype none
module ksa2(

    //////////// CLOCK //////////
    CLOCK_50,
	 
    //////////// LED //////////
    LEDR,

    //////////// KEY //////////
    KEY,

    //////////// SW //////////
    SW,

    //////////// SEG7 //////////
    HEX0,
    HEX1,
    HEX2,
    HEX3,
    HEX4,
    HEX5,
);

`define zero_pad(width,signal)  {{((width)-$size(signal)){1'b0}},(signal)}
//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input                       CLOCK_50;

//////////// LED //////////
output           [9:0]      LEDR;

//////////// KEY //////////
input            [3:0]      KEY;

//////////// SW //////////
input            [9:0]      SW;

//////////// SEG7 //////////
output           [6:0]      HEX0;
output           [6:0]      HEX1;
output           [6:0]      HEX2;
output           [6:0]      HEX3;
output           [6:0]      HEX4;
output           [6:0]      HEX5;

logic clk;
logic reset_n;

assign clk = CLOCK_50;
assign reset_n = KEY[3];

//Start lab 4
//=====================================================================================================

logic start_init, finish_init, wren_init;
logic [7:0] data_init, address_init;

initializer S_INIT(
	.start(start_init), 
	.clk(clk),
	.reset_n(reset_n),
	.data(data_init),
	.wren(wren_init),
	.address(address_init),
	.q(s_q),
	.finish(finish_init));
		
logic start_shuffle, finish_shuffle, wren_shuffle;
logic [7:0] data_shuffle, address_shuffle;

shuffle SHUFFLE(
	.start(start_shuffle), 
	.clk(clk),
	.reset_n(reset_n),
	.data(data_shuffle),
	.wren(wren_shuffle),
	.address(address_shuffle),
	.q(s_q),
	.secret_key(secret_key),
	.finish(finish_shuffle));
	
logic start_compute, finish_compute, wren_s_compute;
logic [7:0] data_s_compute, address_s_compute;

logic invalid_ascii;

computeEncryptedByte COMPUTE(
	.start(start_compute),
	.clk(clk),
	.reset_n(reset_n),
	.e_address(e_address),
	.e_q(e_q),
	.s_data(data_s_compute),
	.s_address(address_s_compute),
	.s_wren(wren_s_compute),
	.s_q(s_q),
	.d_data(d_data),
	.d_address(d_address),
	.d_wren(d_wren),
	.invalid_ascii(invalid_ascii),
	.finish(finish_compute));

logic [7:0] e_address, e_q;
	
encrypted_rom E(
	.address(e_address),
	.clock(clk),
	.q(e_q));
	
logic s_wren;
logic [7:0] s_data, s_address, s_q;

assign s_wren = wren_init | wren_shuffle | wren_s_compute;
assign s_data = data_init | data_shuffle | data_s_compute;
assign s_address = address_init | address_shuffle | address_s_compute;
		
s_memory S(
	.address(s_address),
	.clock(clk),
	.data(s_data),
	.wren(s_wren),
	.q(s_q));

logic d_wren;
logic [7:0] d_data, d_address, d_q;

d_memory D( // decrypted output
	.address(d_address),
	.clock(clk),
	.data(d_data),
	.wren(d_wren),
	.q(d_q));

logic [23:0] secret_key = 24'b0;

main_fsm MAIN( //main state machine that controls other fsm
	.clk(clk),
	.reset_n(reset_n), 
	.finish_compute(finish_compute), 
	.finish_init(finish_init),
	.finish_shuffle(finish_shuffle),
	.invalid_ascii(invalid_ascii),
	.start_init(start_init),
	.start_shuffle(start_shuffle), 
	.start_compute(start_compute),
	.LEDR(LEDR),
	.secret_key(secret_key));
	
		
SevenSegmentDisplayDecoder HEX_0 (.nIn(secret_key[3:0]), .ssOut(HEX0));
SevenSegmentDisplayDecoder HEX_1 (.nIn(secret_key[7:4]), .ssOut(HEX1));
SevenSegmentDisplayDecoder HEX_2 (.nIn(secret_key[11:8]), .ssOut(HEX2));
SevenSegmentDisplayDecoder HEX_3 (.nIn(secret_key[15:12]), .ssOut(HEX3));
SevenSegmentDisplayDecoder HEX_4 (.nIn(secret_key[19:16]), .ssOut(HEX4));
SevenSegmentDisplayDecoder HEX_5 (.nIn(secret_key[23:20]), .ssOut(HEX5));

endmodule

