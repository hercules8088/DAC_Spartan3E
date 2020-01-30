`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:44:22 01/29/2020
// Design Name:   top_adc
// Module Name:   C:/Users/HP/Desktop/DAC/adc/t_top_adc.v
// Project Name:  adc
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_adc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t_top_adc;

	// Inputs
	reg clock_in;
	reg start;
	reg miso;

	// Outputs
	wire AMP_CS;
	wire MOSI;
	wire AMP_SHDN;
	wire ad_conv;
	wire res;
	wire final_sck;

	// Instantiate the Unit Under Test (UUT)
	top_adc uut (
		.AMP_CS(AMP_CS), 
		.MOSI(MOSI), 
		.AMP_SHDN(AMP_SHDN), 
		.clock_in(clock_in), 
		.start(start), 
		.miso(miso), 
		.ad_conv(ad_conv), 
		.res(res), 
		.final_sck(final_sck)
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
	start = 0;
	#9994;
	start = 1;
	#1193;
	start = 0;
	end
      
endmodule

