module Slider (	//	Read Out Side
	iVGA_CLK,
    iRST_n,
    
    iSlider_go,
    iSlider_back,
    iSlider_up,
    iSlider_down,

    iSpecial_block,

	oSlider_x,
    oSlider_y
);

`include "Setting.v"

input iSlider_go;
input iSlider_back;
input iSlider_up;
input iSlider_down;

input iSpecial_block;

input iVGA_CLK;

//	Control Signals
input iRST_n;

output	[9:0] oSlider_y;
output	[9:0] oSlider_x;

reg [9:0] slider_x;
reg [9:0] slider_y;

assign oSlider_x = slider_x;
assign oSlider_y = slider_y;

always @(posedge iVGA_CLK or negedge iRST_n) begin
    if (!iRST_n) begin
        slider_x <= SLIDER_X_INIT_LOCATION;
    end 
    else if (slider_x <= SLIDER_LEFT_BOUNDARY) begin
        slider_x <= slider_x + 1;
    end
    else if (slider_x >= SLIDER_RIGHT_BOUNDARY) begin
        slider_x <= slider_x - 1;
    end
    else if(iSpecial_block==0)
    begin
        if (iSlider_go) begin
            slider_x <= slider_x + 5;
        end
        else if (iSlider_back) begin
            slider_x <= slider_x - 5;
        end
        else begin 
            slider_x <= slider_x;
        end
    end
    else if(iSpecial_block==1)
    begin
        if (iSlider_go) begin
            slider_x <= slider_x + 3;
        end
        else if (iSlider_back) begin
            slider_x <= slider_x - 3;
        end
        else begin 
            slider_x <= slider_x;
        end
    end
end

always @(posedge iVGA_CLK or negedge iRST_n) begin
    if (!iRST_n) begin
        slider_y <= SLIDER_Y_INIT_LOCATION;
    end 
    else if (slider_y <= SLIDER_UP_BOUNDARY) begin
        slider_y <= slider_y + 2;
    end
    else if (slider_y >= SLIDER_DOWN_BOUNDARY) begin
        slider_y <= slider_y - 2;
    end
    else if (iSlider_up) begin
        slider_y <= slider_y - 2;
    end
    else if (iSlider_down) begin
        slider_y <= slider_y + 2;
    end
    else begin 
        slider_y <= slider_y;
    end
end

endmodule
