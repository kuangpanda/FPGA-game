module LED(
    iLevel,
    iCLK,
    oLED
);
input iCLK;
input [1:0] iLevel;
output reg [6:0] oLED;


always @(posedge iCLK)
begin
    oLED <=     (iLevel == 0) ? 7'b100_0000 : 
                (iLevel == 1) ? 7'b111_1001 :
                (iLevel == 2) ? 7'b010_0100 :
                (iLevel == 3) ? 7'b011_0000 :
                                7'b000_0110 ;
end

endmodule

