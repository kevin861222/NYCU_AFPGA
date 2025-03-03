// 0811127  王語
// LAB 2

//top module
module Lab2_0811127 (   input [9:0] SW ,
                        input CLOCK_50 ,
                        output [6:0] HEX0 , HEX1 , HEX2 , HEX3 , HEX4 , HEX5 );

reg [3:0] sec_ten , sec_one , hr_ten , hr_one , min_one , min_ten ; //at t0 = 0000
reg SW8_temp0 , SW8_temp1 ;
integer count = 0;

ssd sec_onedigits ( .Din(sec_one),
                    .Dout(HEX0));
ssd sec_tendigits ( .Din(sec_ten),
                    .Dout(HEX1));
ssd min_onedigits ( .Din(min_one),
                    .Dout(HEX2));
ssd min_tendigits ( .Din(min_ten),
                    .Dout(HEX3));
ssd hr_onedigits (  .Din(hr_one),
                    .Dout(HEX4));
ssd hr_tendigits (  .Din(hr_ten),
                    .Dout(HEX5));

// The usage among of resource of ">" is greater than ">="
always @(posedge CLOCK_50) begin
    SW8_temp0 <= SW8_temp1 ;
    SW8_temp1 <= SW[8] ;

    if (SW[8]&&(SW8_temp0 != SW[8])) begin
        if (SW[9]) begin
            hr_one <= SW[3:0];
            hr_ten <= SW[7:4];
        end
        else begin
            min_one <= SW[3:0];
            min_ten <= SW[7:4];
        end
    end
    
    if (count == 50000000) begin
        count <= 0;

        sec_one <= sec_one + 4'b0001 ; 
        if (sec_one >= 4'd9 ) begin
            sec_one <= 4'b0000 ; 
            sec_ten <= sec_ten + 4'b0001;

            if (sec_ten >= 4'd5 ) begin
                sec_ten <= 4'b0000 ;
                min_one <= min_one + 4'b0001;

                if (min_one >= 4'd9 ) begin
                    min_one <= 4'b0000 ;
                    min_ten <= min_ten + 4'b0001;

                    if (min_ten >= 4'd5 ) begin
                        min_ten <= 4'b0000 ;
                        hr_one <= hr_one + 4'b0001;

                        if (hr_one >= 4'd9 ) begin
                            hr_one <= 4'b0000 ;
                            hr_ten <= hr_ten + 4'b0001 ;
                            
                        end

                        if ( (hr_one >= 4'd3) && (hr_ten >= 4'd1) ) begin
                                hr_one <= 4'b0000 ;
                                hr_ten <= 4'b0000 ;
                            end
                    end
                end
            end
        end
    end

    else begin
        count <= count+1;
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

// module bin2bcd( input [13:0] bin ,
//                 output reg [15:0] bcd );
   
// integer i;
	
// always @(bin) begin
//     bcd=0;		 	
//     for (i=0;i<14;i=i+1) begin					//Iterate once for each bit in input number
//     if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;		//If any BCD digit is >= 5, add three
// 	if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
// 	if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
// 	if (bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] + 3;
// 	bcd = {bcd[14:0],bin[13-i]};				//Shift one bit, and shift in proper bit from input 
//     end
// end
// endmodule