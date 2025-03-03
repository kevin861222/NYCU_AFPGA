// 0811127
module Lab_06_0811127 (	input [2:0] KEY ,
						output [7:0] LEDR ,
						output [6:0] HEX0 , HEX1 , HEX2 , HEX3 , HEX4 , HEX5 );
// 	宣告
wire [4:0] _addr ;
wire  [7:0] _Din ;
wire [3:0] _HEX0 , _HEX1 , _HEX2 , _HEX3 , _HEX4 , _HEX5 ;
wire Mclk , Pclk ;
// clk 
assign Mclk = KEY[1] ;
assign Pclk = KEY[2] ;
// 七段顯示器設定
assign _HEX4 = _Din[3:0] ;
assign _HEX5 = _Din[7:4] ;

ssd ssd_0 ( .Din( _HEX0 ),
            .Dout( HEX0 ) );
ssd ssd_1 ( .Din( _HEX1 ),
            .Dout( HEX1 ) );
ssd ssd_2 ( .Din( _HEX2 ),
            .Dout( HEX2 ) );
ssd ssd_3 ( .Din( _HEX3 ),
            .Dout( HEX3 ) );
ssd ssd_4 ( .Din( _HEX4 ),
            .Dout( HEX4 ) );
ssd ssd_5 ( .Din( _HEX5 ),
            .Dout( HEX5 ) );
// ROM (IP)
ROM_32x8 rom1 (	.address(_addr),
				.clock(Mclk),
				.q(_Din) );

counter32 counter_0 (	.clk(Mclk),
						.num(_addr),
						.resetn(KEY[0]) );

processor processor_0 (	.clk(Pclk),
						.Bus(LEDR[7:0]),
						.R0({_HEX3,_HEX2}),
						.R1({_HEX1,_HEX0}),
						.Din(_Din),
						.resetn(KEY[0]) );
endmodule

// sub module
// seven segment display
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

module counter32 (	input clk,
					input resetn,
					output reg [4:0] num );


always @(posedge clk or negedge resetn ) begin
	if (! resetn) begin
		num = 5'b00000;
	end
	else begin
		num <= num + 1'b1;
	end
end
	
endmodule

module processor (	input [7:0] Din ,
					input clk ,
					input resetn ,
					output [7:0] R0 ,
					output [7:0] R1 ,
					output reg [7:0] Bus );
// 宣告
reg [7:0] R [7:0] ; // R are regs of 8 address with 8 bits for every address.
// [bits] R [address ( How many ) ] 
// use : R [address] [bits] = ...
reg mvi ;
reg [2:0] mvi_addr ;
wire [1:0] _II ;
wire [2:0] _XXX , _YYY , _mvi ;
reg [7:0] temp_add , temp_sub , temp_bus ;
// 指令
assign _II = Din [7:6] ;
assign _XXX = Din [5:3] ;
assign _YYY = Din [2:0] ;
// 需要顯示的 R0 以及 R1
assign	R0 = R[0] ;
assign	R1 = R[1] ;
// assign Bus = Din ;
always @(posedge clk or negedge resetn ) begin
	// cow bear : temp <= R [_XXX] ;
		// Bus <= temp_sub ;
		if (!resetn) begin:if_reset
			R[0] = 8'd0 ;
			R[1] = 8'd0 ;
			R[2] = 8'd0 ;
			R[3] = 8'd0 ;
			R[4] = 8'd0 ;  
			R[5] = 8'd0 ;
			R[6] = 8'd0 ;
			R[7] = 8'd0 ;
		end
		else begin
			Bus <= Din ;
			if (mvi) begin
				mvi <= 0 ;
				R[mvi_addr] = Din ;
			end
			else begin
				case (_II)
					2'b00: begin
						R[_XXX] = R[_YYY] ;
						//Bus = R[_YYY] ; // X
					end
					2'b01: begin // 如果接收到MVI指令，下次指令當成存入數值
						// R[_XXX] = Din
						mvi_addr <= _XXX ;
						mvi <= 1 ; //X
						//Bus = Din ;
					end
					2'b10: begin
						temp_add = R[_XXX] + R[_YYY] ;
						R[_XXX] = temp_add ;
						//Bus = R[_XXX] + R[_YYY] ;
					end
					2'b11: begin
						temp_sub = R[_XXX] - R[_YYY] ;
						R[_XXX] = temp_sub ;
						//Bus = R[_XXX] - R[_YYY] ;
					end
					default: begin // 這邊不用理他
						R[0] <= 8'd0 ;
						R[1] <= 8'd0 ;
						R[2] <= 8'd0 ;
						R[3] <= 8'd0 ;
						R[4] <= 8'd0 ;  
						R[5] <= 8'd0 ;
						R[6] <= 8'd0 ;
						R[7] <= 8'd0 ;
					end
				endcase
			end
		end
	end
endmodule
