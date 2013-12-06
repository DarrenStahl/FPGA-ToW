`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:18:09 12/06/2013 
// Design Name: 
// Module Name:    divider_draw 
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
module divider_draw(
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
else if (en) begin
	if (hpos >319 && hpos < 321 && vpos & 10'd4) rgb = 8'b11111111;
	else rgb = 8'b0;
end
end
assign out_color = rgb;
endmodule
