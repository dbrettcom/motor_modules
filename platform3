module platform3(
    input wire p3_on,  	  	 // Signal from motor module to initiate platform3 module
    input wire clk,      	 // 50 MHz
    input wire [5:0] colour, 	 // colour data input from colour sensor
    output reg [3:0] GPIO_1,	 // Output to the motor
    output reg p1_on		 // Signal from platform3 module to initiate platform1 module
);

platform1 platform1_(.p1_on(p1_on));

// Stores the input signal of p3_on(1) and allows it to changed back to 0
reg p3_on_internal;

// Controls speed of motor
reg [31:0] count = 390_624;  

// Controls timing of motor
reg [31:0] cntr = 0;

// Controls the number of clock cycles the motor runs for
// 1 full rotation = 50 mill, given a 50MHs clock
reg [31:0] timer = 50_000_000;

// If platform currently at Red
reg [31:0] red_return_timer = (50_000_000 * 0.250); // 90/360 back to feeder location CCW

// If platform currently at Brown
reg [31:0] bro_return_timer = (50_000_000 * 0.375); // 135/360 back to feeder location CCW

// If platform currently at Yellow
reg [31:0] yel_return_timer = (50_000_000 * 0.500); // 180/360 back to feeder location CCW

// If platform currently at Orange
reg [31:0] ora_return_timer = (50_000_000 * 0.375); // 135/360 back to feeder location CW

// If platform currently at Green
reg [31:0] gre_return_timer = (50_000_000 * 0.250); // 90/360 back to feeder location CW

// If platform currently at Blue
reg [31:0] blu_return_timer = (50_000_000 * 0.125); // 45/360 back to feeder location CW

always @(posedge clk) begin
    p3_on_internal <= p3_on; 		// Store p3_on signal

    if (p3_on_internal == 1) begin 	// Check if p3 module ready to begin
    
    p3_on_internal <= 0; 		// Then change back to 0
	 
    // RED Begin
    if (colour == 000001) begin
    if (red_return_timer > 0) begin
        if (cntr < count*1/4) begin
            GPIO_1 <= 4'b1000;
        end else if (cntr < count*2/4) begin
            GPIO_1 <= 4'b0100;
        end else if (cntr < count*3/4) begin
            GPIO_1 <= 4'b0010;
        end else if (cntr < count*4/4) begin
            GPIO_1 <= 4'b0001;
        red_return_timer <= red_return_timer - 1; // Countdown to zero
        end
        cntr <= cntr + 1;
        if (cntr >= count) begin
            cntr <= 0;
        end  
        end else begin
        GPIO_1 <= 4'b0000; 	// Platform is back at the feeder location - stop motor
        p1_on <= 1; 		// Calls platform1 module to tell it that it has return to feeder location and recieved new M&M
        end
    end // RED end

    // BROWN Begin
    else if (colour == 000010) begin
    if (bro_return_timer > 0) begin
        if (cntr < count*1/4) begin
            GPIO_1 <= 4'b1000;
        end else if (cntr < count*2/4) begin
            GPIO_1 <= 4'b0100;
        end else if (cntr < count*3/4) begin
            GPIO_1 <= 4'b0010;
        end else if (cntr < count*4/4) begin
            GPIO_1 <= 4'b0001;
        bro_return_timer <= bro_return_timer - 1; // Countdown to zero
        end
        cntr <= cntr + 1;
        if (cntr >= count) begin
            cntr <= 0;
        end  
        end else begin
        GPIO_1 <= 4'b0000; 	// Platform is back at the feeder location - stop motor
        p1_on <= 1; 		// Calls platform1 module to tell it that it has return to feeder location and recieved new M&M
        end
    end // Brown end

    // YELLOW Begin
    else if (colour == 000100) begin
    if (yel_return_timer > 0) begin
        if (cntr < count*1/4) begin
            GPIO_1 <= 4'b0001;
        end else if (cntr < count*2/4) begin
            GPIO_1 <= 4'b0010;
        end else if (cntr < count*3/4) begin
            GPIO_1 <= 4'b0100;
        end else if (cntr < count*4/4) begin
            GPIO_1 <= 4'b1000;
        yel_return_timer <= yel_return_timer - 1; // Countdown to zero
        end
        cntr <= cntr + 1;
        if (cntr >= count) begin
            cntr <= 0;
        end  
        end else begin
        GPIO_1 <= 4'b0000; 	// Platform is back at the feeder location - stop motor
        p1_on <= 1; 		// Calls platform1 module to tell it that it has return to feeder location and recieved new M&M
        end
    end // Yellow end

    // ORANGE Begin
    else if (colour == 001000) begin
    if (ora_return_timer > 0) begin
        if (cntr < count*1/4) begin
            GPIO_1 <= 4'b1000;
        end else if (cntr < count*2/4) begin
            GPIO_1 <= 4'b0100;
        end else if (cntr < count*3/4) begin
            GPIO_1 <= 4'b0010;
        end else if (cntr < count*4/4) begin
            GPIO_1 <= 4'b0001;
        ora_return_timer <= ora_return_timer - 1; // Countdown to zero
        end
        cntr <= cntr + 1;
        if (cntr >= count) begin
            cntr <= 0;
        end  
        end else begin
        GPIO_1 <= 4'b0000; 	// Platform is back at the feeder location - stop motor
        p1_on <= 1; 		// Calls platform1 module to tell it that it has return to feeder location and recieved new M&M
        end
    end // Orange end

    // BLUE Begin
    else if (colour == 010000) begin
    if (blu_return_timer > 0) begin
        if (cntr < count*1/4) begin
            GPIO_1 <= 4'b1000;
        end else if (cntr < count*2/4) begin
            GPIO_1 <= 4'b0100;
        end else if (cntr < count*3/4) begin
            GPIO_1 <= 4'b0010;
        end else if (cntr < count*4/4) begin
            GPIO_1 <= 4'b0001;
        blu_return_timer <= blu_return_timer - 1; // Countdown to zero
        end
        cntr <= cntr + 1;
        if (cntr >= count) begin
            cntr <= 0;
        end  
        end else begin
        GPIO_1 <= 4'b0000; 	// Platform is back at the feeder location - stop motor
        p1_on <= 1; 		// Calls platform1 module to tell it that it has return to feeder location and recieved new M&M
        end
    end // Blue end

    // GREEN Begin
    else if (colour == 100000) begin
    if (gre_return_timer > 0) begin
        if (cntr < count*1/4) begin
            GPIO_1 <= 4'b1000;
        end else if (cntr < count*2/4) begin
            GPIO_1 <= 4'b0100;
        end else if (cntr < count*3/4) begin
            GPIO_1 <= 4'b0010;
        end else if (cntr < count*4/4) begin
            GPIO_1 <= 4'b0001;
        gre_return_timer <= gre_return_timer - 1; // Countdown to zero
        end
        cntr <= cntr + 1;
        if (cntr >= count) begin
            cntr <= 0;
        end  
        end else begin
        GPIO_1 <= 4'b0000; 	// Platform is back at the feeder location - stop motor
        p1_on <= 1; 		// Calls platform1 module to tell it that it has return to feeder location and recieved new M&M
        end
    end // Green end
  end // Motor end
end // clk end
endmodule
