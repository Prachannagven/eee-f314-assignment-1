`timescale 1ns / 1ps

module generator (
    input  wire i_clk,
    input  wire i_rst,
    input  wire i_en,
    output reg  o_pattern_dat
);

    localparam [119:0] TEST_STREAM = {
        4'b0010,  // Direct 0010
        4'b0100,  // Direct 0100
        7'b0010010,  // Overlapping 0010
        7'b0100100,  // Overlapping 0100
        5'b00100,  // Partial overlap
        5'b01001,  // Partial overlap
        8'b00000000,  // Continuous 0
        8'b11111111,  // Continuous 1
        8'b00110010,  // Near miss + 0010
        8'b01010010,  // Near miss + 0010
        8'b11001001,  // 0010 in arbitrary data
        8'b10100100,  // 0100 in arbitrary data
        8'b00010000,  // Long zero / partial
        8'b11101111,  // Long one / partial
        12'b001001000100,  // Multiple patterns
        12'b010000100010  // Multiple patterns
    };

    reg [6:0] bit_count;

    assign o_pattern_dat = TEST_STREAM[119-bit_count];

    always @(posedge i_clk or posedge i_rst) begin
        if (i_rst) begin
            bit_count <= 7'd0;
        end else if (i_en) begin
            if (bit_count == 7'd119) bit_count <= 7'd0;
            else bit_count <= bit_count + 1'b1;
        end
    end

endmodule
