module	VGA_Image (	//	Read Out Side
						oRed,
						oGreen,
						oBlue,
						iVGA_X,
						iVGA_Y,
						iVGA_CLK,
						//	Control Signals
						iRST_n,
						);
//	Read Out Side
output	[9:0]	oRed;
output	[9:0]	oGreen;
output	[9:0]	oBlue;
input	[10:0]		iVGA_X;
input	[10:0]		iVGA_Y;
input				iVGA_CLK;
//	Control Signals
input				iRST_n;


reg[7:0] Xcoloradd;
reg[14:0] Ycoloradd;

wire[14:0] coloradd;

wire[3:0] colorR;
wire[3:0] colorG;
wire[3:0] colorB;


// calculate horizontal location
always@(posedge iVGA_CLK or negedge iRST_n) begin
	if(!iRST_n) begin
		Xcoloradd <= 8'b0;
	end
 	else if(iVGA_X >= 120 && iVGA_X < 281) begin
		Xcoloradd <= Xcoloradd + 1'b1;
	end
 	else begin
	  	Xcoloradd <= 0;
	end
end

always@(posedge iVGA_CLK or negedge iRST_n) begin
	if(!iRST_n) begin
		Ycoloradd <= 14'b0;
	end
 	else if(iVGA_Y >= 200 && iVGA_Y < 321) begin
        Ycoloradd <= (iVGA_Y - 200)* 160;
	end
 	else begin
	 	Ycoloradd <= 0;
	end
end

assign coloradd = Ycoloradd + Xcoloradd;

R u1(coloradd,iVGA_CLK,colorR);
G u2(coloradd,iVGA_CLK,colorG);
B u3(coloradd,iVGA_CLK,colorB);

wire valid;

assign valid=((iVGA_Y >= 200 && iVGA_Y < 321) && (iVGA_X >= 120 && iVGA_X < 281)) ? 1 : 0; 
//output pictures
assign			  oBlue[3] = valid ? colorB[3] : 0;
assign            oBlue[2] = valid ? colorB[2] : 0;
assign            oBlue[1] = valid ? colorB[1] : 0;
assign			  oBlue[0] = valid ? colorB[0] : 0;
			  
assign			  oGreen[3] = valid ? colorG[3] : 0;
assign			  oGreen[2] = valid ? colorG[2] : 0;
assign			  oGreen[1] = valid ? colorG[1] : 0;
assign			  oGreen[0] = valid ? colorG[0] : 0;
			 
assign			  oRed[3] = valid ? colorR[3] : 0;
assign			  oRed[2] = valid ? colorR[2] : 0;   
assign			  oRed[1] = valid ? colorR[1] : 0;
assign			  oRed[0] = valid ? colorR[0] : 0;

endmodule