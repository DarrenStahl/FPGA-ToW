/*
	Authors: Darren Stahl, Hasith Vidanamadura, Robert Nelson
	First template by: Gord Allan - gallan@doe.carleton.ca
*/

// =======================================================================================
// SCORER
//	- resets to Neutral
//	- advances on winrnd
//	- determines who won the point based on leds_on, switches, tie, and right control signals
//	- outputs the score as an 8 bit word (L3 L2 L1 N*2 R1 R2 R3)
//      - a win shows up as either (1 1 1 0 0 0 0 0) if WL or (0 0 0 0 0 1 1 1) if WR
//----------------------------------------------------------------------------------------

module scorer(clk, rst, tie, right, winrnd, leds_on, switches_in, score);
	`define WR     	1
	`define R3     	2
    `define R2		3
	`define R1  	4
	`define N   	5
	`define L1  	6
	`define L2  	7
	`define L3		8
	`define WL  	9
	`define SCORER_ERROR   0

	input clk;		// input clk 
	input rst;		// asynchronous reset
	input right;		// indicates who was pushed first 
	input leds_on;		// used to indicate whether the light's were on to determine a jump-the-light
    input tie;
	input winrnd;		// one-cycle pulse that someone has pushed
	input [7:0]switches_in;
	output reg [7:0] score;	//  MSB 5 [WL L2 L1 0 R1 R2 WR] LSB 0

	reg [3:0] state;	// One of WL, WR, L1, L2, L3, R1, R2, R3 or ERROR
	reg [3:0] nxtstate;	// C/L
	reg [7:0] switches;

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
	assign dbl = (mr & switches[state-1] & (state >= 5)) | (!mr & switches[state-2] & (state <= 5));
	
	always @(state or switches_in)
        if (state == `N)
            switches[7:0] <= switches_in[7:0];
        else
            switches[7:0] <= switches[7:0];
	
	always @(state or mr or leds_on or winrnd or dbl or tie) begin
		nxtstate = state;
        if(winrnd & ~tie) begin
    		if(leds_on)         // Proper pushes (uses favour the loser options)
    			case(state)
    			`WL:	nxtstate = `WL;
    			`WR:	nxtstate = `WR;
				`SCORER_ERROR: nxtstate = `SCORER_ERROR;
    			default: begin
					if (state < `WL && state > `WR)
						nxtstate = state - (mr ? (1 + dbl) : - (1 + dbl));
					else nxtstate = `SCORER_ERROR;
				end
    			endcase
    		else	            // the leds were off, player jumped the light
    			case(state)
    			`WL:	nxtstate = `WL;
    			`WR:	nxtstate = `WR;
				`SCORER_ERROR: nxtstate = `SCORER_ERROR;
    			default: begin
					if (state < `WL && state > `WR)
						nxtstate = state - (mr ? 1 : -1);
					else nxtstate = `SCORER_ERROR;
				end
    			endcase
        end
    end


    // output logic - what value of 'score' should show based on the internal state
	always @(state)	
		case(state)
		`WL:		score = 8'b11100000;
		`L3:		score = 8'b10000000;
		`L2:		score = 8'b01000000;
		`L1:		score = 8'b00100000;
		`N:			score = 8'b00011000;
		`R1:		score = 8'b00000100;
		`R2:		score = 8'b00000010;
		`R3:		score = 8'b00000001;
		`WR:		score = 8'b00000111;
		default: 	score = 8'b10100101;
		endcase

endmodule

