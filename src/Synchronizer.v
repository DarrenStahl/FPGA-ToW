//*********************
//Hasith Vidanamadura
//100871538
//Darren Stahl
//100858939
//*********************
module Synchronizer(clk, rst, push, sypush);
		// -- Inputs
		input clk, rst, push;
		// -- Outputs
		output reg sypush;
		
		//Pass signal through a d-flip-flop
		always@(posedge clk)
			if (!rst) sypush <= push;
			else sypush <= 0;
endmodule
