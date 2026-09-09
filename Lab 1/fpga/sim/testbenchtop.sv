`timescale 1ns/1ns

// Stephen Kanti Mahanty - skantimahanty@hmc.edu
// Made September 5, 2026
// Tests the top-level wiring, assign logic, and internal HSOSC

module lab1_skm_tb();

    // These signals connect to the inputs and outputs of the top-level module.
    logic [3:0] s;
    logic [2:0] led;
    logic [6:0] seg;

    // Stores the LED value before the oscillator is allowed to run.
    logic previous_led2;

    // Instantiate the top-level design being tested.
    // A small max_count is used to make the counter change quickly during sim
    lab1_skm #(
        .width     (3),
        .max_count (3)
    ) dut (
        .s   (s),
        .led (led),
        .seg (seg)
    );

    // If the oscillator or simulation gets stuck, stop the testbench after 1000 ns and report an error
    initial begin
        #1000;
        $fatal(1, "FAILED! Top-level simulation timed out.");
    end

    initial begin

        // Test 1: Apply a binary input to the top-level module.
        s = 4'b0000;

        // Wait 10 ns
        #10;

        // led[1:0] selects the two LED bits.
        assert (led[1:0] === 2'b00)
            $display("PASSED! s=0000 produced led[1:0]=00 at time %0t.",
                     $time);
        else
            $error("FAILED! s=0000: expected led[1:0]=00, received %02b.",
                   led[1:0]);

        // Test 2
        s = 4'b0101;
        #10;

        assert (led[1:0] === 2'b01)
            $display("PASSED! s=0101 produced led[1:0]=01 at time %0t.",
                     $time);
        else
            $error("FAILED! s=0101: expected led[1:0]=01, received %02b.",
                   led[1:0]);

        // Test 3
        s = 4'b1010;
        #10;

        assert (led[1:0] === 2'b01)
            $display("PASSED! s=1010 produced led[1:0]=01 at time %0t.",
                     $time);
        else
            $error("FAILED! s=1010: expected led[1:0]=01, received %02b.",
                   led[1:0]);

        // Test 4
        s = 4'b1111;
        #10;

        assert (led[1:0] === 2'b10)
            $display("PASSED! s=1111 produced led[1:0]=10 at time %0t.",
                     $time);
        else
            $error("FAILED! s=1111: expected led[1:0]=10, received %02b.",
                   led[1:0]);

        // Confirm that the input s is connected to the seven-segment display module.
        s = 4'hA;
        #10;

        // 4'hA means hexadecimal A, which should produce this pattern
        assert (seg === 7'b0001000)
            $display("PASSED! Seven-segment submodule is connected correctly at time %0t.",
                     $time);
        else
            $error("FAILED! Top-level seven-segment wiring: expected 0001000, received %07b.",
                   seg);

        // Test 6: Check that the internal HSOSC produces a rising edge
        //
        // dut.int_osc accesses the internal int_osc signal 
        @(posedge dut.int_osc);

        // Wait briefly after the edge
        #1;

        assert (dut.int_osc === 1'b1)
            $display("PASSED! HSOSC produced a rising edge at time %0t.",
                     $time);
        else
            $error("FAILED! HSOSC rising-edge test.");

        // Wait for the oscillator to produce a falling edge changing from 1 back to 0
        @(negedge dut.int_osc);
        #1;

        assert (dut.int_osc === 1'b0)
            $display("PASSED! HSOSC produced a falling edge at time %0t.",
                     $time);
        else
            $error("FAILED! HSOSC falling-edge test.");

        // Test 7: Verify that the oscillator is connected to the counter
        // Save the current value of LED 2 before waiting for it to change.
        previous_led2 = led[2];

        // Wait until led[2] changes value.
        @(led[2]);
        #1;

        // Checks whether the two values are different, including
        assert (led[2] !== previous_led2)
            $display("PASSED! HSOSC drove the counter and changed led[2] at time %0t.",
                     $time);
        else
            $error("FAILED! led[2] did not change as expected.");

        // Confirm that the top-level led[2] output is connected to the counter's blinking_led output
        assert (led[2] === dut.blinking_led)
            $display("PASSED! Counter output is connected to led[2].");
        else
            $error("FAILED! Counter output is not connected correctly.");

        // End the simulation
        $display("All top-level tests completed.");
        $finish;
    end

endmodule