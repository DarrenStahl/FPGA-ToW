//*********************
//Hasith Vidanamadura
//100871538
//Darren Stahl
//100858939
//*********************
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
