`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:20:50 01/28/2020 
// Design Name: 
// Module Name:    adc 
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
module adc(
input clock_in,
input miso,
output sck,
output ad_conv,
output res
);

reg [15:0] clock_divider = 16'b0;

always @ (posedge clock_in)
	clock_divider <= clock_divider + 1;

wire clock;
assign clock = clock_divider[0];

//----------ad signal-------------------------
reg [63:0] ad = 64'h8000_0000_0000_0000;

always @ (negedge clock)
	ad <= {ad[0],ad[63:1]};

wire conv = ad[63];
assign ad_conv = conv;
//---------------------------------------------

//----------sck signal-------------------------
reg [5:0] condition = 6'b000000;
always @ (posedge clock)
	condition <= condition + 1;

assign control = (condition == 6'b000000 || condition == 6'b000001 || condition == 6'b111111 || condition == 6'b111110);

wire sck2;
assign sck2 = (~control)&clock;

assign sck = sck2;	
//----------------------------------------------

//----------miso input--------------------------
reg [5:0] pointer = 6'b000000;

always @ (posedge clock)
	if(conv == 1) pointer <= 6'b000000;
	else pointer <= pointer + 1;
	
wire miso_control;
assign miso_control = (pointer == 6'd4 || pointer == 6'd5 || pointer == 6'd6 || pointer == 6'd7 || pointer == 6'd8 || pointer == 6'd9 || pointer == 6'd10 || pointer == 6'd11 || pointer == 6'd12 || pointer == 6'd13 || pointer == 6'd14 || pointer == 6'd15 || pointer == 6'd16 || pointer == 6'd17); 
//                                   13                 12                11                 10                 9                  8                 7                  6                    5                 4                   3                 2                   1                  0

reg [13:0] data;
always @ (negedge clock)
	if(miso_control == 1'b1) data <= {miso,data[13:1]};

assign res = data; 
//----------------------------------------------

endmodule
