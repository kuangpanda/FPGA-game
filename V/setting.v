// slider
parameter   SLIDER_LENGTH = 100;
parameter   HALF_SLIDER_LENGTH = 50;
parameter   SLIDER_WIDTH  = 10;
parameter   HALF_SLIDER_WIDTH = 5;
parameter   SLIDER_LEFT_BOUNDARY = 50; 
parameter   SLIDER_RIGHT_BOUNDARY = 590;
parameter   SLIDER_UP_BOUNDARY = 400;
parameter   SLIDER_DOWN_BOUNDARY = 475;
parameter   SLIDER_X_INIT_LOCATION = 100;
parameter   SLIDER_Y_INIT_LOCATION = 475;
parameter   SLIDER_LOW_SPEED = 1;
parameter   SLIDER_MEDIUM_SPEED = 2; 
parameter   SLIDER_HIGH_SPEED = 3;

// ball
parameter   BALL_X_INIT_LOCATION = 320;
parameter   BALL_Y_INIT_LOCATION = 300;
parameter   BALL_RADIUS = 10;
parameter   BALL_TOWARD_RIGHT = 0; 
parameter   BALL_TOWARD_LEFT = 1;
parameter   BALL_TOWARD_UP = 1;
parameter   BALL_TOWARD_DOWN = 0;

// barrier block location
parameter   LEFT_BARRIER_X_1 = 100; 
parameter   LEFT_BARRIER_X_2 = 196;
parameter   LEFT_BARRIER_Y_1 = 280;
parameter   LEFT_BARRIER_Y_2 = 312;

parameter   RIGHT_BARRIER_X_1 = 500; 
parameter   RIGHT_BARRIER_X_2 = 596;
parameter   RIGHT_BARRIER_Y_1 = 230;
parameter   RIGHT_BARRIER_Y_2 = 262;

// block
parameter   BLOCK_SIZE = 32;
parameter   LINE_BLOCK_COUNT = 20;
parameter   [299:0] BLOCK_RST_1 = 300'h0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0FFF_FFFF_FFF;
                    
// control
