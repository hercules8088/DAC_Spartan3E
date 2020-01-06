`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:37:38 01/06/2020
// Design Name:   DAC
// Module Name:   C:/Users/hp/DAC/test_DAC.v
// Project Name:  DAC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DAC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_DAC;

	// Inputs
	reg start = 1'b0;
	reg clock_in = 1'b0;;
	reg half = 1'b0;
	// Outputs
	wire select;
	wire clock;
	wire MOSI;
	wire reset;

	// Instantiate the Unit Under Test (UUT)
	DAC uut (
		.select(select), 
		.clock(clock), 
		.MOSI(MOSI), 
		.reset(reset), 
		.start(start), 
		.clock_in(clock_in),
		.half(half)
	);
initial begin
#55 start <= 1'b1;
#200 start <= 1'b0;

#5000 start <= 1'b1;
#200	start <= 1'b0;
end

	initial begin
		forever begin #5 clock_in <= ~clock_in; end
	end
      
endmodule

