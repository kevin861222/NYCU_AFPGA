
module Lab05_0811127 (  input CLOCK_50 ,
                        input [9:0] SW ,
                        output [0:0] LEDR ,
                        output [6:0] HEX0 , HEX2 , HEX3 );
wire [3:0] _HEX0 , _HEX1 , _HEX2 , _HEX3 ;

// 32 X 8 RAM
one_port_RAM (  .address( SW [4:0] ),
                .clock( CLOCK_50 ),
                .data( SW [8:5] ),
                .wren( SW [9] ),
                .q( _HEX0 ) );
	// input	[4:0]  address;
	// input	  clock;
	// input	[7:0]  data;
	// input	  wren;
	// output	[7:0]  q;
ssd ssd_0 ( .Din( _HEX0 ),
            .Dout( HEX0 ) );
// ssd ssd_1 ( .Din( _HEX1 ),
//             .Dout( HEX1 ) );
ssd ssd_2 ( .Din( _HEX2 ),
            .Dout( HEX2 ) );
ssd ssd_3 ( .Din( _HEX3 ),
            .Dout( HEX3 ) );

assign _HEX2 = SW [3:0] ;
assign _HEX3 = {3'b000,SW[4]} ;
assign LEDR [0] = SW[9];

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