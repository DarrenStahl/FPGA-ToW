/*
	Authors: Darren Stahl, Hasith Vidanamadura, Robert Nelson
	First template by: Gord Allan - gallan@doe.carleton.ca
*/

// =======================================================================================
// SCORER 
//	- resets to Neutral
//	- advances on winrnd
//	- determines who won the point based on leds_on and right control signals
//	- outputs the score as a 7 bit word (L3 L2 L1 N R1 R2 R3)
//      - a win shows up as either (1 1 1 0 0 0 0) if WL or (0 0 0 0 1 1 1) if WR
//----------------------------------------------------------------------------------------

module scorer(clk, rst, right, winrnd, leds_on, switches_in, score);
	`define WR     	1
	`define R3     	2
    `define R2		3
	`define R1  	4
	`define N   	5
	`define L1  	6
	`define L2  	7
	`define L3		8
	`define WL  	9
	`define ERROR   0

	input clk;		// input clk 
	input rst;		// asynchronous reset
	input right;		// indicates who was pushed first 
	input leds_on;		// used to indicate whether the light's were on to determine a jump-the-light
	input winrnd;		// one-cycle pulse that someone has pushed
	input [7:0]switches_in;
	output [6:0] score;	//  MSB 5 [WL L2 L1 0 R1 R2 WR] LSB 0

	reg [6:0] score;	
	reg [3:0] state;	// One of WL, WR, L1, L2, L3, R1, R2, R3 or ERROR
	reg [3:0] nxtstate;	// C/L
	reg [6:0] switches;

	// SYNCHRONOUS STATE ASSIGNMENT ---------------------------------------------
	always @(posedge clk or posedge rst)
   		if (rst) state <= `N;
   		else state <= nxtstate;
	
    // ========================================================================
    // 
    //  Next State logic:  Determine next-state of scorer based on current state and inputs
    //

    wire mr;            
	wire dbl;
	// move right if right pushed properly, or if left pushed improperly
	assign mr = (right & leds_on) | (~right & ~leds_on);
	assign dbl = (mr & switches[state-1] & (score >= 5)) | (!mr & switches[state-2] & (score <= 5));
	
	always @(state or switches)
	
	always @(state or mr or leds_on or winrnd) begin
		nxtstate = state;
        if(winrnd) begin
    		if(leds_on)         // Proper pushes (uses favour the loser options)
    			case(state)
    			`WL:	nxtstate = `WL;
    			`WR:	nxtstate = `WR;
				`ERROR: nxtstate = `ERROR;
    			default: begin
					if (state < `WL && state > `WR)
						nxtstate = state - (mr + dbl);
					nxtstate = `ERROR;
				end
    			endcase
    		else	            // the leds were off, player jumped the light
    			case(state)
    			`WL:	nxtstate = `WL;
    			`WR:	nxtstate = `WR;
				`ERROR: nxtstate = `ERROR;
    			default: begin
					if (state < `WL && state > `WR)
						nxtstate = state + mr;
					nxtstate = `ERROR;
				end
    			endcase
        end
    end


    // output logic - what value of 'score' should show based on the internal state
	always @(state)	
		case(state)
		`WL:		score = 7'b1110000;
		`L3:		score = 7'b1000000;
		`L2:		score = 7'b0100000;
		`L1:		score = 7'b0010000;
		`N:			score = 7'b0001000;
		`R1:		score = 7'b0000100;
		`R2:		score = 7'b0000010;
		`R3:		score = 7'b0000001;
		`WR:		score = 7'b0000111;
		default: 	score = 7'b1010101;
		endcase

endmodule

