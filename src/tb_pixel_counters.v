`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:47:08 12/05/2013
// Design Name:   vga_counter
// Module Name:   C:/Users/Hasith/repos/ELEC3500-project/VGA-out/tb_pixel_counters.v
// Project Name:  VGA-out
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga_counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_pixel_counters;

	// Inputs
	reg pixel_en;
	reg clk;
	reg rst;

	// Outputs
	wire [9:0] horiz_pixel_count;
	wire [9:0] vert_pixel_count;
	wire hOutValid;
	wire vOutValid;
	wire hSync;
	wire vSync;
	// Instantiate the Unit Under Test (UUT)
	vga_counter uut (
		.pixel_en(pixel_en), 
		.clk(clk), 
		.rst(rst), 
		.horiz_pixel_count(horiz_pixel_count), 
		.vert_pixel_count(vert_pixel_count),
		.hSync(hSync),
		.vSync(vSync),
		.vOutValid(vOutValid),
		.hOutValid(hOutValid)
	);

	initial begin
		// Initialize Inputs
		pixel_en = 0;
		clk = 0;
		rst = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
      rst = 1;
		#5;
		rst= 0;
		// Add stimulus here
		
	end
	
	always #5 clk = ~clk;
   always #10 pixel_en = ~pixel_en;   
endmodule

