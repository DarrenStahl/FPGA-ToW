//*********************
//Hasith Vidanamadura
//100871538
//Darren Stahl
//100858939
//*********************
module LED_MUX(led_control, score, leds_out);
	//Input
	input [1:0] led_control;
	input [6:0] score;
	
	//Output
	output reg[6:0]  leds_out;
	
	//Multiplexer
	always@(led_control, score)
		case(led_control)
		0: leds_out= 0;
		1: leds_out = 7'b1111111;
		2: leds_out= score;
		3: leds_out = 7'b1001101;
		default: leds_out = 7'b1010101;
		endcase
endmodule
