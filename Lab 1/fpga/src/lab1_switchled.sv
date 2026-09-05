// Stephen Kanti Mahanty - skantimahanty@hmc.edu
// Made September 3, 2026
// Used to convert switches into 2 LEDs.

module lab1_switchled(input logic [3:0] s, output logic [1:0] led);

    // Writing LED signals
    assign led[0] = s[0] ^ s[1];
    assign led[1] = s[2] & s[3];
	
endmodule
