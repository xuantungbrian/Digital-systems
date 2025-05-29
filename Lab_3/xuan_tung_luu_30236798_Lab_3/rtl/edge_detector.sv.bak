module edge_detector (input logic async_sig, outclk, 
						output logic out_sync_sig);
	logic Q_1, Q1, Q2;
	FDC FDC_1 (out_sync_sig, ~outclk, 1'b0, Q_1); 
	FDC FDC1 (1'b1, async_sig, Q_1, Q1);
	FDC FDC2 (Q1, outclk, 1'b0, Q2);
	FDC FDC3 (Q2, outclk, 1'b0, out_sync_sig);	
endmodule


module FDC (input logic D, C, CLR, 
				output logic Q);
	always_ff @(posedge C, posedge CLR)
		if (CLR) Q <= 1'b0;
		else Q <= D;
endmodule
				
				
				
				
				
	