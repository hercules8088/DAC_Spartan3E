`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:05:51 01/06/2020 
// Design Name: 
// Module Name:    DAC 
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
module gain_sel(
    output reg AMP_CS,
    output SPI_SCK,
    output reg MOSI,
    output AMP_SHDN,
	input clock_in,
	input start
    );

assign AMP_SHDN = 1'b0;
reg [15:0] clock_counter = 16'b0;
always@(posedge clock_in)
begin 
clock_counter <= clock_counter + 1;
end
assign SPI_SCK = clock_counter[0];
assign clock = clock_counter[0];

parameter S_idle = 1'b0,
			S_active = 1'b1;
			
reg state = S_idle;
reg [3:0] count;
reg T_0,T_1;

always@(posedge clock)
begin
case(state)
	S_idle:	begin
					T_0 <= 1'b1;
					T_1 <= 1'b0;
					if(start == 1'b1)
						begin
							state <= S_active;
						end
				end
	S_active: begin
					T_0 <= 1'b0;
					T_1 <= 1'b1;
					if(count == 4'b0111)
						state <= S_idle;
				end
endcase
end

always@(negedge clock)
begin
if(T_0 == 1'b1)
	begin
		AMP_CS <= 1'b1;
		MOSI <= 1'b1;
		count <= 4'b0;
	end
	
else if(T_1 == 1'b1)
	begin 
		count <= count+1;
		AMP_CS <= 1'b0;
		case(count)
			4'd3: MOSI<=1'b1;
			4'd7: MOSI<=1'b1;
			default: MOSI<=1'b0;		
		endcase
	end
end

endmodule