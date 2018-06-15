module Level_CTRL(
    iState_flag,
    iLevel_Up,
    iLevel_Down,
    iCLK,
    iRST,
    iBallDie,
    //output level
    oLevel,
    oSlider_flag,
    oRST
);
input iCLK;
input iRST;
input iLevel_Up;
input iLevel_Down;
input [299:0] iState_flag;
input iBallDie;

output reg [1:0] oLevel;
output reg [1:0] oSlider_flag;
output reg oRST;


// parameter SAMPLE_TIME = 16'd4999 ;
// reg [16:0] Count_Level_down_low ,Count_Level_down_high ;
reg [40:0] oRST_COUNT;

initial begin
    oLevel = 2'b00;
    oSlider_flag = 2'b00;
end

wire COUNT_ACT ;
wire PASS_LEVEL;
// assign COUNT_ACT = (!iLevel_Down) || (!iLevel_Up) || (iState_flag==0) || iBallDie;
assign COUNT_ACT = (!iLevel_Down) || (!iLevel_Up) || (iState_flag==0) ;//|| iBallDie;
assign PASS_LEVEL = (iState_flag == 0);

always @(posedge iCLK or negedge iRST)
begin
    if(!iRST)
    begin
        oRST = 0;
    end

    else
    begin
	    oRST <= (oRST_COUNT > 9999999)       ? 0 :  1 ;
        if(COUNT_ACT)
            oRST_COUNT = oRST_COUNT + 1;
        else
            oRST_COUNT = 0;
    end
end

always @(negedge oRST  or negedge iRST )
begin
    if(!iRST)
    begin
        oLevel <= 0;
        oSlider_flag <=2'b00;
    end
    
    else if(!iLevel_Up)
    begin
        if(oLevel != 2) begin
            oLevel <= oLevel + 1;
            oSlider_flag <= 2'b11;
        end
        else begin
            oLevel <= oLevel;
        end
    end
    else if(!iLevel_Down)
    begin
        if(oLevel == 0) begin
            oLevel <= 0;
            oSlider_flag <= 2'b00;
        end
        else if(oLevel == 1) begin
            oLevel <= 0;
            oSlider_flag <= 2'b00;
        end
        else if(oLevel ==2) begin
            oLevel <= 1;
            oSlider_flag <= 2'b11;
        end
    end
    else if (oLevel < 2 && iState_flag==0)begin
        oLevel <= oLevel + 1;
        oSlider_flag <= 2'b11;
    end
end



endmodule