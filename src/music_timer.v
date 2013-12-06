/*
	Authors: Darren Stahl, Hasith Vidanamadura, Robert Nelson
    Date: December 6th 2013
*/

// =======================================================================================
// Music Timer
//	- Times the length of notes, and outputs note_changed
//----------------------------------------------------------------------------------------
module music_timer(
    input clk,
    input rst,
    input [3:0] length,
    output reg note_change
    );

    `define LEN_NONE        0
    `define VAL_NONE        0
    `define LEN_WHOLE       100000000
    `define VAL_WHOLE       1
    `define LEN_HALF        50000000
    `define VAL_HALF        2
    `define LEN_QUARTER     25000000
    `define VAL_QUARTER     3
    `define LEN_EIGHTH      12500000
    `define VAL_EIGHTH      4
    `define LEN_DOTHALF     75000000
    `define VAL_DOTHALF     5
    `define LEN_DOTQUARTER  37500000
    `define VAL_DOTQUARTER  6
    `define LEN_DOTEIGHTH   18750000
    `define VAL_DOTEIGHTH   7

    // 29 Bits allows for counting up to 100000000
    reg [28:0] count;

    always @ (posedge clk or posedge rst)
        // Reset the local variables
        if (rst) begin
            note_change <= 0;
            count <= 0;
        end
        // Only allow note_change to be high for one clock cycle
		else if (note_change == 1) note_change <= 0;
        else begin
            case (length)
                // None is basically reset
                `VAL_NONE:
                begin
                    count <= 0;
                    note_change <= 0;
                end
                // Count until the appropriate number of clock cycles
                // then set note_change
                `VAL_WHOLE:
                begin
                    count <= count + 1;
                    if (count >= `LEN_WHOLE) begin
                        note_change <= 1;
                        count <= 0;
                    end
                end
                `VAL_HALF:
                begin
                    count <= count + 1;
                    if (count >= `LEN_HALF) begin
                        note_change <= 1;
                        count <= 0;
                    end
                end
                `VAL_QUARTER:
                begin
                    count <= count + 1;
                    if (count >= `LEN_QUARTER) begin
                        note_change <= 1;
                        count <= 0;
                    end
                end
                `VAL_EIGHTH:
                begin
                    count <= count + 1;
                    if (count >= `LEN_EIGHTH) begin
                        note_change <= 1;
                        count <= 0;
                    end
                end
                `VAL_DOTHALF:
                begin
                    count <= count + 1;
                    if (count >= `LEN_DOTHALF) begin
                        note_change <= 1;
                        count <= 0;
                    end
                end
                `VAL_DOTQUARTER:
                begin
                    count <= count + 1;
                    if (count >= `LEN_DOTQUARTER) begin
                        note_change <= 1;
                        count <= 0;
                    end
                end
                `VAL_DOTEIGHTH:
                begin
                    count <= count + 1;
                    if (count >= `LEN_DOTEIGHTH) begin
                        note_change <= 1;
                        count <= 0;
                    end
                end
					 default:
					 begin
						  count <= 0;
						  note_change <= 0;
					 end
            endcase
        end

endmodule
