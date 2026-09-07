// Stephen Kanti Mahanty - skantimahanty@hmc.edu
// Made September 3, 2026
// Used to be a counter to blink an LED on 2.4 Hz

module counter #(parameter width = 24, parameter logic [width-1:0] max_count = 4_999_999)( // Params
     input logic reset, clk, enable,
     output logic led_out
 );

logic [width-1:0] count = 0;
   // Blink state
   logic state = 0;

    // Counter
   always_ff @(posedge clk) begin
     if(reset == 0) begin
      count <= 0;
      state <= 0;
     end
     else if(enable) begin
      if(count == max_count) begin // Max count
        state <= ~state;
        count <= 0;
      end
      else count <= count + 1;
     end
   end

   // Assign LED output
   assign led_out = state;

endmodule