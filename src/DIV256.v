//*********************
//Hasith Vidanamadura
//100871538
//Darren Stahl
//100858939
//*********************
`timescale 1ms / 1ms
module DIV256(clk, rst, slowen);
	input clk, rst;
	output reg slowen;
	
	reg [7:0] count;

	// Counter, resets at 255
	always @(posedge clk or posedge rst)
   		if (rst) count <= 1;
   		else count <= count + 1;


    // Output 1 if count == 0 (once per 255 clock cycles)
	always @(count)	
		if (count == 0) slowen = 1; else slowen = 0;

endmodule
