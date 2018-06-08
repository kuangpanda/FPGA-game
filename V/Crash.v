module Crash(
	iSlider_x,
	iSlider_y,
	iBall_x,
	iBall_y,

	oCrash
);

// location
input [9:0] iSlider_x;
input [9:0] iSlider_y;
input [9:0] iBall_x;
input [9:0] iBall_y;

// output
output [3:0] oCrash;

wire left;
wire right;
wire up;
wire down;

assign left = (iBall_x <= 10) ? 1 : 0 || (
    ((iBall_x - 10) == (iSlider_x + 50)) &&
    ((iBall_y - 10) >= (iSlider_y - 20)) &&
    ((iBall_y + 10) <= (iSlider_y + 20)));


assign right = (iBall_x >= 630) ? 1 : 0 || (
    ((iBall_x + 10) == (iSlider_x - 50)) &&
    ((iBall_y - 10) >= (iSlider_y - 20)) &&
    ((iBall_y + 10) <= (iSlider_y + 20)));


assign up = (iBall_y <= 10) ? 1 : 0 || (
    ((iBall_y - 10) == (iSlider_y + 20)) &&
    ((iBall_x - 10) >= (iSlider_x - 50)) &&
    ((iBall_x + 10) <= (iSlider_x + 50)));


assign down = (iBall_y >= 470) ? 1 : 0 || (
    ((iBall_y + 10) == (iSlider_y - 20)) &&
    ((iBall_x - 10) >= (iSlider_x - 50)) &&
    ((iBall_x + 10) <= (iSlider_x + 50)));

assign oCrash = {left, right, up, down};
endmodule
