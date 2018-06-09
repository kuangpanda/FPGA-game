module Crash(
	iFrame_CLK,
	rst,
	iSlider_x,
	iSlider_y,
	iBall_x,
	iBall_y,

	iSlider_flag,
    oState_flag, // block state flag
	oCrash
);

`include "Setting.v"
// location
input 				iFrame_CLK;
input				iRST_n;
input	[9:0] 		iSlider_x;
input	[9:0] 		iSlider_y;
input	[9:0] 		iBall_x;
input 	[9:0] 		iBall_y;
input 		 		iSlider_flag;
// output
output	reg	[299:0]	oState_flag;
output 	[3:0] 		oCrash;

wire 				slider_left, slider_right, slider_up, slider_down;
reg 				block_left, block_right, block_up, block_down;
wire 				left, right, up, down;

integer 			left_x, left_y, right_x, right_y, up_x, up_y, down_x, down_y;


assign left  = 	slider_left  || block_left; 
assign right = 	slider_right || block_right; 
assign up    = 	slider_up 	 || block_up; 
assign down  =  slider_down  || block_down; 

assign oCrash = {left , right, up, down};

assign slider_left = (iBall_x <= BALL_RADIUS) 	  	? 1 : 0 || (
    
	((iBall_x - 10) == (iSlider_x + 50))	 		&&
    ((iBall_y + 9) 	>= (iSlider_y - 20)) 	 		&&
    ((iBall_y - 9) 	<= (iSlider_y + 20)) ) 			? 1 : 0 || (
	
	((iBall_x - 10) <= LEFT_BARRIER_X_2)	 	 	&&
	((iBall_x - 10) >= (LEFT_BARRIER_X_2 - 2))	 	&&
    ((iBall_y + 9) 	>= LEFT_BARRIER_Y_1) 		 	&&
    ((iBall_y - 9) 	<= LEFT_BARRIER_Y_2) )	 		&&
	iSlider_flag	 			 					? 1 : 0 || (
		
	((iBall_x - 10) <= RIGHT_BARRIER_X_2 )	 		&&
	((iBall_x - 10) >= ( RIGHT_BARRIER_X_2 - 2))	&&
    ((iBall_y + 9)  >= RIGHT_BARRIER_Y_1 ) 	 		&&
    ((iBall_y - 9)  <= RIGHT_BARRIER_Y_2 ) ) 		&&
	iSlider_flag;

assign slider_right = (iBall_x >= 630)	 			? 1 : 0 || (
    ((iBall_x + 10) == (iSlider_x - 50)) 			&&
    ((iBall_y + 9)  >= (iSlider_y - 20))	 		&&
    ((iBall_y - 9)  <= (iSlider_y + 20))) 			? 1 : 0 || (

    ((iBall_x + 10) >= LEFT_BARRIER_X_1) 			&&
	((iBall_x + 10) <= (LEFT_BARRIER_X_1 + 2) ) 	&&
    ((iBall_y + 9)  >= LEFT_BARRIER_Y_1)	 		&&
    ((iBall_y - 9)  <= LEFT_BARRIER_Y_2) )			&&
	iSlider_flag 									? 1 : 0 || (

    ((iBall_x + 10) >= RIGHT_BARRIER_X_1) 			&&
	((iBall_x + 10) <= RIGHT_BARRIER_X_1 + 2) 		&&
    ((iBall_y + 9)  >= RIGHT_BARRIER_Y_1)	 		&&
    ((iBall_y - 9)  <= RIGHT_BARRIER_Y_2))			&&
	iSlider_flag;

assign slider_up = (iBall_y <= 10) 					? 1 : 0 || (
    ((iBall_y - 10) == (iSlider_y + 20)) 			&&
	((iBall_x + 9)  >= (iSlider_x - 50)) 			&&
	((iBall_x - 9)  <= (iSlider_x + 50)) ) 			? 1 : 0 || (

    ((iBall_y - 10) <= LEFT_BARRIER_Y_2) 			&&
	((iBall_y - 10) >= (LEFT_BARRIER_Y_2 - 2)) 		&&
	((iBall_x + 9)  >= LEFT_BARRIER_X_1) 			&&
	((iBall_x - 9)  <= LEFT_BARRIER_X_2) )  			&&
	iSlider_flag 									? 1 : 0 || (

    ((iBall_y - 10) <= RIGHT_BARRIER_Y_2) 			&&
	((iBall_y - 10) >= (RIGHT_BARRIER_Y_2 - 2)) 	&&
	((iBall_x + 9)  >= RIGHT_BARRIER_X_1) 			&&
	((iBall_x - 9)  <= RIGHT_BARRIER_X_2) )  		&&
	iSlider_flag;

assign slider_down = (iBall_y >= 470) 				? 1 : 0 || (
    ((iBall_y + 10) >= (iSlider_y - 20)) 			&&
    ((iBall_x + 9)  >= (iSlider_x - 50)) 			&&
    ((iBall_x - 9)  <= (iSlider_x + 50))) 			? 1 : 0 || (

    ((iBall_y + 10) >= LEFT_BARRIER_Y_1) 			&&
	((iBall_y + 10) <= (LEFT_BARRIER_Y_1 + 2)) 		&&
    ((iBall_x + 9)  >= LEFT_BARRIER_X_1) 			&&
    ((iBall_x - 9)  <= LEFT_BARRIER_X_2) ) 			&&
	iSlider_flag 									? 1 : 0 || (

    ((iBall_y + 10) >= RIGHT_BARRIER_Y_1) 			&&
	((iBall_y + 10) <= (RIGHT_BARRIER_Y_1 + 2)) 	&&
    ((iBall_x + 9)  >= RIGHT_BARRIER_X_1) 			&&
    ((iBall_x - 9)  <= RIGHT_BARRIER_X_2) )			&&
	iSlider_flag;

always @(posedge iFrame_CLK or negedge iRST_n) begin
	up_x <= iBall_x >> 5;
	up_y <= ( iBall_y - 11 ) >> 5;
	block_up <= oState_flag[up_x + up_y * 20];

	down_x <= iBall_x >> 5;
	down_y <= (iBall_y + 11) >> 5;
	block_down <= oState_flag[down_x + down_y * 20];

	right_x <= (iBall_x + 11) >> 5;
	right_y <= iBall_y >> 5;
	block_right <= oState_flag[right_x + right_y * 20];

	left_x <= (iBall_x - 11) >> 5 ;
	left_y <= iBall_y >> 5;
	block_left <= oState_flag[left_x + left_y * 20];
end

always @(posedge iFrame_CLK or negedge iRST_n) #1 begin
	if (!iRST_n) begin
	   	oState_flag = BLOCK_RST_1;
	end
	else  begin
		//left collider
		if (block_left) begin
			oState_flag[left_x + left_y * 20] <= 0;
		end
		
		//right collider
		if (block_right) begin
			oState_flag[right_x + right_y * 20] <= 0;
		end

		//up collider
		if (block_up) begin
			oState_flag[up_x + up_y * 20] <= 0;
		end

		//down collider
		if (block_down) begin
			oState_flag[down_x + down_y * 20] <= 0;
		end
	end
end
endmodule
