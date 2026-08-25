`timescale 1ns / 1ps

module mealy_detector_tb;

    reg i_clk;
    reg i_rst;
    reg i_dat_in;

    wire o_pwd_valid;
    wire o_pwd_invalid;
    wire o_lockout;

    // ------------------------------------------------------------
    // DUT
    // ------------------------------------------------------------

    mealy_detector uut (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_en(1'b1),
        .i_dat_in(i_dat_in),
        .o_pwd_valid(o_pwd_valid),
        .o_pwd_invalid(o_pwd_invalid),
        .o_lockout(o_lockout)
    );

    // 10 ns clock
    always #5 i_clk = ~i_clk;


    // ------------------------------------------------------------
    // Send one bit
    // ------------------------------------------------------------

    task send_bit;
        input bit_value;
        begin
            i_dat_in = bit_value;

            // Give input time to settle before sampling
            #2;

            // Detector samples on rising edge
            @(posedge i_clk);

            #1;
        end
    endtask


    // ------------------------------------------------------------
    // Send password/sequence MSB first
    // ------------------------------------------------------------

    task send_sequence;
        input [31:0] sequence;
        input integer length;

        integer i;

        begin
            for (i = length-1; i >= 0; i = i-1)
                send_bit(sequence[i]);
        end
    endtask


    // ------------------------------------------------------------
    // TESTS
    // ------------------------------------------------------------

    initial begin

        // Initial values
        i_clk    = 1'b0;
        i_rst    = 1'b1;
        i_dat_in = 1'b0;

        // Reset
        #20;
        i_rst = 1'b0;

        // --------------------------------------------------------
        // TEST 1: Correct password
        // 0011
        // --------------------------------------------------------

        send_sequence(32'b0011, 4);

        #20;


        // --------------------------------------------------------
        // TEST 2: Incorrect password
        // 0010
        // --------------------------------------------------------

        send_sequence(32'b0010, 4);

        #20;


        // --------------------------------------------------------
        // TEST 3: Correct password again
        // This should work and reset attempt_count.
        // --------------------------------------------------------

        send_sequence(32'b0011, 4);

        #20;


        // --------------------------------------------------------
        // TEST 4: Wrong bit early
        // 0101
        // --------------------------------------------------------

        send_sequence(32'b0101, 4);

        #20;


        // --------------------------------------------------------
        // TEST 5: Third incorrect attempt
        // 1111
        //
        // This should cause LOCKOUT.
        // --------------------------------------------------------

        send_sequence(32'b1111, 4);

        #20;


        // --------------------------------------------------------
        // TEST 6: Try correct password while locked
        //
        // Should remain LOCKED.
        // --------------------------------------------------------

        send_sequence(32'b0011, 4);

        #20;


        // --------------------------------------------------------
        // TEST 7: Reset
        // Should leave LOCK state.
        // --------------------------------------------------------

        i_rst = 1'b1;
        #20;
        i_rst = 1'b0;

        #20;


        // --------------------------------------------------------
        // TEST 8: Correct password after reset
        // --------------------------------------------------------

        send_sequence(32'b0011, 4);

        #50;

        $finish;

    end

endmodule