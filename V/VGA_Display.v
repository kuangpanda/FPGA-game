/*
 *
 */

module	VGA_Display (	//	Read Out Side
	oRed,
	oGreen,
	oBlue,
	oVGA_VS,
	iVGA_X,
	iVGA_Y,
	iVGA_CLK,
	//	Control Signals
	iRST_n,
    iSW,
	iSlider_x,
	iSlider_y,
	iBall_x,
	iBall_y,
	iState_flag,
	iSlider_flag,
	iSpecial_block,
	iVGA_VS
);

output	[3:0]		oRed;
output	[3:0]		oGreen;
output	[3:0]		oBlue;
output 				oVGA_VS;
input	[9:0]		iVGA_X;
input	[9:0]		iVGA_Y;
input   [9:0]       iSlider_x;
input   [9:0]       iSlider_y;
input   [9:0]       iBall_x;
input   [9:0]       iBall_y;
input	[299:0]		iState_flag;
input	[1:0]		iSlider_flag;
input 				iSpecial_block;
input				iVGA_CLK;
input               iSW;
//	Control Signals
input				iRST_n;
input				iVGA_VS;

wire		[3:0]	sVGA_R1;
wire		[3:0]	sVGA_G1;
wire		[3:0]	sVGA_B1;

wire		[3:0]	sVGA_R2;
wire		[3:0]	sVGA_G2;
wire		[3:0]	sVGA_B2;


assign	oRed	=	(iSW)? sVGA_R2 : sVGA_R1 ;
assign	oGreen	=	(iSW)? sVGA_G2 : sVGA_G1 ;
assign	oBlue	=	(iSW)? sVGA_B2 : sVGA_B1 ;

assign oVGA_VS = (!iSW)?	iVGA_VS : 0;


VGA_Pattern	u1 (	//	Read Out Side
	.oRed(sVGA_R1),
	.oGreen(sVGA_G1),
    .oBlue(sVGA_B1),
	.iVGA_X(iVGA_X),
	.iVGA_Y(iVGA_Y),
	.iVGA_CLK(iVGA_CLK),
	//  Control Signals
	.iRST_n(iRST_n),
	//  Slider location
	.iSlider_x(iSlider_x),
	.iSlider_y(iSlider_y),
	.iBall_x(iBall_x),
	.iBall_y(iBall_y),
	.iState_flag(iState_flag),
	.iSlider_flag(iSlider_flag),
	.iSpecial_block(iSpecial_block)
);

VGA_Image u2 (	//	Read Out Side
	.oRed(sVGA_R2),
	.oGreen(sVGA_G2),
    .oBlue(sVGA_B2),
	.iVGA_X(iVGA_X),
	.iVGA_Y(iVGA_Y),
	.iVGA_CLK(iVGA_CLK),
	//	Control Signals
	.iRST_n(iRST_n)
);

endmodule
