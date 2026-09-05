`timescale 1ns/1ns

module testbenchsevenseg();

    logic [3:0] s;       // 4-bit input switches
    logic [6:0] seg;     // seven-segment output

    lab1_sevenseg dut (
        .s   (s),
        .seg (seg)
    );

    // Apply stimuli and check outputs
    initial begin

        // Test 0
        s = 4'd0;
        #10;
        assert (seg == 7'b1000000)
            $display("PASSED! Input 0 displayed correctly at time: %0t.", $time);
        else
            $error("FAILED! Input 0: expected 1000000, received %07b at time: %0t.",
                   seg, $time);

        // Test 1
        s = 4'd1;
        #10;
        assert (seg == 7'b1001111)
            $display("PASSED! Input 1 displayed correctly at time: %0t.", $time);
        else
            $error("FAILED! Input 1: expected 1001111, received %07b at time: %0t.",
                   seg, $time);

        // Test 2
        s = 4'd2;
        #10;
        assert (seg == 7'b0100100)
            $display("PASSED! Input 2 displayed correctly at time: %0t.", $time);
        else
            $error("FAILED! Input 2: expected 0100100, received %07b at time: %0t.",
                   seg, $time);

        // Test 3
        s = 4'd3;
        #10;
        assert (seg == 7'b0110000)
            $display("PASSED! Input 3 displayed correctly at time: %0t.", $time);
        else
            $error("FAILED! Input 3: expected 0110000, received %07b at time: %0t.",
                   seg, $time);

        // Test 4
        s = 4'd4;
        #10;
        assert (seg == 7'b0011001)
            $display("PASSED! Input 4 displayed correctly at time: %0t.", $time);
        else
            $error("FAILED! Input 4: expected 0011001, received %07b at time: %0t.",
                   seg, $time);

        // Test 5
        s = 4'd5;
        #10;
        assert (seg == 7'b0010010)
            $display("PASSED! Input 5 displayed correctly at time: %0t.", $time);
        else
            $error("FAILED! Input 5: expected 0010010, received %07b at time: %0t.",
                   seg, $time);

        // Test 6
        s = 4'd6;
        #10;
        assert (seg == 7'b0000010)
            $display("PASSED! Input 6 displayed correctly at time: %0t.", $time);
        else
            $error("FAILED! Input 6: expected 0000010, received %07b at time: %0t.",
                   seg, $time);

        // Test 7
        s = 4'd7;
        #10;
        assert (seg == 7'b1111000)
            $display("PASSED! Input 7 displayed correctly at time: %0t.", $time);
        else
            $error("FAILED! Input 7: expected 1111000, received %07b at time: %0t.",
                   seg, $time);

        // Test 8
        s = 4'd8;
        #10;
        assert (seg == 7'b0000000)
            $display("PASSED! Input 8 displayed correctly at time: %0t.", $time);
        else
            $error("FAILED! Input 8: expected 0000000, received %07b at time: %0t.",
                   seg, $time);

        // Test 9
        s = 4'd9;
        #10;
        assert (seg == 7'b0011000)
            $display("PASSED! Input 9 displayed correctly at time: %0t.", $time);
        else
            $error("FAILED! Input 9: expected 0010000, received %07b at time: %0t.",
                   seg, $time);

        // Test A
        s = 4'd10;
        #10;
        assert (seg == 7'b0001000)
            $display("PASSED! Input A displayed correctly at time: %0t.", $time);
        else
            $error("FAILED! Input A: expected 0001000, received %07b at time: %0t.",
                   seg, $time);

        // Test b
        s = 4'd11;
        #10;
        assert (seg == 7'b0000011)
            $display("PASSED! Input b displayed correctly at time: %0t.", $time);
        else
            $error("FAILED! Input b: expected 0000011, received %07b at time: %0t.",
                   seg, $time);

        // Test C
        s = 4'd12;
        #10;
        assert (seg == 7'b1000110)
            $display("PASSED! Input C displayed correctly at time: %0t.", $time);
        else
            $error("FAILED! Input C: expected 1000110, received %07b at time: %0t.",
                   seg, $time);

        // Test d
        s = 4'd13;
        #10;
        assert (seg == 7'b0100001)
            $display("PASSED! Input d displayed correctly at time: %0t.", $time);
        else
            $error("FAILED! Input d: expected 0100001, received %07b at time: %0t.",
                   seg, $time);

        // Test E
        s = 4'd14;
        #10;
        assert (seg == 7'b0000110)
            $display("PASSED! Input E displayed correctly at time: %0t.", $time);
        else
            $error("FAILED! Input E: expected 0000110, received %07b at time: %0t.",
                   seg, $time);

        // Test F
        s = 4'd15;
        #10;
        assert (seg == 7'b0001110)
            $display("PASSED! Input F displayed correctly at time: %0t.", $time);
        else
            $error("FAILED! Input F: expected 0001110, received %07b at time: %0t.",
                   seg, $time);

        #100;
        $stop;
    end

endmodule