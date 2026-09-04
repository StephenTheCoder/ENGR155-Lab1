// Stephen Kanti Mahanty - skantimahanty@hmc.edu
// Made September 3, 2026
// Used to assign switches to two on-board LEDs

module switchtoseven(
     input   logic [3:0] s,
     output  logic [1:0]led,
);

   logic int_osc;
   logic [24:0] counter;

   // Internal high-speed oscillator
   HSOSC #(.CLKHF_DIV(2'b01))
         hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

   // Case for LED 1
   assign led[0] = s[0]^s[1];
   assign led[1] = s[2]&s[3];

endmodule
