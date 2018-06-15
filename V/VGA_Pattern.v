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
						iBall_y,
						iState_flag,
						iSlider_flag
						);

`include "Setting.v"			
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
input	[299:0]		iState_flag;
input	[1:0]		iSlider_flag;
input				iVGA_CLK;
//	Control Signals
input				iRST_n;

reg 	[10:0]	blockX,blockY;
integer numF;
always@(posedge iVGA_CLK)
begin
	blockX	= iVGA_X >> 5 ;
	blockY	= iVGA_Y >> 5 ;
	numF 	= blockX + (blockY * 20) ;
end

always@(posedge iVGA_CLK or negedge iRST_n)
begin
	if(!iRST_n) begin
		oRed	<=	0;
		oGreen	<=	0;
		oBlue	<=	0;
	end
	else if (iVGA_Y>=(iSlider_y - 20) && iVGA_Y<=(iSlider_y + 20) && iVGA_X <= (iSlider_x + 50) && iVGA_X >= (iSlider_x - 50)) begin
	  	oRed <= 0;
		oBlue <= 8; 
		oGreen <= 8;
	end
	else if (iVGA_Y>=(iBall_y - 10) && iVGA_Y <= (iBall_y + 10) && iVGA_X <= (iBall_x + 10) && iVGA_X >= (iBall_x - 10)) begin
		oRed <= 12;
		oBlue <= 12;
		oGreen <= 12;
	end 
	else if (iVGA_Y >= 280 && iVGA_Y <= 312 && iVGA_X >= 100 && iVGA_X <= 196) begin
		if(iSlider_flag[0]) begin
			oRed <= 9;
			oBlue <= 1; 
			oGreen <= 8;
		end
		else begin
	    	oRed <= 0;
			oBlue <= 0; 
			oGreen <= 0;
		end
	end
	else if (iVGA_Y >= 230 && iVGA_Y <= 262 && iVGA_X >= 500 && iVGA_X <= 596) begin
		if(iSlider_flag[0]) begin
			oRed <= 9;
			oBlue <= 1; 
			oGreen <= 8;
		end
		else begin
	    	oRed <= 0;
			oBlue <= 0; 
			oGreen <= 0;
		end
	end
	else if (iVGA_Y>=(blockY * 32 + 1) && iVGA_Y<=((blockY+1)*32 - 1) && iVGA_X>=(blockX*32 + 1) && iVGA_X<=((blockX+1)*32 - 1)) begin
		if (iState_flag[numF]==1) begin
			oRed <= 15;
			oBlue <= 7;
			oGreen <= 0;
		end	
		else begin
	    oRed <= 0;
		oBlue <= 0; 
		oGreen <= 0;
		end
	end	
	else begin
	    oRed <= 0;
		oBlue <= 0; 
		oGreen <= 0;
	end	
end

endmodule
