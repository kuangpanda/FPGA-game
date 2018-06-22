module Crash(
	clk,
	rst,

	iLevel,
	iSlider_x,
	iSlider_y,
	iBall_x,
	iBall_y,

	iSlider_flag,
	iSpecial_block,
    oState_flag, // block state flag
	oSpecial_attacked,
	oCrash,
	oBallDie
);

`include "Setting.v"
// location
input clk;
input rst;
input [1:0] iLevel;
input [9:0] iSlider_x;
input [9:0] iSlider_y;
input [9:0] iBall_x;
input [9:0] iBall_y;
input [1:0] iSlider_flag;
input 		iSpecial_block;
// output
output reg [299:0] oState_flag;
output oSpecial_attacked;
output [3:0] oCrash;
output oBallDie;

wire slider_left, slider_right, slider_up, slider_down;
wire special_attacked ;
reg block_left, block_right, block_up, block_down;
wire block_left2, block_right2, block_up2, block_down2;
wire block_left3, block_right3, block_up3, block_down3;
wire left, right, up, down;
wire left_y2,left_y3;
wire right_y2,right_y3;

integer left_x, left_y, right_x, right_y, up_x, up_y, down_x, down_y;
wire up_x2,up_x3;
wire down_x2,down_x3;

assign left  = 	slider_left  || block_left 	;//|| block_left2 	|| block_left3;
assign right = 	slider_right || block_right ;//|| block_right2 || block_right3;
assign up    = 	slider_up 	 || block_up 	;//|| block_up2	|| block_up3;
assign down  =  slider_down  || block_down	;//|| block_down2	|| block_down3;

assign oCrash = {left , right, up, down};
assign oBallDie = (iBall_y > 470) ? 1 : 0;

/////////////////////////////////////////////
//determine if the ball attacks the slider or the special blocks
////////////////////////////////////////////
assign slider_left = (iBall_x <= 10) 	  ? 1 : 0 || 
	(
    ((iBall_x - 10) == (iSlider_x + 50))	 &&
    ((iBall_y + 9) >= (iSlider_y - 20)) 	 &&
    ((iBall_y - 9) <= (iSlider_y + 20)) ) ? 1 : 0 ||
	(
	((iBall_x - 10) <= ( 196 ))	 	 &&
	((iBall_x - 10) >= ( 194 ))	 	 &&
    ((iBall_y + 9) >= ( 280 )) 		 &&
    ((iBall_y - 9) <= ( 312 )) 		 &&
	iSlider_flag[0]	 		)	 ? 1 : 0 ||
	(
    ((iBall_x - 10) <= ( 596 ) )	 &&
	((iBall_x - 10) >= ( 594 ) )	 &&
    ((iBall_y + 9) >= ( 230 ) ) 	 &&
    ((iBall_y - 9) <= ( 262 ) )   &&
	iSlider_flag[1]			  )	 ? 1 : 0 ||
	(
	( (iBall_x - 10) <= (320) )   &&
	( (iBall_x - 10) >= (318) )	  &&
	( (iBall_y + 9) >= (160) )	  &&
	( (iBall_y - 9) <= (192) )    &&
	iSpecial_block			 )		 
	;

assign slider_right = (iBall_x >= 630)	 ? 1 : 0 || (
    ((iBall_x + 10) == (iSlider_x - 50)) 	&&
    ((iBall_y + 9) >= (iSlider_y - 20))	 	&&
    ((iBall_y - 9) <= (iSlider_y + 20))) ? 1 : 0 ||
	(
    ((iBall_x + 10) >= ( 100 )) 	&&
	((iBall_x + 10) <= ( 102 )) 	&&
    ((iBall_y + 9) >= ( 280 ))	 	&&
    ((iBall_y - 9) <= ( 312 )) )	&&
	iSlider_flag[0] 			? 1 : 0 ||
	(
    ((iBall_x + 10) >= (500)) 		&&
	((iBall_x + 10) <= (502)) 		&&
    ((iBall_y + 9) >= (230))	 	&&
    ((iBall_y - 9) <= (262)))		&&
	iSlider_flag[1]				? 1 : 0 ||
	(
	( (iBall_x + 10) <= (288) )   &&
	( (iBall_x + 10) >= (286) )	  &&
	( (iBall_y + 9) >= (160) )	  &&
	( (iBall_y - 9) <= (192) )    &&
	iSpecial_block			 )
	;

assign slider_up = (iBall_y <= 10) 			? 1 : 0 || (
    ((iBall_y - 10) == (iSlider_y + 20)) 	&&
	((iBall_x + 9) >= (iSlider_x - 50)) 	&&
	((iBall_x - 9) <= (iSlider_x + 50)) ) 	? 1 : 0 ||
	(
    ((iBall_y - 10) <= (312)) 	&&
	((iBall_y - 10) >= (310)) 	&&
	((iBall_x + 9) >= (100)) 	&&
	((iBall_x - 9) <= (196)) )  &&
	iSlider_flag[0] 			? 1 : 0 ||
	(
    ((iBall_y - 10) <= (262)) 	&&
	((iBall_y - 10) >= (260)) 	&&
	((iBall_x + 9) >= (500)) 	&&
	((iBall_x - 9) <= (596)) )  &&
	iSlider_flag[1]				? 1 : 0 ||
	(
	( (iBall_x + 9) >= (288) )    &&
	( (iBall_x - 9) <= (320) )	  &&
	( (iBall_y - 10) >= (190) )	  &&
	( (iBall_y - 10) <= (192) )   &&
	iSpecial_block			 )
	;

assign slider_down = (iBall_y >= 470) ? 1 : 0 || (
    ((iBall_y + 10) >= (iSlider_y - 20)) &&
    ((iBall_x + 9) >= (iSlider_x - 50)) &&
    ((iBall_x - 9) <= (iSlider_x + 50))) ? 1 : 0 ||
	(
    ((iBall_y + 10) >= (280)) &&
	((iBall_y + 10) <= (282)) &&
    ((iBall_x + 9) >= (100)) &&
    ((iBall_x - 9) <= (196)) ) &&
	iSlider_flag[0] 			? 1 : 0 ||
	(
    ((iBall_y + 10) >= (230)) &&
	((iBall_y + 10) <= (232)) &&
    ((iBall_x + 9) >= (500)) &&
    ((iBall_x - 9) <= (596)) )&&
	iSlider_flag[1]			? 1 : 0 ||
	(
	( (iBall_x + 9) >= (288) )    &&
	( (iBall_x - 9) <= (320) )	  &&
	( (iBall_y + 10) >= (160) )	  &&
	( (iBall_y + 10) <= (162) )   &&
	iSpecial_block		 )
	;

///////////////////////////////////////
//determine if the special block is attacked
///////////////////////////////////////
assign oSpecial_attacked = 	(iBall_x <= 329) &&
							(iBall_x >= 278) &&
							(iBall_y <= 201) &&
							(iBall_y >= 151);


///////////////////////////////////////////
//determine if the ball attacks the blocks
//////////////////////////////////////////
always @(posedge clk or negedge rst) begin
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


///////////////////////////////////////////////////
//destroy the attacked blocks
////////////////////////////////////////////
always @(posedge clk or negedge rst) #1 begin
	if(!rst) begin
		if(iLevel== 0)
			oState_flag = BLOCK_RST_1;
		else if(iLevel == 1)
			oState_flag = BLOCK_RST_2;
		else
			oState_flag = BLOCK_RST_3;
	end
	else  begin
		//left collider
		if(block_left) begin
			oState_flag[left_x + left_y * 20] <= 0;
		end
		//left collider

		//right collider
		if(block_right) begin
			oState_flag[right_x + right_y * 20] <= 0;
		end
		//right collider

		//up collider
		if(block_up) begin
			oState_flag[up_x + up_y * 20] <= 0;
		end
		//up collider

		//down collider
		if(block_down) begin
			oState_flag[down_x + down_y * 20] <= 0;
		end
		//down collider


	end
end
endmodule
/*
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
end*/