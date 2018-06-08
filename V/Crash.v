module Crash(
	clk,
	rst,
	iSlider_x,
	iSlider_y,
	iBall_x,
	iBall_y,

    oState_flag, // block state flag
	oCrash
);

// location
input clk;
input rst;
input [9:0] iSlider_x;
input [9:0] iSlider_y;
input [9:0] iBall_x;
input [9:0] iBall_y;

// output
output reg [39:0] oState_flag;
output [3:0] oCrash;

wire slider_left, slider_right, slider_up, slider_down;
wire block_left, block_right, block_up, block_down;
wire left, right, up, down;
wire left_x, left_y, right_x, right_y, up_x, up_y, down_x, down_y;

assign left = slider_left || block_left;
assign right = slider_right || block_right;
assign up = slider_up || block_up;
assign down = slider_down || block_down;

assign slider_left = (iBall_x <= 10) ? 1 : 0 || (
    ((iBall_x - 10) == (iSlider_x + 50)) &&
    ((iBall_y - 10) >= (iSlider_y - 20)) &&
    ((iBall_y + 10) <= (iSlider_y + 20)));

assign left_x = (iBall_x - 26) >> 5;
assign left_y = iBall_y >> 5;
assign block_left = oState_flag[left_x + left_y] ? 1 : 0;
//assign oState_flag[left_x + left_y] = block_left ? 0 : 1;

assign slider_right = (iBall_x >= 630) ? 1 : 0 || (
    ((iBall_x + 10) == (iSlider_x - 50)) &&
    ((iBall_y - 10) >= (iSlider_y - 20)) &&
    ((iBall_y + 10) <= (iSlider_y + 20)));

assign right_x = (iBall_x + 26) >> 5;
assign right_y = iBall_y >> 5;
assign block_right = oState_flag[right_x + right_y] ? 1 : 0;
//assign oState_flag[right_x + right_y] = block_right ? 0 : 1;

assign slider_up = (iBall_y <= 10) ? 1 : 0 || (
    ((iBall_y - 10) == (iSlider_y + 20)) &&
    ((iBall_x - 10) >= (iSlider_x - 50)) &&
    ((iBall_x + 10) <= (iSlider_x + 50)));

assign up_x = iBall_x >> 5;
assign up_y = (iBall_y - 26) >> 5;
assign block_up = oState_flag[up_x + up_y] ? 1 : 0;
//assign oState_flag[up_x + up_y] = block_up ? 0 : 1;

assign slider_down = (iBall_y >= 470) ? 1 : 0 || (
    ((iBall_y + 10) == (iSlider_y - 20)) &&
    ((iBall_x - 10) >= (iSlider_x - 50)) &&
    ((iBall_x + 10) <= (iSlider_x + 50)));

assign down_x = iBall_x >> 5;
assign down_y = (iBall_y + 26) >> 5;
assign block_down = oState_flag[down_x + down_y] ? 1 : 0;
//assign oState_flag[down_x + down_y] = block_down ? 0 : 1;

assign oCrash = {left , right, up, down};

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		oState_flag = 1;
	end
	else if(block_left) begin
		if(oState_flag[left_x + left_y]) begin
			oState_flag[left_x + left_y] <= 0;
		end
	end
	else if(block_right) begin
		if(oState_flag[right_x + right_y]) begin
			oState_flag[right_x + right_y] <= 0;
		end
	end
	else if(block_up) begin
		if(oState_flag[up_x + up_y]) begin
			oState_flag[up_x + up_y] <= 0;
		end
	end
	else if(block_down) begin
		if(oState_flag[down_x + down_y]) begin
			oState_flag[down_x + down_y] <= 0;
		end
	end
end
endmodule
