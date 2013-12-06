//*********************
//Hasith Vidanamadura
//100871538
//Darren Stahl
//100858939
//*********************
`timescale 1ms / 1ms
module LFSR(clk, rst, rand);
	input clk, rst;
	output rand;
	
	reg [9:0] lfsr;

	// LFSR x + x3 + x10
	always @(posedge clk or posedge rst)
		begin
   		if (rst) lfsr <= 1;
       	else 
			begin
				//shift
				lfsr[8:0] <= lfsr[9:1];
				//external logic
				lfsr[9]<=lfsr[3]^lfsr[0];
			end
		end

    // output logic
	assign rand = lfsr[2];

endmodule
