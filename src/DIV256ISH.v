/*
	Authors: Darren Stahl, Hasith Vidanamadura, Robert Nelson
    Date: December 6th 2013
*/

// =======================================================================================
// DIV_256ISH
//	- Divides the clock by 25000000 (That's close to 256, right?)
//----------------------------------------------------------------------------------------
`timescale 1ms / 1ms
module DIV256ISH(clk, rst, slowen);
	input clk, rst;
	output reg slowen;
	
	reg [24:0] count;

    // Output 1 if count == 0 (once per 255 clock cycles)
	always @(posedge clk)
		if (rst) count <= 0;
		else begin
			if (count == 25000000) begin 
				slowen <= 1; 
				count <= 0;
			end else begin
				count <= count + 1;
				slowen <= 0;
			end
		end

endmodule
