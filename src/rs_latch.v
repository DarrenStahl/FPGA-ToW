`timescale 1ns / 1ps
/*
	Authors: Darren Stahl, Hasith Vidanamadura, Robert Nelson
    Date: December 6th 2013
*/

// =======================================================================================
// RS_LATCH
//	- Latches on a high, resets to low
//----------------------------------------------------------------------------------------
module rs_latch(in, clr, out);
  input in, clr;
  output out;
  
  wire in, clr, out;
  wire qx;
  
  assign qx = out | in;
  assign out = qx & ~clr;
endmodule
