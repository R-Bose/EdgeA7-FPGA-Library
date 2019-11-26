`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rijurekh Bose
// 
// Create Date: 16.11.2019 15:46:28
// Design Name: 
// Module Name: seven_seg_switch_top
// Project Name: 
// Target Devices: edgeA7 (xc7a35tftg256-1)
// Tool Versions: 
// Description: Top module for showing switch value on seven segment display
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seven_seg_switch_top(
    input         clk,
    input         rst,
    input  [15:0] sw,
    input  [3:0]  digit_en,
    output [3:0]  digit,
    output [7:0]  seven_seg
    );

    // Slow clock signal for 7 segment display
    logic clk_sseg;

    // Clock divider to see output at seven segment
    // NOTE: 1000 is ideal
    clk_div #(.FACTOR(1000)) clk_div_inst(
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_sseg));

    // 7 segment display controller
    sseg_ctrl sseg_ctrl_inst(
        .clk(clk_sseg),
        .rst(rst),
        .num(sw),
	.digit_en(digit_en),
        .digit(digit),
        .sseg(seven_seg));

endmodule
