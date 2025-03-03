// 0811127 王語
// LAB03

//import files
//`include "lpm_mult_my.v"
//`include "lpm_add16.v"

//top module
module Lab03_0811127 (  input [3:0] KEY, // press >> 0
                        input [9:0] SW,
                        output [9:9] LEDR,
                        output [6:0] HEX0 , HEX1 , HEX2 , HEX3 );
reg [7:0] A , B , C , D ;
reg [15:0] sum ;
wire [15:0] _sum ;
reg overflow ;
wire _overflow ;
reg [3:0] _hex0 , _hex1 , _hex2 , _hex3 ;
// wire [15:0] sum_ab , sum_cd ;
wire [15:0] A_mult_B , C_mult_D ;

// algorithm
lpm_mult_my AmultB (  .dataa(A),
                        .datab(B),
                        .result(A_mult_B) );

lpm_mult_my CmultD (  .dataa(C),
                        .datab(D),
                        .result(C_mult_D) );

lpm_add16_my add16 (   .dataa(A_mult_B),
                    .datab(C_mult_D),
                    .overflow(_overflow),
                    .result(_sum));

// display part
assign LEDR[9] = _overflow ;

always @(*) begin
    if (KEY[3]) begin           //ABCD
        if (SW[8]) begin        //CD
            _hex0 = D[3:0] ;
            _hex1 = D[7:4] ;
            _hex2 = C[3:0] ;
            _hex3 = C[7:4] ;
        end
        else begin              //AB
            _hex0 = B[3:0] ;
            _hex1 = B[7:4] ;
            _hex2 = A[3:0] ;
            _hex3 = A[7:4] ;
        end
    end
    else begin                  //S
            _hex0 = _sum[3:0] ;
            _hex1 = _sum[7:4] ;
            _hex2 = _sum[11:8] ;
            _hex3 = _sum[15:12] ;
    end
end

ssd ssd_0(.Din(_hex0),.Dout(HEX0));
ssd ssd_1(.Din(_hex1),.Dout(HEX1));
ssd ssd_2(.Din(_hex2),.Dout(HEX2));
ssd ssd_3(.Din(_hex3),.Dout(HEX3));

//set part and algorithm
always @(negedge KEY[1] or negedge KEY[0]) begin
    if (!KEY[0]) begin:reset
        A <= 8'b0000_0000 ;
        B <= 8'b0000_0000 ;
        C <= 8'b0000_0000 ;
        D <= 8'b0000_0000 ;
        sum <= 16'b0000_0000_0000_0000 ;
        overflow <= 1'b0 ;
    end
    else begin:set_and_algorithm
        //algorithm part
		// sum <= _sum ;
        // overflow <= _overflow ;
        //set part
        if (SW[9]) begin:write_enable
            if (!SW [8]) begin       // AB
                if (KEY[2]) begin   //A
                    A <= SW[7:0];
                end
                else begin          //B
                    B <= SW[7:0];
                end
            end
            else begin              //CD
                if (KEY[2]) begin   //C
                    C <= SW[7:0];   
                end
                else begin          //D
                    D <= SW[7:0];
                end
            end
        end
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

// sub modules from LPM
module lpm_add16_my (
	dataa,
	datab,
	overflow,
	result);

	input	[15:0]  dataa;
	input	[15:0]  datab;
	output	  overflow;
	output	[15:0]  result;

	wire  sub_wire0;
	wire [15:0] sub_wire1;
	wire  overflow = sub_wire0;
	wire [15:0] result = sub_wire1[15:0];

	lpm_add_sub	LPM_ADD_SUB_component (
				.dataa (dataa),
				.datab (datab),
				.overflow (sub_wire0),
				.result (sub_wire1)
				// synopsys translate_off
				,
				.aclr (),
				.add_sub (),
				.cin (),
				.clken (),
				.clock (),
				.cout ()
				// synopsys translate_on
				);
	defparam
		LPM_ADD_SUB_component.lpm_direction = "ADD",
		LPM_ADD_SUB_component.lpm_hint = "ONE_INPUT_IS_CONSTANT=NO,CIN_USED=NO",
		LPM_ADD_SUB_component.lpm_representation = "UNSIGNED",
		LPM_ADD_SUB_component.lpm_type = "LPM_ADD_SUB",
		LPM_ADD_SUB_component.lpm_width = 16;


endmodule

module lpm_mult_my (
	dataa,
	datab,
	result);

	input	[7:0]  dataa;
	input	[7:0]  datab;
	output	[15:0]  result;

	wire [15:0] sub_wire0;
	wire [15:0] result = sub_wire0[15:0];

	lpm_mult	lpm_mult_component (
				.dataa (dataa),
				.datab (datab),
				.result (sub_wire0),
				.aclr (1'b0),
				.clken (1'b1),
				.clock (1'b0),
				.sum (1'b0));
	defparam
		lpm_mult_component.lpm_hint = "MAXIMIZE_SPEED=9",
		lpm_mult_component.lpm_representation = "UNSIGNED",
		lpm_mult_component.lpm_type = "LPM_MULT",
		lpm_mult_component.lpm_widtha = 8,
		lpm_mult_component.lpm_widthb = 8,
		lpm_mult_component.lpm_widthp = 16;


endmodule
