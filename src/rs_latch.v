`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:32:57 11/11/2013 
// Design Name: 
// Module Name:    rs_latch 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module rs_latch(in, clr, out);
  input in, clr;
  output out;
  
  wire in, clr, out;
  wire qx;
  
  assign qx = out | in;
  assign out = qx & ~clr;
endmodule
