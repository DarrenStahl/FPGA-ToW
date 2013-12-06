`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:22:21 12/06/2013 
// Design Name: 
// Module Name:    player_draw 
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
module player_draw(
    input clk,
    input rst,
    input en,
	 input [9:0] hpos,
    input [9:0] vpos,
	 input [9:0] start,
    input [7:0] player_color,
    output[7:0] out_color
	 );
reg [7:0] rgb;
always @(posedge clk or posedge rst) begin
	if (rst) rgb = 0;
	else if (en) begin
		if(vpos > 200 && vpos < 240 && hpos > start && hpos < (start + 60))
			rgb = player_color;
		else
			rgb = 0;
		end
	end
	
assign out_color = rgb;

endmodule
