module lab01(SW,LEDR,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0);
  input [8:0]SW;
  output [9:9]LEDR;
  output [6:0]HEX5,HEX4,HEX3,HEX2,HEX1,HEX0;
  wire [2:0]Z;
  wire [4:0]W;
  btd({1'b0,SW[3:0]},HEX1,HEX0,Z[0]);
  btd({1'b0,SW[7:4]},HEX3,HEX2,Z[1]);
  errorcheck(LEDR,Z);
  fa(SW,W[4:0]);
  btd(W[4:0],HEX5,HEX4,Z[2]);
endmodule

//submodule
module btd(SW,HEX1,HEX0,Z);
  input [4:0]SW;
  output Z;
  output [6:0]HEX1,HEX0;
  wire [3:0]CA;
  wire [3:0]OUT;
  comparator(SW[4],SW[3],SW[2],SW[1],SW[0],Z);
  circuit_a(SW[3:0],CA[3:0]);
  multiplexer(Z,SW[3:0],CA,OUT);
  circuit_b(Z,HEX1);
  display(OUT,HEX0);
endmodule
// 0001 

//若輸入為10~19，M值必為1，使得Z也必為1，而Z為判別LEDR之參數
module comparator(E,A,B,C,D,Z);
  input E,A,B,C,D;
  output Z;
  wire M1,M2,M3,M4,M5,M6,M7,M8,M9,M10;
  assign Z=M1|M2|M3|M4|M5|M6|M7|M8|M9|M10;
  assign M1=~E&A&~B&C&~D; //10
  assign M2=~E&A&~B&C&D; //11
  assign M3=~E&A&B&~C&~D; //12
  assign M4=~E&A&B&~C&D; //13
  assign M5=~E&A&B&C&~D; //14
  assign M6=~E&A&B&C&D; //15
  assign M7=E&~A&~B&~C&~D; //16
  assign M8=E&~A&~B&~C&D; //17
  assign M9=E&~A&~B&C&~D; //18
  assign M10=E&~A&~B&C&D; //19
endmodule

//利用KMAP化簡把舊SW值轉成新CA之值 (10->0,11->1,...,19->9)
module circuit_a(SW,CA);
  input [3:0]SW;
  output [3:0]CA;
  assign CA[3]=~SW[3]&~SW[2]&SW[1];
  assign CA[2]=(~SW[3]&~SW[2]&~SW[1])|(SW[3]&SW[2]&SW[1]);
  assign CA[1]=(~SW[3]&~SW[2]&~SW[1])|(SW[3]&SW[2]&~SW[1]);
  assign CA[0]=(~SW[3]&~SW[2]&SW[0])|(SW[3]&SW[2]&SW[0])|(SW[3]&SW[1]&SW[0]);
endmodule

//判別Z輸入為1還是0 (1->HEX1=1;0->HEX1=0)
module circuit_b(Z,HEX);
  input Z;
  output [6:0]HEX;
  assign HEX[6:0]=({7{~Z}}&7'b1111111)|({7{Z}}&7'b1111001);
endmodule

//若Z=1，OUT2儲存circuit_a所存之OUT(>=10)；若Z=0，OUT2儲存switch控制之值(<10)
module multiplexer(Z,SW,OUT1,OUT2);
  input Z;
  input [3:0]SW,OUT1;
  output [3:0]OUT2;
  assign OUT2[3]=(~Z&SW[3])|(Z&OUT1[3]);
  assign OUT2[2]=(~Z&SW[2])|(Z&OUT1[2]);
  assign OUT2[1]=(~Z&SW[1])|(Z&OUT1[1]);
  assign OUT2[0]=(~Z&SW[0])|(Z&OUT1[0]);
endmodule

//利用十對一多工器將二進位轉十進位並顯示於七段
module display(SW,HEX);
  input [3:0]SW;
  output [6:0]HEX;
  wire [6:0]M1,M2,M3,M4,M5,M6,M7,M8;
  assign M1=({7{~SW[0]}}&7'b1000000)|({7{SW[0]}}&7'b1111001);
  assign M2=({7{~SW[0]}}&7'b0100100)|({7{SW[0]}}&7'b0110000);
  assign M3=({7{~SW[0]}}&7'b0011001)|({7{SW[0]}}&7'b0010010);
  assign M4=({7{~SW[0]}}&7'b0000010)|({7{SW[0]}}&7'b1111000);
  assign M5=({7{~SW[0]}}&7'b0000000)|({7{SW[0]}}&7'b0010000);
  assign M6=({7{~SW[1]}}&M1)|({7{SW[1]}}&M2);
  assign M7=({7{~SW[1]}}&M3)|({7{SW[1]}}&M4);
  assign M8=({7{~SW[2]}}&M6)|({7{SW[2]}}&M7);
  assign HEX[6:0]=({7{~SW[3]}}&M8)|({7{SW[3]}}&M5);
endmodule

//輸入之Z[1]、Z[0]判別LEDR9亮與不亮
module errorcheck(LEDR,Z);
  input [1:0]Z;
  output [9:9]LEDR;
  assign LEDR[9]=Z[1]|Z[0];
endmodule

//Ripple carry adder
module fa(SW,LEDR);
  input [8:0]SW;
  output [4:0]LEDR;
  wire A,B,C;
  fulladder(SW[0],SW[4],SW[8],LEDR[0],A);
  fulladder(SW[1],SW[5],A,LEDR[1],B);
  fulladder(SW[2],SW[6],B,LEDR[2],C);
  fulladder(SW[3],SW[7],C,LEDR[3],LEDR[4]);
endmodule

//單個Full_adder
module fulladder(A,B,C1,S,C2);
  input A,B,C1;
  output S,C2;
  wire W1;
  xor xor1(W1,A,B);
  xor xor2(S,W1,C1);
  assign C2=(~W1&B)|(W1&C1);
endmodule