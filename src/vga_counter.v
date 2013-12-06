`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:39:22 12/05/2013 
// Design Name: 
// Module Name:    vga_counter 
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
module vga_counter(
    input pixel_en,
    input clk,
    input rst,
    output [9:0] horiz_pixel_count,
    output [9:0] vert_pixel_count,
	 output reg hSync,
	 output reg vSync,
    output reg vOutValid,
	 output reg hOutValid
	 );
	 
reg [9:0] horiz_counter;
wire en;
reg [9:0] vert_counter;

always @(posedge clk or posedge rst)begin
	if (rst) begin horiz_counter = 0; end
	else if (pixel_en) begin
		horiz_counter = horiz_counter + 1;
		if (horiz_counter == 10'd800) begin
			horiz_counter = 10'd0;
		end
	end


end

always @(posedge clk or posedge rst) begin
	if (rst) vert_counter = 10'd0;
	else begin
	if (en && pixel_en) begin
		vert_counter = vert_counter + 1;
		if (vert_counter == 10'd525)
			vert_counter = 10'd0;
	end
	end
end

always @(posedge clk or posedge rst) begin
if (rst) begin hSync = 1; hOutValid = 1; end
else begin
	case (horiz_counter)
	10'd0: begin hSync = 1; hOutValid = 1; end
	10'd640: hOutValid = 0;
	10'd660: hSync = 0;
	10'd756: hSync = 1;
	endcase
end
end



always @(posedge clk or posedge rst) begin
if (rst) begin vSync = 1; vOutValid = 1; end
else begin
	case (vert_counter)
	10'd0: begin vSync = 1; vOutValid = 1;end
	10'd480: vOutValid = 0;
	10'd494: vSync = 0;
	10'd495: vSync = 1;
	endcase
end
end

assign horiz_pixel_count = (horiz_counter ^ hOutValid );
assign vert_pixel_count = (vert_counter);

assign en = (horiz_counter == 10'd660);

endmodule
