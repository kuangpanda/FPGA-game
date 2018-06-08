module	VGA_Pattern	(	//	Read Out Side
						oRed,
						oGreen,
						oBlue,
						iVGA_X,
						iVGA_Y,
						iVGA_CLK,
						//	Control Signals
						iRST_n,
						iSlider_x,
						iSlider_y,
						iBall_x,
						iBall_y
						);
//	Read Out Side
output	reg	[9:0]	oRed;
output	reg	[9:0]	oGreen;
output	reg	[9:0]	oBlue;
input	[9:0]		iVGA_X;
input	[9:0]		iVGA_Y;
input   [9:0]       iSlider_x;
input   [9:0]       iSlider_y;
input   [9:0]       iBall_x;
input   [9:0]       iBall_y;
input				iVGA_CLK;
//	Control Signals
input				iRST_n;

always@(posedge iVGA_CLK or negedge iRST_n)
begin
	if(!iRST_n) begin
		oRed	<=	0;
		oGreen	<=	0;
		oBlue	<=	0;
	end
	else if (iVGA_Y>=(iSlider_y - 20) && iVGA_Y<=(iSlider_y + 20) && iVGA_X <= (iSlider_x + 50) && iVGA_X >= (iSlider_x - 50)) begin
	  	oRed <= 0;
		oBlue <= 0; 
		oGreen <= 4;
	end
	else if (iVGA_Y>=(iBall_y - 10) && iVGA_Y <= (iBall_y + 10) && iVGA_X <= (iBall_x + 10) && iVGA_X >= (iBall_x - 10)) begin
		oRed <= 0;
		oBlue <= 0;
		oGreen <= 0;
	end 
	else begin
	    oRed <= 8;
		oBlue <= 8; 
		oGreen <= 8;
	end	
end

endmodule
