`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.08.2026 23:12:37
// Design Name: 
// Module Name: detector
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


module detector (
    input  wire i_clk,
    input  wire i_en,
    input  wire i_dat_in,
    input  wire i_rst,
    output reg  o_pattern_valid
);

    reg [2:0] state;

    localparam RESET = 3'b000;
    localparam INIT = 3'b001;
    localparam ZO = 3'b010;
    localparam ZZ = 3'b011;
    localparam ZZO = 3'b100;
    localparam ZOZ = 3'b101;

    always @(posedge i_clk or posedge i_rst) begin
        if (i_rst) begin
            state <= RESET;
            o_pattern_valid <= 1'b0;
        end else if (i_en) begin
            case (state)
                RESET: begin
                    state <= i_dat_in ? RESET : INIT;
                    o_pattern_valid <= 0;
                end
                INIT: begin
                    state <= i_dat_in ? ZO : ZZ;
                    o_pattern_valid <= 0;
                end
                ZO: begin
                    state <= i_dat_in ? RESET : ZOZ;
                    o_pattern_valid <= 0;
                end
                ZZ: begin
                    state <= i_dat_in ? ZZO : ZZ;
                    o_pattern_valid <= 0;
                end
                ZZO: begin
                    // state <= i_dat_in ? RESET : ZOZ; overlapping detector
                    state <= i_dat_in ? RESET : RESET;
                    o_pattern_valid <= i_dat_in ? 1'b0 : 1'b1;
                end
                ZOZ: begin
                    // state <= i_dat_in ? ZO : ZOZ; overlapping detector
                    // state cahnge
                    state <= i_dat_in ? ZO : RESET;
                    o_pattern_valid <= i_dat_in ? 1'b0 : 1'b1;
                end
                default: begin
                    state <= RESET;
                    o_pattern_valid <= 0;
                end
            endcase
        end
    end
endmodule
