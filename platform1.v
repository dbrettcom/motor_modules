module platform1(
    input wire p1_on,				    // signal from platform3 module to initiate platform1 module
    input wire clk,     			  // 50 MHz
	  output reg [3:0] GPIO_1,		// output to the motor turning the platform
	  output reg colour_sensor_on	// output to colour sensor informing it that there is a new M&M under the sensor
);

// Need to instantiate colour sensor module here

// Stores the input signal of p1_on(1) and allows it to changed back to 0
reg p1_on_internal;

// Controls speed of motor
reg [31:0] count = 390_624;  

// Controls timing of motor
reg [31:0] cntr = 0;

// Controls the number of clock cycles the motor runs for
reg [31:0] timer = (50_000_000 * 0.125); // Rotates M&M 45deg CW to sensor

always @(posedge clk) begin
    p1_on_internal <= p1_on; 			  // Store p1_on signal

    if (p1_on_internal == 1) begin 	// Check if p1 module ready to begin
      
	  p1_on_internal <= 0; 				    // Then change back to 0 again
      
    if (timer > 0) begin
        if (cntr < count*1/4) begin
            GPIO_1 <= 4'b1000;
        end else if (cntr < count*2/4) begin
            GPIO_1 <= 4'b0100;
        end else if (cntr < count*3/4) begin
            GPIO_1 <= 4'b0010;
        end else if (cntr < count*4/4) begin
            GPIO_1 <= 4'b0001;
				timer <= timer - 1; // Countdown to zero
        end
        cntr <= cntr + 1;
        if (cntr >= count) begin
            cntr <= 0;
        end
		  
	 end else begin 
		      GPIO_1 <= 4'b0000; // Platform has placed M&M under sensor - stop motor
				// Need to output signal to colour sensor module to tell it that 
				// an M&M has been placed under the sensor and it can take a reading
		  end
	 end
end

endmodule
