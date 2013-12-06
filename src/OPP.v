/*
	Authors: Darren Stahl, Hasith Vidanamadura, Robert Nelson
    Date: December 6th 2013
*/

// =======================================================================================
// One Push per Pulse
//	- Transforms a syncronized push to a one clock cycle pulse
//----------------------------------------------------------------------------------------
module OPP(clk, rst, sypush, winrnd);
		// -- Inputs
		input clk, rst, sypush;
		// -- Outputs
		output winrnd;
		// -- Internals
		reg q;
		
		//One pulse per push
		assign winrnd = !q & sypush;
		
		//Latch old sypush
		always@(posedge clk)
			if (!rst) q <= sypush;
			else q <= 0;
endmodule
