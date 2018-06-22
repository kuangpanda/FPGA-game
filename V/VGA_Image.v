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


reg[9:0] Xcoloradd;
reg[15:0] Ycoloradd;

wire[15:0] coloradd;

wire color;


// calculate horizontal location
always@(posedge iVGA_CLK or negedge iRST_n) begin
	if(!iRST_n) begin
		Xcoloradd <= 10'b0;
	end
 	else if(iVGA_X >= 10 && iVGA_X < 522) begin
		Xcoloradd <= Xcoloradd + 1'b1;
	end
 	else begin
	  	Xcoloradd <= 0;
	end
end

always@(posedge iVGA_CLK or negedge iRST_n) begin
	if(!iRST_n) begin
		Ycoloradd <= 16'b0;
	end
 	else if(iVGA_Y >= 200 && iVGA_Y < 328) begin
        Ycoloradd <= (iVGA_Y - 200)* 512;
	end
 	else begin
	 	Ycoloradd <= 0;
	end
end

assign coloradd = Ycoloradd + Xcoloradd;

block u1(coloradd,iVGA_CLK,color);

wire valid;

assign valid=((iVGA_Y >= 200 && iVGA_Y < 328) && (iVGA_X >= 10 && iVGA_X < 522)) ? 1 : 0; 
//output pictures
assign			  oBlue = valid ? {4{color}} : 0;			  
assign			  oGreen = valid ? {4{color}} : 0;
assign			  oRed = valid ? {4{color}} : 0;

endmodule
