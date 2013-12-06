`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:24:44 12/05/2013 
// Design Name: 
// Module Name:    tone_generator 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module tone_generator(
    input clk,
    input rst,
    input [3:0] tone,
    output reg out
    );

	// Define all of the frequency pairs (tone -> freq)
	// C Major should be good enough
	`define TONE_NONE 0
	`define TONE_C3 1
	`define FREQ_C3 131
	`define TONE_D3 2
	`define FREQ_D3 147
	`define TONE_E3 3
	`define FREQ_E3 165
	`define TONE_F3 4
	`define FREQ_F3 175
	`define TONE_G3 5
	`define FREQ_G3 196
	`define TONE_A3 6
	`define FREQ_A3 220
	`define TONE_B3 7
	`define FREQ_B3 247
	`define TONE_C4 8
	`define FREQ_C4 262
	`define TONE_D4 9
	`define FREQ_D4 294
	`define TONE_E4 10
	`define FREQ_E4 330
	`define TONE_F4 11
	`define FREQ_F4 349
	`define TONE_G4 12
	`define FREQ_G4 392
	`define TONE_A4 13
	`define FREQ_A4 440
	`define TONE_B4 14
	`define FREQ_B4 494
	`define TONE_C5 15
	`define FREQ_C5 523
	

	// Counts assuming a CLK_FREQ of 50000000
	`define COUNT_C3 381679
	`define COUNT_D3 340136
	`define COUNT_E3 303030
	`define COUNT_F3 285714
	`define COUNT_G3 255102
	`define COUNT_A3 227272
	`define COUNT_B3 202429
	`define COUNT_C4 190839
	`define COUNT_D4 170068
	`define COUNT_E4 151515
	`define COUNT_F4 143266
	`define COUNT_G4 127551
	`define COUNT_A4 113636
	`define COUNT_B4 101214
	`define COUNT_C5 95602
	
	// TODO: Deal with proper clock frequency. Assuming 50 MHz
	`define CLK_FREQ 50000000
	
	reg [18:0] count; // Smallest space needed to hold 381679)
	
	initial begin
		out <= 0;
		count <= 0;
	end
	
	always @ (posedge rst or posedge clk)
		if (rst) begin
			count <= 0;
			out <= 0;
		end else
			case (tone)
				`TONE_NONE: begin
					count <= 0;
					out <= 0;
					end
				`TONE_C3: begin
						count <= count + 1;
						if (count >= `TONE_C3) begin
							out <= ~out;
							count <= 0;
						end
					end
				`TONE_D3: begin
						count <= count + 1;
						if (count >= `TONE_D3) begin
							out <= ~out;
							count <= 0;
						end
					end
				`TONE_E3: begin
						count <= count + 1;
						if (count >= `TONE_E3) begin
							out <= ~out;
							count <= 0;
						end
					end
				`TONE_F3: begin
						count <= count + 1;
						if (count >= `TONE_F3) begin
							out <= ~out;
							count <= 0;
						end
					end
				`TONE_G3: begin
						count <= count + 1;
						if (count >= `TONE_G3) begin
							out <= ~out;
							count <= 0;
						end
					end
				`TONE_A3: begin
						count <= count + 1;
						if (count >= `TONE_A3) begin
							out <= ~out;
							count <= 0;
						end
					end
				`TONE_B3: begin
						count <= count + 1;
						if (count >= `TONE_B3) begin
							out <= ~out;
							count <= 0;
						end
					end
				`TONE_C4: begin
						count <= count + 1;
						if (count >= `TONE_C4) begin
							out <= ~out;
							count <= 0;
						end
					end
				`TONE_D4: begin
						count <= count + 1;
						if (count >= `TONE_D4) begin
							out <= ~out;
							count <= 0;
						end
					end
				`TONE_E4: begin
						count <= count + 1;
						if (count >= `TONE_E4) begin
							out <= ~out;
							count <= 0;
						end
					end
				`TONE_F4: begin
						count <= count + 1;
						if (count >= `TONE_F4) begin
							out <= ~out;
							count <= 0;
						end
					end
				`TONE_G4: begin
						count <= count + 1;
						if (count >= `TONE_G4) begin
							out <= ~out;
							count <= 0;
						end
					end
				`TONE_A4: begin
						count <= count + 1;
						if (count >= `TONE_A4) begin
							out <= ~out;
							count <= 0;
						end
					end
				`TONE_B4: begin
						count <= count + 1;
						if (count >= `TONE_B4) begin
							out <= ~out;
							count <= 0;
						end
					end
				`TONE_C5: begin
						count <= count + 1;
						if (count >= `TONE_C5) begin
							out <= ~out;
							count <= 0;
						end
					end

			endcase

endmodule

