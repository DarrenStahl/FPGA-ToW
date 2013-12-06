`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:15:26 12/05/2013
// Design Name:   pixel_enable
// Module Name:   C:/Users/Hasith/repos/ELEC3500-project/VGA-out/tb_pixel_enable_generator.v
// Project Name:  VGA-out
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pixel_enable
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_pixel_enable_generator;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire pixel_synch_en;

	// Instantiate the Unit Under Test (UUT)
	pixel_enable uut (
		.clk(clk), 
		.rst(rst), 
		.pixel_synch_en(pixel_synch_en)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		rst = 1;
		#10;
		rst = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		
	end
	
	
	always #5 clk = ~clk;
      
endmodule

