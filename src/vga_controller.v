`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:35:00 12/06/2013 
// Design Name: 
// Module Name:    vga_controller 
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
module vga_controller(
    input clk,
    input rst,
    output hSync,
    output vSync,
	 output [9:0] hpos,
	 output [9:0] vpos,
	 output pixel_on
    );
wire hOk;
wire vOk;
reg [7:0] rgb;
pixel_enable pixen(clk, rst, pix_en);
vga_counter vga_counter_block(.clk(clk), .rst(rst), .pixel_en(pix_en), .hSync(hSync), .vSync(vSync), .horiz_pixel_count(hpos), .vert_pixel_count(vpos), .hOutValid(hOk), .vOutValid(vOk));

assign pixel_on = hOk && vOk;

endmodule
