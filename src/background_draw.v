`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:22:43 12/06/2013 
// Design Name: 
// Module Name:    background_draw 
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
module background_draw(
    input clk,
    input rst,
    input [9:0] hpos,
    input [9:0] vpos,
    input en,
	 output [7:0] out_color
    );
reg [7:0] rgb;
always @(posedge clk or posedge rst) begin
if (rst) rgb = 8'b0;
else begin
	if (en) begin
	if(vpos == 240)
		rgb = 8'b11100011;
	else if (vpos > 240) begin
		rgb = rgb & rgb[7:5] - 1;
	end
	else 
	rgb = 8'b0;
end
end
end
assign out_color = rgb;
endmodule
