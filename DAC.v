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
module DAC(
    output reg select,
    output clock,
    output reg MOSI,
    output reset,
	 input start,
	 input clock_in,
	 input half
    );

assign reset = 1'b1;
reg [4:0] clock_counter = 5'b0;

always@(posedge clock_in)
begin 
clock_counter <= clock_counter + 1;
end
assign clock = clock_counter[2];

parameter S_idle = 1'b0,
			S_active = 1'b1;
			
reg state = S_idle;
reg [31:0] count;
reg T_0,T_1;
reg [11:0] volt_counter = 12'b0;

always@(posedge clock)
begin
case(state)
	S_idle:	begin
					T_0 <= 1'b1;
					T_1 <= 1'b0;
					if(start == 1'b1)
						begin
							state <= S_active;
							volt_counter <= volt_counter + 1;
						end
				end
	S_active: begin
					T_0 <= 1'b0;
					T_1 <= 1'b1;
					if(count == 5'b11111)
						state <= S_idle;
				end
endcase
end

always@(negedge clock)
begin
if(T_0 == 1'b1)
	begin
		select <= 1'b1;
		MOSI <= 1'b1;
		count <= 32'b0;
	end
	
else if(T_1 == 1'b1)
	begin 
		count <= count+1;
		select <= 1'b0;
		case(count)
			32'd8: MOSI<=1'b0;
			32'd9: MOSI<=1'b0;
			32'd16: MOSI <= volt_counter[11];
			32'd17: MOSI <= volt_counter[10];
			32'd18: MOSI <= volt_counter[9];
			32'd19: MOSI <= volt_counter[8];
//			32'd16: MOSI <= ~half;
			default: MOSI<=1'b1;		
		endcase
	end
end

endmodule
