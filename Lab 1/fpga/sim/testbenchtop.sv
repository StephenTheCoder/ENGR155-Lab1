`timescale 1ns/1ns

// Stephen Kanti Mahanty - skantimahanty@hmc.edu
// Made September 5, 2026
// Tests the top-level wiring, assign logic, and internal HSOSC

module lab1_skm_tb();

    logic [3:0] s;
    logic [2:0] led;
    logic [6:0] seg;

    logic previous_led2;

    // Use a short maximum count during simulation.
    // The actual FPGA still uses the default value of 4,999,999.
    lab1_skm #(
        .COUNTER_WIDTH     (3),
        .COUNTER_MAX_COUNT (3)
    ) dut (
        .s   (s),
        .led (led),
        .seg (seg)
    );

    // Stop with an error if the oscillator never runs
    initial begin
        #1000;
        $fatal(1, "FAILED! Top-level simulation timed out.");
    end

    initial begin

        // Test 1: Both logic functions receive 00
        s = 4'b0000;
        #10;

        assert (led[1:0] === 2'b00)
            $display("PASSED! s=0000 produced led[1:0]=00 at time %0t.",
                     $time);
        else
            $error("FAILED! s=0000: expected led[1:0]=00, received %02b.",
                   led[1:0]);

        // Test 2:
        // s[1:0]=01 tests one XOR case
        // s[3:2]=01 tests one AND case
        s = 4'b0101;
        #10;

        assert (led[1:0] === 2'b01)
            $display("PASSED! s=0101 produced led[1:0]=01 at time %0t.",
                     $time);
        else
            $error("FAILED! s=0101: expected led[1:0]=01, received %02b.",
                   led[1:0]);

        // Test 3:
        // s[1:0]=10 tests the other XOR case
        // s[3:2]=10 tests another AND case
        s = 4'b1010;
        #10;

        assert (led[1:0] === 2'b01)
            $display("PASSED! s=1010 produced led[1:0]=01 at time %0t.",
                     $time);
        else
            $error("FAILED! s=1010: expected led[1:0]=01, received %02b.",
                   led[1:0]);

        // Test 4: Both logic functions receive 11
        s = 4'b1111;
        #10;

        assert (led[1:0] === 2'b10)
            $display("PASSED! s=1111 produced led[1:0]=10 at time %0t.",
                     $time);
        else
            $error("FAILED! s=1111: expected led[1:0]=10, received %02b.",
                   led[1:0]);

        // Test 5: Verify that s is connected to the seven-segment module
        // Only one representative case is needed because the submodule
        // testbench already checks all sixteen values.
        s = 4'hA;
        #10;

        assert (seg === 7'b0001000)
            $display("PASSED! Seven-segment submodule is connected correctly at time %0t.",
                     $time);
        else
            $error("FAILED! Top-level seven-segment wiring: expected 0001000, received %07b.",
                   seg);

        // Test 6: Verify that HSOSC produces rising and falling edges
        @(posedge dut.int_osc);
        #1;

        assert (dut.int_osc === 1'b1)
            $display("PASSED! HSOSC produced a rising edge at time %0t.",
                     $time);
        else
            $error("FAILED! HSOSC rising-edge test.");

        @(negedge dut.int_osc);
        #1;

        assert (dut.int_osc === 1'b0)
            $display("PASSED! HSOSC produced a falling edge at time %0t.",
                     $time);
        else
            $error("FAILED! HSOSC falling-edge test.");

        // Test 7: Verify that the oscillator drives the counter and that
        // the counter output is connected to led[2].
        previous_led2 = led[2];

        @(led[2]);
        #1;

        assert (led[2] !== previous_led2)
            $display("PASSED! HSOSC drove the counter and changed led[2] at time %0t.",
                     $time);
        else
            $error("FAILED! led[2] did not change as expected.");

        assert (led[2] === dut.blinking_led)
            $display("PASSED! Counter output is connected to led[2].");
        else
            $error("FAILED! Counter output is not connected correctly.");

        $display("All top-level tests completed.");
        $finish;
    end

endmodule