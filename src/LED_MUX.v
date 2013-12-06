//*********************
//Hasith Vidanamadura
//100871538
//Darren Stahl
//100858939
//*********************
module LED_MUX(led_control, score, leds_out);
	//Input
	input [1:0] led_control;
	input [7:0] score;
	
	//Output
	output reg[7:0]  leds_out;
	
	//Multiplexer
	always@(led_control, score)
		case(led_control)
		0: leds_out= 0;
		1: leds_out = 8'b11111111;
		2: leds_out= score;
		3: leds_out = 8'b01001101;
		default: leds_out = 8'b10100101;
		endcase
endmodule
