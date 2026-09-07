// Stephen Kanti Mahanty - skantimahanty@hmc.edu
// Made September 5, 2026
// Top-level module that connects the switches to the LEDs and seven-segment display
// and generates a 2.4 Hz blinking signal using the internal oscillator

module lab1_skm (
    input  logic [3:0] s,
    output logic [2:0] led,
    output logic [6:0] seg
);

    logic int_osc;
    logic blinking_led;

    // Internal high-speed oscillator
    HSOSC #(.CLKHF_DIV(2'b01))
         hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

    // Convert switches into the 7-segment display
    lab1_sevenseg sevenseg_decoder (
        .s   (s),
        .seg (seg)
    );

    // Blinking LED at 2.4 Hz
    counter #(
        .width     (24),
        .max_count (4_999_999)
    ) blinking_counter (
        .clk      (int_osc),
        .reset  (1'b1),
        .enable   (1'b1),
        .led_out  (blinking_led)
    );

    // Assigning LEDs based on switches
    assign led[0] = s[0] ^ s[1];
    assign led[1] = s[2] & s[3];
    assign led[2] = blinking_led;

endmodule