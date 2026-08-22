`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2026 16:01:16
// Design Name: 
// Module Name: clockdiv
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clockdiv #(
    parameter DESIRED_FREQ = 10,
    parameter IP_FREQ = 125000000
) (
    input  wire i_clk,
    input  wire i_rst,
    output reg  o_en
);

    localparam integer SETPOINT = (IP_FREQ) / (2 * DESIRED_FREQ);
    localparam integer COUNTER_WIDTH = $clog2(SETPOINT);

    reg [COUNTER_WIDTH-1:0] counter = 'b0;

    always @(posedge i_clk) begin
        if (i_rst) begin
            counter <= 'b0;
            o_en <= 1'b0;
        end else if (counter == SETPOINT - 1) begin
            counter <= 'b0;
            o_en <= 1'b1;
        end else begin
            counter <= counter + 1'b1;
            o_en <= 1'b0;
        end
    end
endmodule
