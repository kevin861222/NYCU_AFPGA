module Lab04_0811127(   input [0:0] KEY,
                        input [2:0] SW,
                        output [6:0] HEX0 );
reg [3:0] _hex0 ;
wire [1:0] control;
ssd ssd_0(.Din(_hex0),.Dout(HEX0));

assign control = {SW[2],SW[1]};

always @( negedge KEY[0] ) begin
    if (!SW[0]) begin:Active_low_reset
        _hex0 <= 4'd0 ;
    end
    else begin
        case ( _hex0 )
            4'd0: begin 
                case (control)
                    2'd0: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end 
                    2'd1: begin
                        _hex0 <= _hex0 + 4'd1 ;
                    end 
                    2'd2: begin
                        _hex0 <= _hex0 + 4'd2 ;
                    end 
                    2'd3: begin
                        _hex0 <= 4'd9 ;
                    end 
                    default: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end
                endcase
            end
            4'd1: begin
                case (control)
                    2'd0: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end 
                    2'd1: begin
                        _hex0 <= _hex0 + 4'd1 ;
                    end 
                    2'd2: begin
                        _hex0 <= _hex0 + 4'd2 ;
                    end 
                    2'd3: begin
                        _hex0 <= _hex0 - 4'd1 ;
                    end 
                    default: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end
                endcase
            end
            4'd2: begin
                case (control)
                    2'd0: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end 
                    2'd1: begin
                        _hex0 <= _hex0 + 4'd1 ;
                    end 
                    2'd2: begin
                        _hex0 <= _hex0 + 4'd2 ;
                    end 
                    2'd3: begin
                        _hex0 <= _hex0 - 4'd1 ;
                    end 
                    default: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end
                endcase
            end
            4'd3: begin
                case (control)
                    2'd0: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end 
                    2'd1: begin
                        _hex0 <= _hex0 + 4'd1 ;
                    end 
                    2'd2: begin
                        _hex0 <= _hex0 + 4'd2 ;
                    end 
                    2'd3: begin
                        _hex0 <= _hex0 - 4'd1 ;
                    end 
                    default: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end
                endcase
            end
            4'd4: begin
                case (control)
                    2'd0: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end 
                    2'd1: begin
                        _hex0 <= _hex0 + 4'd1 ;
                    end 
                    2'd2: begin
                        _hex0 <= _hex0 + 4'd2 ;
                    end 
                    2'd3: begin
                        _hex0 <= _hex0 - 4'd1 ;
                    end 
                    default: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end
                endcase
            end
            4'd5: begin
                case (control)
                    2'd0: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end 
                    2'd1: begin
                        _hex0 <= _hex0 + 4'd1 ;
                    end 
                    2'd2: begin
                        _hex0 <= _hex0 + 4'd2 ;
                    end 
                    2'd3: begin
                        _hex0 <= _hex0 - 4'd1 ;
                    end 
                    default: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end
                endcase
            end
            4'd6: begin
                case (control)
                    2'd0: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end 
                    2'd1: begin
                        _hex0 <= _hex0 + 4'd1 ;
                    end 
                    2'd2: begin
                        _hex0 <= _hex0 + 4'd2 ;
                    end 
                    2'd3: begin
                        _hex0 <= _hex0 - 4'd1 ;
                    end 
                    default: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end
                endcase
            end
            4'd7: begin
                case (control)
                    2'd0: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end 
                    2'd1: begin
                        _hex0 <= _hex0 + 4'd1 ;
                    end 
                    2'd2: begin
                        _hex0 <= _hex0 + 4'd2 ;
                    end 
                    2'd3: begin
                        _hex0 <= _hex0 - 4'd1 ;
                    end 
                    default: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end
                endcase
            end
            4'd8: begin
                case (control)
                    2'd0: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end 
                    2'd1: begin
                        _hex0 <= _hex0 + 4'd1 ;
                    end 
                    2'd2: begin
                        _hex0 <= 4'd0 ;
                    end 
                    2'd3: begin
                        _hex0 <= _hex0 - 4'd1 ;
                    end 
                    default: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end
                endcase
            end
            4'd9: begin
                case (control)
                    2'd0: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end 
                    2'd1: begin
                        _hex0 <= 4'd0 ;
                    end 
                    2'd2: begin
                        _hex0 <= _hex0 + 4'd1 ;
                    end 
                    2'd3: begin
                        _hex0 <= _hex0 - 4'd1 ;
                    end 
                    default: begin
                        _hex0 <= _hex0 + 4'd0 ;
                    end
                endcase
            end
            default: _hex0 <= _hex0 ;
        endcase
    end
end

endmodule

// sub module
//seven segment display
module ssd (	input [3:0] Din,
				output [6:0] Dout ); 
assign Dout[0] =	((!Din[3])&(!Din[2])&(!Din[1])&( Din[0]))|
					((!Din[3])&( Din[2])&(!Din[1])&(!Din[0]))|
					(( Din[3])&( Din[2])&(!Din[1])&( Din[0]))|
					(( Din[3])&(!Din[2])&( Din[1])&( Din[0]));
						
assign Dout[1] =	((!Din[3])&( Din[2])&(!Din[1])&( Din[0]))|
					(          ( Din[2])&( Din[1])&(!Din[0]))|
					(( Din[3])&          ( Din[1])&( Din[0]))|
					(( Din[3])&( Din[2])&          (!Din[0]));
						
assign Dout[2] =	((!Din[3])&(!Din[2])&( Din[1])&(!Din[0]))|
					(( Din[3])&( Din[2])&( Din[1])          )|
					(( Din[3])&( Din[2])&          (!Din[0]));
						                                          
						
assign Dout[3] =	((!Din[3])&(!Din[2])&(!Din[1])&( Din[0]))|
					((!Din[3])&( Din[2])&(!Din[1])&(!Din[0]))|
					(( Din[3])&(!Din[2])&( Din[1])&(!Din[0]))|
					(          ( Din[2])&( Din[1])&( Din[0]));
						
assign Dout[4] =	((!Din[3])&                   &( Din[0]))|
					(          (!Din[2])&(!Din[1])&( Din[0]))|
					((!Din[3])&( Din[2])&(!Din[1])          );
						
						
assign Dout[5] =	(( Din[3])&( Din[2])&(!Din[1])&( Din[0]))|
					((!Din[3])&(!Din[2])&          ( Din[0]))|
					((!Din[3])&(!Din[2])&( Din[1])          )|
					((!Din[3])&          ( Din[1])&( Din[0]));
						
assign Dout[6] =	((!Din[3])&( Din[2])&( Din[1])&( Din[0]))|
					(( Din[3])&( Din[2])&(!Din[1])&(!Din[0]))|
					((!Din[3])&(!Din[2])&(!Din[1])          );
						
endmodule