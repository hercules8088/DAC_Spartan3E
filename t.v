`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:17:46 01/29/2020
// Design Name:   adc
// Module Name:   C:/Users/HP/Desktop/DAC/adc/t.v
// Project Name:  adc
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: adc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t;

	// Inputs
	reg clock_in;
	reg miso;

	// Outputs
	wire sck;
	wire ad_conv;

	// Instantiate the Unit Under Test (UUT)
	adc uut (
		.clock_in(clock_in), 
		.miso(miso), 
		.sck(sck), 
		.ad_conv(ad_conv)
	);

	initial begin
		// Initialize Inputs
		clock_in = 0;

		// Wait 100 ns for global reset to finish
		forever
		begin
		#5;
      clock_in = ~clock_in; 
		end
		// Add stimulus here

	end
	
	initial
	begin
	miso = 1;
	forever 
	begin
	#3;
	miso = ~miso;
	#3;
	miso = ~miso;
	end
	end
   
endmodule

