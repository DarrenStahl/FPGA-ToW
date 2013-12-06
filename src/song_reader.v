module song_reader(input clk, input rst, output sound);

    reg [7:0] song_addr;
    wire [7:0] song_data;

    wire [3:0] dur, tone;
    wire change_note;

    assign dur[3:0] = song_data[7:4];
    assign tone[3:0] = song_data[3:0];

    blk_mem_sng sng(.clka(clk), .addra(song_addr), .douta(song_data));

    music_timer timer(.clk(clk), .rst(rst), .length(dur), .note_change(change_note));

    tone_generator tone_gen(.clk(clk), .rst(rst), .tone(tone), .out(sound));

    always @ (posedge clk or posedge rst)
        if (rst) begin
            song_addr <= 0;
        end else if (change_note) begin
				if (song_addr >= 20) song_addr <= 0;
				else song_addr <= song_addr + 1;
        end

endmodule
