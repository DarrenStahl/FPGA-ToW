`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 	Carleton University
// Engineer:	Hasith Vidanamadura, Robert Nelson, Darren Stahl 
// 
// Create Date:    17:10:36 12/05/2013 
// Design Name:	Pixel Enable Generator
// Module Name:    pixel_enable 
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
module pixel_enable(
    input clk,
    input rst,
    output pixel_synch_en
    );
reg counter;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		counter = 0;
	end
else counter = ~counter;
	
end
assign pixel_synch_en = counter;

endmodule
