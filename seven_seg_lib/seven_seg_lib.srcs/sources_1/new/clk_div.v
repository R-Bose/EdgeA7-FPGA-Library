`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rijurekh Bose
// 
// Create Date: 16.11.2019 20:05:03
// Design Name: 
// Module Name: clk_div
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Simple clock divider with active high reset
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_div #(
    parameter FACTOR = 1
    )(
    input      clk_in,
    input      rst,
    output reg clk_out
    );

    localparam WIDTH = ((FACTOR%2==0)?$clog2(FACTOR)+1:$clog2(FACTOR));
    
    reg [WIDTH-1:0] counter;

    // Counter with active high reset
    always @(posedge clk_in) begin
        if(rst || (counter >= (FACTOR-1))) begin
            counter <= {WIDTH{1'b0}};
        end else begin
            counter <= counter + 1'b1;
        end

        if(rst) begin
            clk_out <= 1'b0;
        end else if(counter == (FACTOR-1)) begin
            clk_out <= !clk_out;
        end
    end
endmodule
