module motor(
    input wire motor_on, 		// Signal from platform2 module to initiate motor module
    input wire clk,     		// 50 MHz
    output reg [3:0] GPIO_1,	// Output to the motor
	 output reg p3_on				// Signal from motor module to initiate platform3 module
);

platform3 platform3_(.p3_on(p3_on));

// Stores the input signal of motor_on(1) and allows it to changed back to 0
reg motor_on_internal;

// Controls speed of motor
reg [31:0] count = 390_624;  

// Controls timing of motor
reg [31:0] cntr = 0;

// Controls the number of clock cycles the motor runs for
reg [31:0] timer = 50_000_000; // 1 full shaft rotation

always @(posedge clk) begin
    motor_on_internal <= motor_on; 		// Store motor_on signal

    if (motor_on_internal == 1) begin 	// Check if motor module ready to begin
	 motor_on_internal <= 0; 				// Then change back to 0    
	 
	 if (timer > 0) begin
        if (cntr < count*1/4) begin
            GPIO_1 <= 4'b0001;
        end else if (cntr < count*2/4) begin
            GPIO_1 <= 4'b0010;
        end else if (cntr < count*3/4) begin
            GPIO_1 <= 4'b0100;
        end else if (cntr < count*4/4) begin
            GPIO_1 <= 4'b1000;
				timer <= timer - 1; // Countdown to zero
        end
        cntr <= cntr + 1;
        if (cntr >= count) begin
            cntr <= 0;
        end
		  
	 end else begin 
		      GPIO_1 <= 4'b0000; // Arm has returned to starting position - stop motor
				p3_on <= 1;			 // Turn on Module3
		  end
	 end
end

endmodule
