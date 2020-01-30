`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:26:40 01/29/2020 
// Design Name: 
// Module Name:    top_adc 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top_adc(
output AMP_CS,
//output SPI_SCK,
output MOSI,
output AMP_SHDN,
input clock_in,
input start,

//input clock_in,
input miso,
//output sck,
output ad_conv,
output res,


output final_sck
);

wire sck_for_gain_sel;
gain_sel m1(.AMP_CS(AMP_CS),.SPI_SCK(sck_for_gain_sel),.MOSI(MOSI),.AMP_SHDN(AMP_SHDN),.clock_in(clock_in),.start(start));

wire sck_for_adc;
adc m2(.clock_in(clock_in),.miso(miso),.ad_conv(ad_conv),.res(res),.sck(sck_for_adc));

assign final_sck = start&sck_for_gain_sel | (~start)&sck_for_adc;

endmodule
