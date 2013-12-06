`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:32:30 11/11/2013 
// Design Name: 
// Module Name:    pb_latch 
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
module pb_latch(pbl, pbr, clear, rst,  push, tie, right);
  input pbl, pbr, clear, rst;
  output push, tie, right;
  
  wire pbl, pbr, clear, rst, push, tie, right;
  wire ls, rx, clr, left_out, right_out;
  
  assign lx = pbl & ~right_out;
  assign rx = pbr & ~left_out;
  assign clr = clear | rst;
  assign push = left_out | right_out;
  assign tie = left_out & right_out;
  assign right = right_out & ~left_out;
  
  rs_latch rsl(.in(lx), .clr(clr), .out(left_out));
  rs_latch rsr(.in(rx), .clr(clr), .out(right_out));
endmodule
