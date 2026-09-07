// Stephen Kanti Mahanty - skantimahanty@hmc.edu
// Made September 5, 2026
// Tests the reset, enable, and maximum-count features of lab1_counter

`timescale 1ns/1ns

module lab1_counter_tb();

    localparam int width = 3;
    localparam logic [width-1:0] max_count = 3;

    logic clk = 1'b0;
    logic reset;
    logic enable;
    logic led_out;

    lab1_counter #(
        .WIDTH     (width),
        .MAX_COUNT (max_count)
    ) dut (
        .clk     (clk),
        .reset (reset),
        .enable  (enable),
        .led_out (led_out)
    );

    // Generate a clock with a 10 ns period
    always begin
        #5 clk = ~clk;
    end

    initial begin

        // Test 1: Reset should clear the counter and LED state
        reset = 1'b0;
        enable  = 1'b0;

        @(posedge clk);
        #1;

        assert ((dut.count === 3'd0) && (led_out === 1'b0))
            $display("PASSED! Reset cleared the counter and LED at time %0t.",
                     $time);
        else
            $error("FAILED! Reset test: count=%0d, led_out=%b at time %0t.",
                   dut.count, led_out, $time);

        // Test 2: Counter should remain stopped when enable is low
        reset = 1'b1;
        enable  = 1'b0;

        repeat (3) @(posedge clk);
        #1;

        assert ((dut.count === 3'd0) && (led_out === 1'b0))
            $display("PASSED! Counter remained stopped while disabled at time %0t.",
                     $time);
        else
            $error("FAILED! Disable test: count=%0d, led_out=%b at time %0t.",
                   dut.count, led_out, $time);

        // Test 3: Enable should allow the counter to increment
        enable = 1'b1;

        @(posedge clk);
        #1;

        assert ((dut.count === 3'd1) && (led_out === 1'b0))
            $display("PASSED! Counter incremented after enable at time %0t.",
                     $time);
        else
            $error("FAILED! Enable test: expected count=1 and led_out=0, received count=%0d and led_out=%b.",
                   dut.count, led_out);

        // Test 4: Counter should reach max_count
        repeat (2) @(posedge clk);
        #1;

        assert ((dut.count === max_count) && (led_out === 1'b0))
            $display("PASSED! Counter reached max_count at time %0t.",
                     $time);
        else
            $error("FAILED! max_count test: expected count=%0d, received count=%0d.",
                   max_count, dut.count);

        // Test 5: On the next clock, count should return to zero
        // and the LED state should toggle
        @(posedge clk);
        #1;

        assert ((dut.count === 3'd0) && (led_out === 1'b1))
            $display("PASSED! Counter wrapped and toggled the LED at time %0t.",
                     $time);
        else
            $error("FAILED! Wrap test: count=%0d, led_out=%b at time %0t.",
                   dut.count, led_out, $time);

        // Test 6: Disable should hold both count and LED state
        enable = 1'b0;

        repeat (3) @(posedge clk);
        #1;

        assert ((dut.count === 3'd0) && (led_out === 1'b1))
            $display("PASSED! Disable held the counter and LED state at time %0t.",
                     $time);
        else
            $error("FAILED! Disable-hold test: count=%0d, led_out=%b at time %0t.",
                   dut.count, led_out, $time);

        // Test 7: Reset should clear a high LED state
        reset = 1'b0;

        @(posedge clk);
        #1;

        assert ((dut.count === 3'd0) && (led_out === 1'b0))
            $display("PASSED! Reset cleared a high LED state at time %0t.",
                     $time);
        else
            $error("FAILED! Final reset test: count=%0d, led_out=%b at time %0t.",
                   dut.count, led_out, $time);

        #10;
        $finish;
    end

endmodule