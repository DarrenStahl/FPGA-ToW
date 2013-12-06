//*********************
//Hasith Vidanamadura
//100871538
//Darren Stahl
//100858939
//*********************
module Top(input clk, input rst, input pbl, input pbr, output [7:0] leds_out, input [7:0] sw, output speaker,
    output [2:0] vgaGreen,
    output [2:0] vgaRed,
    output [2:0] vgaBlue,
    output hSync,
    output vSync
    );
	
	// Internal wires
	wire slowen, rand, leds_on, push, sypush, tie, right, winrnd, clear, sound;
	wire [7:0]score;
	wire [1:0]led_control;

	//VGA interface wires
	wire pixel_ok;
	wire [9:0]hpos;
	wire [9:0]vpos;
	wire [7:0] rgb1;
	wire [7:0] rgb2;
	wire [7:0] rgb3;
	wire [7:0] rgb4;


	//Instantiate an instance of each module, and connect them.
	song_reader sr(.rst(rst), .clk(clk), .sound(speaker));

	pb_latch PBL(.rst(rst), .pbl(pbl), .pbr(pbr), .clear(clear),
					.push(push), .tie(tie), .right(right));

	DIV256ISH DIV256ISH(.clk(clk), .rst(rst), .slowen(slowen));

	LFSR LFSR(.clk(clk), .rst(rst), .rand(rand));

	scorer Scorer(.clk(clk), .rst(rst), .winrnd(winrnd), .right(right),
					.leds_on(leds_on), .score(score),
                    .switches_in(sw), .tie(tie));

	OPP OPP(.clk(clk), .rst(rst), .sypush(sypush), .winrnd(winrnd));

	Synchronizer Synchronizer(.clk(clk), .rst(rst), .push(push), .sypush(sypush));

	MC MC(.clk(clk), .rst(rst), .winrnd(winrnd), .slowen(slowen), .rand(rand),
					.leds_on(leds_on), .clear(clear), .led_control(led_control));

	LED_MUX LED_MUX(.led_control(led_control), .score(score), .leds_out(leds_out));



	vga_controller display_block(.clk(clk), .rst(rst), .hSync(hSync), .vSync(vSync), .hpos(hpos), .vpos(vpos), .pixel_on(pixel_ok));

	player_draw player_red(.clk(clk), .rst(rst), .hpos(hpos), .vpos(vpos), .start(500), .en(pixel_ok), .player_color(8'b00011100), .out_color(rgb1));
	
	player_draw player_blue(.clk(clk), .rst(rst), .hpos(hpos), .vpos(vpos), .start(300), .en(pixel_ok), .player_color(8'b00000011), .out_color(rgb2));
	
	background_draw bg_draw(.clk(clk), .rst(rst), .en(pixel_ok), .vpos(vpos), .out_color(rgb3));
	divider_draw divider(.clk(clk), .rst(rst), .hpos(hpos), .en(pixel_ok), .vpos(vpos), .out_color(rgb4));

	assign vgaBlue = rgb1[1:0] | rgb2[1:0] | rgb3[1:0] | rgb4[1:0];
	assign vgaRed = rgb1[4:2] | rgb2[4:2] | rgb3[4:2] | rgb4[4:2];
	assign vgaGreen = rgb1[7:5] | rgb2[7:5] | rgb3[7:5] | rgb4[7:5] ;





endmodule
