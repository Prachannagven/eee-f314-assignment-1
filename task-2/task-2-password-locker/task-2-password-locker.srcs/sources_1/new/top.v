`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Create Date: 22.08.2026 18:33:14
// Design Name: 
// Module Name: top
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


module top (
    input wire i_clk,
    input wire i_user_btn,
    input wire i_rst,
    output wire o_pwd_valid,
    output wire o_pwd_invalid,
    output wire o_lockout,
    output wire o_clk
);

    wire enable;
    
    clockdiv cdiv (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .o_clk(o_clk),
        .o_en (enable)
    );

    mealy_detector uut (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_en(enable),
        .i_dat_in(i_user_btn),
        .o_pwd_valid(o_pwd_valid),
        .o_pwd_invalid(o_pwd_invalid),
        .o_lockout(o_lockout)
    );
endmodule
