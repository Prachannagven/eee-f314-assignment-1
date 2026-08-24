`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.08.2026 14:32:30
// Design Name: 
// Module Name: top Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: A sequence detector for task 1 that detects 4'b0010 and
// 4'b0100  
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top (
    input  wire i_clk,
    input  wire i_rst,
    output reg o_current_val,
    output wire  o_pattern_valid,
    output wire o_clk_slow
);

    wire enable;
    wire data;

    clockdiv cdiv (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .o_en (enable),
        .o_clk(o_clk_slow)
    );

    detector uut_det (
        .i_clk(i_clk),
        .i_en(enable),
        .i_dat_in(data),
        .i_rst(i_rst),
        .o_pattern_valid(o_pattern_valid)
    );

    generator uut_gen (
        .i_clk(i_clk),
        .i_en(enable),
        .i_rst(i_rst),
        .o_pattern_dat(data)
    );
    
    always @(posedge i_clk or posedge i_rst) begin
        if(i_rst) begin
            o_current_val <= 1'b0;
        end
        else if(enable) begin
            o_current_val <= data;
        end
    end

endmodule
