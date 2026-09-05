// Stephen Kanti Mahanty - skantimahanty@hmc.edu
// Made September 3, 2026
// Used to be a counter to blink an LED on 2.4 Hz

module counter(input logic reset,
     output  logic led_out);
	 
	 logic int_osc;
	 logic [27:0] counter;
	 
	 // Internal high-speed oscillator
   HSOSC #(.CLKHF_DIV(2'b01))
         hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

    // Counter
   always_ff @(posedge int_osc) begin
     if(reset == 0)  counter <= 0;
     else            counter <= counter + 27;
   end

   // Assign LED output
   assign led = counter[27];

endmodule