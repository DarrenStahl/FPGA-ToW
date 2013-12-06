`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:43:14 11/25/2013
// Design Name:   Top
// Module Name:   W:/Documents/ELEC3500/TOW_FINAL/top_tb.v
// Project Name:  TOW_FINAL
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_tb;
	`define dark 7'b0000000
	// Inputs
	reg clk;
	reg rst;
	reg pbl;
	reg pbr;

	// Outputs
	wire [6:0] leds_out;
	reg [6:0] running_score;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.rst(rst), 
		.pbl(pbl), 
		.pbr(pbr), 
		.leds_out(leds_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		pbl = 0;
		pbr = 0;
		running_score = 7'b0000000;

		// Wait 100 ns for global reset to finish
		#100;
		reset();
		
		// Test left wins
		push_left(0, 7'b0001000);
		push_left(0, running_score);
		push_left(0, running_score);
		push_left(0, running_score);	
		$display("Testing left win complete!");
		reset();

		// Test right wins
		push_right(0, 7'b0001000);
		push_right(0, running_score);
		push_right(0, running_score);
		push_right(0, running_score);
		$display("Testing right win complete!");	
		reset();
		
		// Test left jumping
		push_left(1, 7'b0001000);
		push_left(1, running_score);
		push_left(1, running_score);
		push_left(1, running_score);	
		$display("Testing right win by left jumping complete!");
		reset();
		
		// Test right jumping
		push_right(1, 7'b0001000);
		push_right(1, running_score);
		push_right(1, running_score);
		push_right(1, running_score);
		$display("Testing left win by right jumping complete!");			
		reset();
		
		// Test Favour the Loser Logic
		push_left(0, 7'b0001000);
		push_left(0, running_score);
		push_left(0, running_score);
		push_right(0, running_score);
		push_right(0, running_score);
		push_right(0, running_score);
		push_right(0, running_score);
		push_left(0, running_score);
		push_left(0, running_score);
		$display("Testing left and right FTL complete!");
		reset();
		
		// Test ties on left side
		push_left(0, 7'b0001000);
		tie();
		push_left(0, running_score);
		tie();
		push_left(0, running_score);
		tie();
		$display("Testing left ties complete!");		
		reset();
		
		// Test ties on right side
		push_right(0, 7'b0001000);
		tie();
		push_right(0, running_score);
		tie();
		push_right(0, running_score);
		tie();
		$display("Testing right ties complete!");				
		
		
		$finish;
	end
   always #20 clk = ~clk;
   
	
	// Test a tie
	task tie;
	begin
			wait(leds_out == `dark);
			#2;
   		wait(leds_out == 7'b1111111);
			#2;
			pbl=1;pbr=1;
			wait(leds_out == running_score);
			#2;
			pbl=0;pbr=0;
	end
	endtask
	
	task reset;
	begin
		rst=1;
		wait(leds_out == `dark);
		rst=0;
		wait(leds_out == 7'b1001101);
	end
	endtask
	task push_left;
	input jmp;
	input reg[6:0]score;

	begin
		//PUSH INPUT
		wait(leds_out == `dark);
		if (~jmp)
			wait(leds_out == 7'b1111111);
		#2;
		pbl=1;

		case(score)
		7'b1110000:	wait(leds_out == 7'b1110000);
		7'b1000000: wait((~jmp && leds_out == 7'b1110000) | (jmp && leds_out == 7'b0100000));
		7'b0100000: wait((~jmp && leds_out == 7'b1000000) | (jmp && leds_out == 7'b0010000));
		7'b0010000: wait((~jmp && leds_out == 7'b0100000) | (jmp && leds_out == 7'b0001000));
		7'b0001000: wait((~jmp && leds_out == 7'b0010000) | (jmp && leds_out == 7'b0000100));
		7'b0000100: wait((~jmp && leds_out == 7'b0001000) | (jmp && leds_out == 7'b0000010));
		7'b0000010: wait((~jmp && leds_out == 7'b0000100) | (jmp && leds_out == 7'b0000001));
		7'b0000001: wait((~jmp && leds_out == 7'b0000100) | (jmp && leds_out == 7'b0000111));
		7'b0000111: wait(leds_out == 7'b0000111);
		endcase
		running_score = leds_out;
		pbl=0;
		
	end
	endtask
		task push_right;
	input jmp;
	input reg[6:0]score;

	begin
		//PUSH INPUT
		wait(leds_out == `dark);
		if (~jmp)
			wait(leds_out == 7'b1111111);
		#2;
		pbr=1;

		case(score)
		7'b1110000:	wait(leds_out == 7'b1110000);
		7'b1000000: wait((jmp && leds_out == 7'b1110000) | (~jmp && leds_out == 7'b0010000));
		7'b0100000: wait((jmp && leds_out == 7'b1000000) | (~jmp && leds_out == 7'b0010000));
		7'b0010000: wait((jmp && leds_out == 7'b0100000) | (~jmp && leds_out == 7'b0001000));
		7'b0001000: wait((jmp && leds_out == 7'b0010000) | (~jmp && leds_out == 7'b0000100));
		7'b0000100: wait((jmp && leds_out == 7'b0001000) | (~jmp && leds_out == 7'b0000010));
		7'b0000010: wait((jmp && leds_out == 7'b0000100) | (~jmp && leds_out == 7'b0000001));
		7'b0000001: wait((jmp && leds_out == 7'b0000010) | (~jmp && leds_out == 7'b0000111));
		7'b0000111: wait(leds_out == 7'b0000111);
		endcase
		running_score = leds_out;
		pbr=0;
		
	end
	endtask
	
endmodule

