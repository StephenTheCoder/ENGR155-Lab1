`timescale 1 ns/1 ns

module lab1_led_controller_tb();
  logic           clk;    // system clock
  logic           reset;  // active high reset
  logic   [3:0]   s;      // 4-bit input switches
  logic   [1:0]   led;    // 2 output leds

    lab1_switchled dut (
        .clk(clk),
        .reset(reset),
        .s(s),
        .led(led)
    );

  // generate clock
  always begin
      clk = 0; #5;
      clk = 1; #5;
  end

  // apply stimuli and check outputs
  initial begin
    reset = 1;
    #22 reset = 0;

    // for each test case we setup the inputs, wait for the outputs to update,
    // and then check that the outputs match what we expect using `assert`
    // in this case, the leds use combinational logic, so we don't *need* to wait
    // a full clock cycle (#10)

    // example test 1
        s = 4'b0000;                // setup inputs
        #10;                        // wait required time
        assert (led == 2'b00)       // check outputs
            $display("PASSED! The led controller behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The led controller behaves incorrectly at time: %0t.", $time); 
            
    // test 2
        s = 4'b0101;
        #10;
        assert (led == 2'b01)
            $display("PASSED! The led controller behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The led controller behaves incorrectly at time: %0t.", $time); 
        
    // test 3
        s = 4'b1010;
        #10;
        assert (led == 2'b01)
            $display("PASSED! The led controller behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The led controller behaves incorrectly at time: %0t.", $time);

    // test 4
        s = 4'b1111;
        #10;
        assert (led == 2'b10)
            $display("PASSED! The led controller behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The led controller behaves incorrectly at time: %0t.", $time);

    #100 $stop;
  end
endmodule