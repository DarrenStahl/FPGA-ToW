//*********************
//Hasith Vidanamadura
//100871538
//Darren Stahl
//100858939
//*********************
module PBL(rst, pbl, pbr, clear, push, tie, right);	
	
	// -- Inputs
	input rst, pbl, pbr, clear;
	// -- Outputs
	output push, tie, right;
	// -- Internals
	wire G, H;
	wire G_in, H_in;
	
	assign G_in = (pbl & ~H);
	assign H_in = (pbr & ~G);
	
	// Create two RSLatches
	RSLatch GLatch(G_in, rst, clear, G);
	RSLatch HLatch(H_in, rst, clear, H);
	
	// Output logic
	assign push = (H | G);
	assign tie = (G & H);
	assign right = (H & ~G) & ~(clear | rst);
endmodule

module RSLatch(trigger, rst, clr, Q);
	input trigger;
	input rst;
	input clr;
	output Q;
	
	wire x;
	
	assign x = (trigger | Q); assign Q = x & ~(clr | rst);
endmodule
