// slider
parameter SLIDER_LENGTH = 100;
parameter SLIDER_WIDTH  = 10;
parameter SLIDER_LEFT_BOUNDARY = 50; 
parameter SLIDER_RIGHT_BOUNDARY = 590;
parameter SLIDER_UP_BOUNDARY = 400;
parameter SLIDER_DOWN_BOUNDARY = 475;
parameter SLIDER_X_INIT_LOCATION = 320;
parameter SLIDER_Y_INIT_LOCATION = 475;
parameter SLIDER_LOW_SPEED = 2;
parameter SLIDER_MEDIUM_SPEED = 2; 
parameter SLIDER_HIGH_SPEED = 3;
// ball
parameter BALL_X_INIT_LOCATION = 320;
parameter BALL_Y_INIT_LOCATION = 420;
parameter BALL_RADIUS = 10;
parameter BALL_TOWARD_RIGHT = 0; 
parameter BALL_TOWARD_LEFT = 1;
parameter BALL_TOWARD_UP = 1;
parameter BALL_TOWARD_DOWN = 0;

// block
parameter BLOCK_SIZE = 32;
// parameter [299:0] BLOCK_RST_1 = 300'h00000_00000_00000_00000_00000_00000_00000_00000_00000_00000_00000_00000_00000_FFFFF_FFFFF ;
parameter [299:0] BLOCK_RST_1 = 300'h00000_00000_00000_00000_00000_00000_00000_00000_00000_00000_00000_00000_00100_0FFF0_00000 ;
parameter [299:0] BLOCK_RST_2 = 300'h00000_00000_00000_00000_00000_00000_00000_00000_00000_00000_00000_0FFF0_1FFF8_3FFFC_00000 ;
parameter [299:0] BLOCK_RST_3 = 300'h00000_00000_00000_00000_00000_00000_00000_00000_00000_00000_55FAA_0FFF0_7FFFE_0FFF0_0F0F0 ;
//parameter [299:0] BLOCK_RST_1 =   300'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_000 ;
                            
// control
