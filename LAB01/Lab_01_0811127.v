// 0811127 王語

// Top Module
module Lab_01_0811127 (	input  [8:0] SW,
						output [9:9] LEDR,
						output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 );
wire errtemp1 , errtemp2 ;

wire [3:0] sum;
wire cout;

BCD_converter no_name_haha1 (	.v(SW[3:0]),
								.d1(HEX1),
								.d0(HEX0),
								.v5(0),
								.err(errtemp1) );

BCD_converter no_name_haha2 (	.v(SW[7:4]),
								.d1(HEX3),
								.d0(HEX2),
								.v5(0),
								.err(errtemp2) );

BCD_converter no_name_haha3 (	.v(sum),
								.d1(HEX5),
								.d0(HEX4),
								.v5(cout),
								.err() ); //err 忽略

fourbits_adder fourbitsFFD (.a(SW[3:0]),
							.b(SW[7:4]),
							.Cin(SW[8]),
							.Cout(cout),
							.sum(sum) );

assign LEDR[9] = errtemp1|errtemp2;  

endmodule

//Submodules
module BCD_converter (	input [3:0] v,
						input v5 , // 第五個bit
						output [6:0] d1 , d0 ,
						output err );
wire z ;
wire [3:0] vps; //v plus six , 加六進位
wire [6:0] dtemp;
// integer six = 4'd6;
//(X) assign six = 4'd6 ;

fourbits_adder fourbitsFFD (.a(v),
							.b(4'b0110),
							.Cin(0),
							.Cout(),
							.sum(vps) );

fourbits_sel Fourbits_sel(	.s(z|v5),
							.a(vps),
							.b(v),
							.out(dtemp) ); // 用sel 取代 if (z) ... else...

comparator com_1 (	.v(v),
					.z(z) );


assign err = z ;
assign d1[1] = ~(z|v5) ;
assign d1[2] = ~(z|v5) ; // 最多19 直接給1 不然就 0
assign d1 [0] = 1;
//assign d1 [3] = 0;
assign d1[6:3] = 4'b1111; // 共陽極
ssd seven_segment_decoder (	.Din(dtemp),
							.Dout(d0) );


endmodule

module comparator (	input [3:0] v,
					output z );

assign z = (v[3]&v[2])|(v[1]&v[3]); // 真直表得出

endmodule

module sel (input a, b, s,
			output out );    //這邊變數改成A0 A1 會更好判讀
assign out = (a&s)|(b&(~s)); //s=0 >> b , s=1 >> a
endmodule

module fourbits_sel (	input [3:0] a, b,
						input s,
						output [3:0] out );
//generate 真香
sel sel0(	.a(a[0]),
			.b(b[0]),
			.s(s),
			.out(out[0]) );

sel sel1(	.a(a[1]),
			.b(b[1]),
			.s(s),
			.out(out[1]) );

sel sel2(	.a(a[2]),
			.b(b[2]),
			.s(s),
			.out(out[2]) );

sel sel3(	.a(a[3]),
			.b(b[3]),
			.s(s),
			.out(out[3]) );

endmodule

//七段顯示器
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

//element of fulladder
module efulladder (	input cin , a0 , a1 ,
					output cout , sum );
wire [2:0] temp0 ,temp1;
assign temp0 = {cin,a0,a1};
assign sum = ^temp0[2:0];
assign temp1 = {(a0&a1),(a1&cin),(a0&cin)};
assign cout = |temp1;

endmodule

//ripple adder
module fourbits_adder (	input [3:0] a,b,
						input Cin,
						output Cout,
						output [3:0] sum );

wire [3:0] cout;
// 用generate可以省下很多時間
efulladder fad0(.cin(Cin),
				.a0(a[0]),
				.a1(b[0]),
				.cout(cout[0]),
				.sum(sum[0]) );
efulladder fad1(.cin(cout[0]),
				.a0(a[1]),
				.a1(b[1]),
				.cout(cout[1]),
				.sum(sum[1]) );
efulladder fad2(.cin(cout[1]),
				.a0(a[2]),
				.a1(b[2]),
				.cout(cout[2]),
				.sum(sum[2]) );
efulladder fad3(.cin(cout[2]),
				.a0(a[3]),
				.a1(b[3]),
				.cout(cout[3]),
				.sum(sum[3]) );

assign Cout = cout[3];

endmodule

//END 



