//*********************
//Hasith Vidanamadura
//100871538
//Darren Stahl
//100858939
//*********************
module Top(clk, rst, pbl, pbr, leds_out);

	// Inputs
	input clk, rst, pbl, pbr;
	
	// Outputs
	output [6:0]leds_out;
	
	// Internal wires
	wire slowen, rand, leds_on, push, sypush, tie, right, winrnd, 
			clear;
	wire [6:0]score;
	wire [1:0]led_control;
	
	//Instantiate an instance of each module, and connect them.
	
	PBL PBL(.rst(rst), .pbl(pbl), .pbr(pbr), .clear(clear), 
					.push(push), .tie(tie), .right(right));
					
	DIV256 DIV256(.clk(clk), .rst(rst), .slowen(slowen));
	
	LFSR LFSR(.clk(clk), .rst(rst), .rand(rand));
	
	SCORER SCORER(.clk(clk), .rst(rst), .winrnd(winrnd), .right(right), 
					.leds_on(leds_on), .score(score), .tie(tie));
					
	OPP OPP(.clk(clk), .rst(rst), .sypush(sypush), .winrnd(winrnd));
					
	Synchronizer Synchronizer(.clk(clk), .rst(rst), .push(push), .sypush(sypush));
	
	MC MC(.clk(clk), .rst(rst), .winrnd(winrnd), .slowen(slowen), .rand(rand), 
					.leds_on(leds_on), .clear(clear), .led_control(led_control));
	
	LED_MUX LED_MUX(.led_control(led_control), .score(score), .leds_out(leds_out));
	
endmodule
