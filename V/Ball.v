module Ball (	//	Read Out Side
	iVGA_CLK,
    iRST_n,
	iCrash,
	oBall_x,
    oBall_y
);

`include "Setting.v"

input iVGA_CLK;

//	Control Signals
input iRST_n;
input   [3:0] iCrash;
output	[9:0] oBall_y;
output	[9:0] oBall_x;

reg [9:0] ball_x;
reg [9:0] ball_y;

assign oBall_x = ball_x;
assign oBall_y = ball_y;

// crash
wire left;
wire right;
wire up;
wire down;
assign left = iCrash[3];
assign right = iCrash[2];
assign up = iCrash[1];
assign down = iCrash[0];

// x_orient = 0 right
reg x_orient;
always @(posedge iVGA_CLK or negedge iRST_n) begin
	if (!iRST_n) begin
	    x_orient <= BALL_TOWARD_RIGHT;
    end
    else if (!x_orient && right) begin // right
	    x_orient <= BALL_TOWARD_LEFT;
    end
    else if (x_orient && left) begin
	    x_orient <= BALL_TOWARD_RIGHT;
    end
    else begin
	    x_orient <= x_orient;
    end
end

always @(posedge iVGA_CLK or negedge iRST_n) begin
	if (!iRST_n) begin
		ball_x <= BALL_X_INIT_LOCATION;
	end
	else if (!x_orient) begin // right
		ball_x  <= ball_x  + 1;
	end
    else if (x_orient) begin
         ball_x <= ball_x - 1;
    end
	else begin
		ball_x <= ball_x;
	end
end

//y_orient = 0 down
reg y_orient;
always@(posedge iVGA_CLK or negedge iRST_n) begin
	if (!iRST_n) begin
	    y_orient <= BALL_TOWARD_DOWN;
    end
    else if (!y_orient && down) begin
	    y_orient <= BALL_TOWARD_UP;
    end
    else if (y_orient && up) begin
	    y_orient <= BALL_TOWARD_DOWN;
    end
    else begin
	    y_orient <= y_orient;
    end
end

always@(posedge iVGA_CLK or negedge iRST_n) begin
	if (!iRST_n) begin
		ball_y  <= BALL_Y_INIT_LOCATION;
	end
	else if (!y_orient) begin
		ball_y  <= ball_y  + 1;
	end
    else if (y_orient) begin
        ball_y  <= ball_y  - 1;
    end
end

endmodule
