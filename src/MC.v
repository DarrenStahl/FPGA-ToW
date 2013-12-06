/*
	Authors: Darren Stahl, Hasith Vidanamadura, Robert Nelson
    Date: December 6th 2013
*/

// =======================================================================================
// Master Controller
//	- Controlls the state of the game
//	- resets to RESET state
//	- outputs clear, led_control, leds_on
//----------------------------------------------------------------------------------------
`timescale 1ns / 1ns
module MC(winrnd, slowen, rand, clk, rst, leds_on, clear, led_control);
    `define RESET   0
    `define WAITA   1
    `define WAITB   2
    `define DARK    3
    `define PLAY    4
    `define GLOAT_A 5
    `define GLOAT_B 6
    `define ERROR   7
	 
	 `define NONE    0
	 `define ALLON   1
	 `define SCORE   2
	 `define RESETLED   3
	 

    input winrnd, slowen, rand, clk, rst;
    output leds_on, clear, led_control;

    wire winrnd, slowen, rand, clk, rst;
    reg leds_on, clear;
	 reg [1:0] led_control;

    reg [2:0] state;

    always @ (posedge clk)
        // Reset state
        if (rst) begin
            leds_on <= 0;
            clear <= 1;
            led_control <= `RESETLED;
            state <= `RESET;
        end else begin
            // Move to next state
            case(state)
            `RESET: begin
                state <= `WAITA;
                leds_on <= 0;
                led_control <= `RESETLED;
                clear <= 1;
            end
            `WAITA: begin
                if(slowen) state <= `WAITB; else state <= `WAITA;
                leds_on <= 1;
                led_control <= `RESETLED;
                clear <= 1;
            end
            `WAITB: begin 
                if(slowen) state <= `DARK; else state <= `WAITB;
                leds_on <= 1;
                led_control <= `RESETLED;
                clear <= 1;
            end
            `DARK: begin
                if (winrnd) state <= `GLOAT_A;
                    else if (slowen & rand) state <= `PLAY;
                    else state <= `DARK;

                leds_on <= 0;
                led_control <= `NONE;
                clear <= 0;
            end
            `PLAY: begin
                if (winrnd) state <= `GLOAT_A; else state <= `PLAY;
                leds_on <= 1;
                led_control <= `ALLON;
                clear <= 0;
            end
            `GLOAT_A: begin
                if (slowen) state <= `GLOAT_B; else state <= `GLOAT_A;
                leds_on <= 1;
                led_control <= `SCORE;
                clear <= 1;
            end
            `GLOAT_B: begin
                if (slowen) state <= `DARK; else state <= `GLOAT_B;
                leds_on <= 1;
                led_control <= `SCORE;
                clear <= 1;
            end
            `ERROR: begin
                state <= `RESET;
                leds_on <= 1;
                led_control <= `RESET;
                clear <= 1;
            end
            endcase
        end
endmodule
