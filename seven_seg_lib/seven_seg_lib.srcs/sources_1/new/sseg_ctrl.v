`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rijurekh Bose
// 
// Create Date: 16.11.2019 23:09:55
// Design Name: 
// Module Name: sseg_ctrl
// Project Name: 
// Target Devices: edgeA7 (xc7a35tftg256-1)
// Tool Versions: 
// Description: Seven segment LED controller for Edge Artix 7 board
//              Active low enable for LED digits
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sseg_ctrl(
    input             clk,
    input             rst,
    input      [15:0] num,
    input      [3:0]  digit_en,
    output reg [7:0]  sseg,
    output     [3:0]  digit
    );

    reg [1:0] digit_count;

    // Digit selection as per counter
    always @(posedge clk) begin
        if(rst) begin
            digit_count <= 2'd0;
        end else begin
            digit_count <= digit_count + 1'b1;
        end
    end

    // Digit position encoding
    assign digit = ~digit_en & (4'd1 << digit_count);

    // Determine which digit to display
    // 7-segment encoding
    //      0
    //     ---
    //  5 |   | 1
    //     --- <--6
    //  4 |   | 2
    //     ---
    //      3
    // NOTE: Dot always turned off, 1 turns off while 0 turns on
    always @(*) begin
        case (num[(4*digit_count)+:4])
            4'b0001 : sseg = 8'b11111001;   // 1
            4'b0010 : sseg = 8'b10100100;   // 2
            4'b0011 : sseg = 8'b10110000;   // 3
            4'b0100 : sseg = 8'b10011001;   // 4
            4'b0101 : sseg = 8'b10010010;   // 5
            4'b0110 : sseg = 8'b10000010;   // 6
            4'b0111 : sseg = 8'b11111000;   // 7
            4'b1000 : sseg = 8'b10000000;   // 8
            4'b1001 : sseg = 8'b10010000;   // 9
            4'b1010 : sseg = 8'b10001000;   // A
            4'b1011 : sseg = 8'b10000011;   // b
            4'b1100 : sseg = 8'b11000110;   // C
            4'b1101 : sseg = 8'b10100001;   // d
            4'b1110 : sseg = 8'b10000110;   // E
            4'b1111 : sseg = 8'b10001110;   // F
            default : sseg = 8'b11000000;   // 0
        endcase
    end
endmodule
