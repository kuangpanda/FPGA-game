module KeyBoard (  
    input clk, 
    input rst_n,  
    input data_in, 
    input clk_in,   
    output reg[4:0] oControl 
);

reg r1, r2; 
reg[7:0] ps2_data; 
reg[4:0] i; 
wire ps2_clk_n; 
reg done_flag;

always @(posedge clk or negedge rst_n) begin 
    if (!rst_n) begin 
        r1 <= 1'b0; 
		r2 <= 1'b0; 
	end 
    else begin 
		r1 <= clk_in; 
		r2 <= r1; 
	end 
end

assign ps2_clk_n = r2&(!r1); 
  
always @(posedge clk or negedge rst_n) begin 
	if(!rst_n) begin 
		i<= 'd0; 
		done_flag <= 1'b0; 
		ps2_data <= 8'b0; 
	end 
	else begin 
        case(i) 
		    'd0: 
			begin 
			    if (ps2_clk_n) begin
                    i <= i + 1'b1;
                end  
                else begin 
                    i <= i; 
                end
            end 
            'd1, 'd2, 'd3, 'd4, 'd5, 'd6, 'd7, 'd8:  
			begin 
				if (ps2_clk_n) begin 
					i <= i + 1'b1; 
					ps2_data[i-1] <= data_in; 
				end 
				else begin 
                    i <= i;
                end 
			end 
			'd9,'d10: 
			begin 
				if (ps2_clk_n) begin 
					i <= i + 1'b1; 
                end
				else begin 
					i <= i;
                end 
			end 
			'd11:
			begin 
				if (ps2_data==8'hF0) begin
					i <= 'd12; 
				end
				else begin
					i <= 'd23;
                end 
			end 
			'd12,'d13,'d14,'d15,'d16,'d17,'d18,'d19,'d20,'d21,'d22: 
			begin 
				if (ps2_clk_n) begin 
					i <= i + 1'b1;
                end
				else begin 
					i <= i;
                end 
			end 
			'd23: 
			begin 
				i <= i + 1'b1; 
				done_flag <= 1'b1; 
			end 
			'd24: 
			begin 
				i <= 'd0; 
				done_flag <= 1'b0; 
			end 
			default:
            begin
                i <= 'd0;
            end 
		endcase
	end
end

always @(posedge clk or negedge rst_n) begin 
	if (!rst_n) begin 
		oControl <= 5'b00000;
    end 
	else if (done_flag) begin 
		case(ps2_data) 
			8'h1d:
            begin 
				oControl <= 5'b10000;
			end 
			8'h1b://down
			begin 
				oControl <= 5'b01000; 
			end 
			8'h1C: //left
			begin 
				oControl <= 5'b00100;; 
			end 
			8'h23://right 
			begin 
				oControl <= 5'b00010; 
			end 
			8'h5a: //begin
			begin 
				oControl <= 5'b00001; 
			end		
			default: 
            begin
                oControl <= 5'b00000;
            end	    
		endcase
    end
end

endmodule
