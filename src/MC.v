//*********************
//Hasith Vidanamadura
//100871538
//Darren Stahl
//100858939
//*********************
`timescale 1ms / 1ms
module MC(clk, rst, winrnd, slowen, rand, leds_on, clear, led_control);
	`define RESET     0
	`define Wait_a    1
   `define Wait_b    2
	`define Dark_Rand 3 
	`define Play      4
	`define Gloat_a   5
	`define Gloat_b   6
	
	`define All_off    0
	`define All_on     1
	`define Curr_score 2
	`define Student_number 3
	input clk, rst, winrnd, slowen, rand;
	output reg leds_on, clear;
	output reg [1:0] led_control;
	
	reg [2:0] state;
	reg [2:0] nxtstate;

	// SYNCHRONOUS STATE ASSIGNMENT ---------------------------------------------
	always @(posedge clk or posedge rst)
   		if (rst) state <= `RESET;
   		else state <= nxtstate;
	

	// Setting of nxtstate
	always @(slowen or state or winrnd or rand) begin
		nxtstate = state;
		case(state)
		`RESET: nxtstate = `Wait_a;
		`Wait_a: if(slowen) nxtstate = `Wait_b;
		`Wait_b: if (slowen) nxtstate = `Dark_Rand;
		`Dark_Rand: if(winrnd) nxtstate = `Gloat_a; else if(rand) nxtstate = `Play;
		`Play: if(winrnd) nxtstate = `Gloat_a;
		`Gloat_a: if (slowen) nxtstate = `Gloat_b;
		`Gloat_b: if (slowen) nxtstate = `Dark_Rand;
		default: nxtstate = `RESET;
		endcase
    end


    // output logic
	always @(state)	begin
		leds_on = 0; clear = 0; led_control = `All_off;
		case(state)
		`RESET: clear = 1;
		`Wait_a: begin leds_on = 1; clear = 1; led_control = `Student_number; end
		`Wait_b: begin leds_on = 1; clear = 1; led_control = `Student_number; end
		//`Dark_Rand: No need for anything here, all outputs default
		`Play: begin leds_on = 1;  led_control = `All_on; end
		`Gloat_a: begin leds_on = 1; clear = 1; led_control = `Curr_score; end
		`Gloat_b: begin leds_on = 1; clear = 1; led_control = `Curr_score; end
		endcase
	end
endmodule
