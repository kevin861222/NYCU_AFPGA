// ============================================================================
// Copyright (c) 2013 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use 
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//  
//  
//                     web: http://www.terasic.com/  
//                     email: support@terasic.com
//
// ============================================================================
//Date:  Thu Jul 11 11:26:45 2013
// ============================================================================

//`define ENABLE_HPS
//`define ENABLE_USB 

// 0811127 wang yu 

module DE1_SoC_CAMERA(

      ///////// ADC ///////// 
		
      inout              ADC_CS_N,
      output             ADC_DIN,
      input              ADC_DOUT,
      output             ADC_SCLK,

      ///////// AUD ///////// 
      input              AUD_ADCDAT,
      inout              AUD_ADCLRCK,
      inout              AUD_BCLK,
      output             AUD_DACDAT,
      inout              AUD_DACLRCK,
      output             AUD_XCK,

      ///////// CLOCK2 /////////
      input              CLOCK2_50,

      ///////// CLOCK3 /////////
      input              CLOCK3_50,

      ///////// CLOCK4 /////////
      input              CLOCK4_50,

      ///////// CLOCK /////////
      input              CLOCK_50,

      ///////// DRAM ///////// 
      output      [12:0] DRAM_ADDR,
      output      [1:0]  DRAM_BA,
      output             DRAM_CAS_N,
      output             DRAM_CKE,
      output             DRAM_CLK,
      output             DRAM_CS_N,
      inout       [15:0] DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_RAS_N,
      output             DRAM_UDQM,
      output             DRAM_WE_N,

      ///////// FAN /////////
      output             FAN_CTRL,

      ///////// FPGA /////////
      output             FPGA_I2C_SCLK,
      inout              FPGA_I2C_SDAT,

      ///////// GPIO /////////
      inout     [35:0]   GPIO_0,
	
      ///////// HEX0 /////////
      output      [6:0]  HEX0,

      ///////// HEX1 /////////
      output      [6:0]  HEX1,

      ///////// HEX2 /////////
      output      [6:0]  HEX2,

      ///////// HEX3 /////////
      output      [6:0]  HEX3,

      ///////// HEX4 /////////
      output      [6:0]  HEX4,

      ///////// HEX5 /////////
      output      [6:0]  HEX5,

`ifdef ENABLE_HPS
      ///////// HPS /////////
      input              HPS_CONV_USB_N,
      output      [14:0] HPS_DDR3_ADDR,
      output      [2:0]  HPS_DDR3_BA,
      output             HPS_DDR3_CAS_N,
      output             HPS_DDR3_CKE,
      output             HPS_DDR3_CK_N,
      output             HPS_DDR3_CK_P,
      output             HPS_DDR3_CS_N,
      output      [3:0]  HPS_DDR3_DM,
      inout       [31:0] HPS_DDR3_DQ,
      inout       [3:0]  HPS_DDR3_DQS_N,
      inout       [3:0]  HPS_DDR3_DQS_P,
      output             HPS_DDR3_ODT,
      output             HPS_DDR3_RAS_N,
      output             HPS_DDR3_RESET_N,
      input              HPS_DDR3_RZQ,
      output             HPS_DDR3_WE_N,
      output             HPS_ENET_GTX_CLK,
      inout              HPS_ENET_INT_N,
      output             HPS_ENET_MDC,
      inout              HPS_ENET_MDIO,
      input              HPS_ENET_RX_CLK,
      input       [3:0]  HPS_ENET_RX_DATA,
      input              HPS_ENET_RX_DV,
      output      [3:0]  HPS_ENET_TX_DATA,
      output             HPS_ENET_TX_EN,
      inout       [3:0]  HPS_FLASH_DATA,
      output             HPS_FLASH_DCLK,
      output             HPS_FLASH_NCSO,
      inout              HPS_GSENSOR_INT,
      inout              HPS_I2C1_SCLK,
      inout              HPS_I2C1_SDAT,
      inout              HPS_I2C2_SCLK,
      inout              HPS_I2C2_SDAT,
      inout              HPS_I2C_CONTROL,
      inout              HPS_KEY,
      inout              HPS_LED,
      inout              HPS_LTC_GPIO,
      output             HPS_SD_CLK,
      inout              HPS_SD_CMD,
      inout       [3:0]  HPS_SD_DATA,
      output             HPS_SPIM_CLK,
      input              HPS_SPIM_MISO,
      output             HPS_SPIM_MOSI,
      inout              HPS_SPIM_SS,
      input              HPS_UART_RX,
      output             HPS_UART_TX,
      input              HPS_USB_CLKOUT,
      inout       [7:0]  HPS_USB_DATA,
      input              HPS_USB_DIR,
      input              HPS_USB_NXT,
      output             HPS_USB_STP,
`endif /*ENABLE_HPS*/

      ///////// IRDA /////////
      input              IRDA_RXD,
      output             IRDA_TXD,

      ///////// KEY /////////
      input       [3:0]  KEY,

      ///////// LEDR /////////
      output      [9:0]  LEDR,

      ///////// PS2 /////////
      inout              PS2_CLK,
      inout              PS2_CLK2,
      inout              PS2_DAT,
      inout              PS2_DAT2,

      ///////// SW /////////
      input       [9:0]  SW,

      ///////// TD /////////
      input              TD_CLK27,
      input      [7:0]   TD_DATA,
      input              TD_HS,
      output             TD_RESET_N,
      input              TD_VS,

`ifdef ENABLE_USB
      ///////// USB /////////
      input              USB_B2_CLK,
      inout       [7:0]  USB_B2_DATA,
      output             USB_EMPTY,
      output             USB_FULL,
      input              USB_OE_N,
      input              USB_RD_N,
      input              USB_RESET_N,
      inout              USB_SCL,
      inout              USB_SDA,
      input              USB_WR_N,
`endif /*ENABLE_USB*/

      ///////// VGA /////////
      output reg     [7:0]  VGA_B, // blue
      output             VGA_BLANK_N,
      output             VGA_CLK,
      output reg     [7:0]  VGA_G, // green
      output             VGA_HS,
      output reg     [7:0]  VGA_R, // red
      output             VGA_SYNC_N,
      output             VGA_VS,
		
		//////////// GPIO1, GPIO1 connect to D5M - 5M Pixel Camera //////////
	   input		   [11:0] D5M_D,
      input		          D5M_FVAL,
      input		          D5M_LVAL,
      input		          D5M_PIXLCLK,
      output		       D5M_RESET_N,
      output		       D5M_SCLK,
      inout		          D5M_SDATA,
      input		          D5M_STROBE,
      output		       D5M_TRIGGER,
      output		       D5M_XCLKIN
);



//=======================================================
//  REG/WIRE declarations
//=======================================================
wire			 [15:0]			Read_DATA1;
wire	       [15:0]			Read_DATA2;

wire			 [11:0]			mCCD_DATA;
wire								mCCD_DVAL;
wire								mCCD_DVAL_d;
wire	       [15:0]			X_Cont;
wire	       [15:0]			Y_Cont;
wire	       [9:0]			X_ADDR;
wire	       [31:0]			Frame_Cont;
wire								DLY_RST_0;
wire								DLY_RST_1;
wire								DLY_RST_2;
wire								DLY_RST_3;
wire								DLY_RST_4;
wire								Read;
reg		    [11:0]			rCCD_DATA;
reg								rCCD_LVAL;
reg								rCCD_FVAL;
wire	       [11:0]			sCCD_R;
wire	       [11:0]			sCCD_G;
wire	       [11:0]			sCCD_B;
wire								sCCD_DVAL;

wire								sdram_ctrl_clk;
wire	       [9:0]			oVGA_R;   				//	VGA Red[9:0]
wire	       [9:0]			oVGA_G;	 				//	VGA Green[9:0]
wire	       [9:0]			oVGA_B;   				//	VGA Blue[9:0]
wire        [23:0]         RGBData;             // VGA R + G + B 
//power on start
wire             				auto_start;
//=======================================================
//  Structural coding
//=======================================================
// D5M
assign	D5M_TRIGGER	=	1'b1;  // tRIGGER
assign	D5M_RESET_N	=	DLY_RST_1;

assign   VGA_CTRL_CLK = VGA_CLK;

assign	LEDR		=	Y_Cont;

assign RGBData = {oVGA_R[9:2],oVGA_G[9:2],oVGA_B[9:2]} ; 

//fetch the high 8 bits
// assign  VGA_R = oVGA_R[9:2];
// assign  VGA_G = oVGA_G[9:2];                 
// assign  VGA_B = oVGA_B[9:2];

always @(*) begin
   casex (SW[3:2]) 
		2'b1X :begin
			VGA_R = oVGA_B[9:2];
			VGA_G = oVGA_R[9:2];
			VGA_B = oVGA_G[9:2];
		end		
		2'b01 : begin
			VGA_R = oVGA_G[9:2];
			VGA_G = oVGA_B[9:2];
			VGA_B = oVGA_R[9:2];
		end
		2'b00 : begin
			VGA_R = oVGA_R[9:2];
			VGA_G = oVGA_G[9:2];
			VGA_B = oVGA_B[9:2];
		end
		default begin
			VGA_R = oVGA_R[9:2];
			VGA_G = oVGA_G[9:2];
			VGA_B = oVGA_B[9:2];
		end
	endcase
end

//D5M read 
always@(posedge D5M_PIXLCLK)
begin
	rCCD_DATA	<=	D5M_D;
	rCCD_LVAL	<=	D5M_LVAL;
	rCCD_FVAL	<=	D5M_FVAL;
end

wire [3:0] frame_temp ; 
//auto start when power on
assign auto_start = ((KEY[0])&&(DLY_RST_3)&&(!DLY_RST_4))? 1'b1:1'b0;
//Reset module
Reset_Delay			u2	(	
							.iCLK(CLOCK_50),
							.iRST(KEY[0]),
							.oRST_0(DLY_RST_0),
							.oRST_1(DLY_RST_1),
							.oRST_2(DLY_RST_2),
							.oRST_3(DLY_RST_3),
							.oRST_4(DLY_RST_4)
						   );
//D5M image capture
CCD_Capture			u3	(	
							.oDATA(mCCD_DATA),
							.oDVAL(mCCD_DVAL),
							.oX_Cont(X_Cont),
							.oY_Cont(Y_Cont),
							.oFrame_Cont(Frame_Cont),
							.iDATA(rCCD_DATA),
							.iFVAL(rCCD_FVAL),
							.iLVAL(rCCD_LVAL),
							.iSTART(!KEY[3]|auto_start),
							.iEND(!KEY[2]),
							.iCLK(~D5M_PIXLCLK),
							.iRST(DLY_RST_2)
						   );
//D5M raw date convert to RGB data

RAW2RGB				u4	(	
							.iCLK(D5M_PIXLCLK),
							.iRST(DLY_RST_1),
							.iDATA(mCCD_DATA),
							.iDVAL(mCCD_DVAL),
							.oRed(sCCD_R),
							.oGreen(sCCD_G),
							.oBlue(sCCD_B),
							.oDVAL(sCCD_DVAL),
							.iX_Cont(X_Cont),
							.iY_Cont(Y_Cont)
						   );

//Frame count display
SEG7_LUT_6 			u5	(	
							.oSEG0(frame_temp), // HEX0
                     .oSEG1(HEX1),
							.oSEG2(HEX2),.oSEG3(HEX3),
							.oSEG4(HEX4),.oSEG5(HEX5),
							.iDIG(Frame_Cont[23:0])
						   );
												
sdram_pll 			u6	(
							.refclk(CLOCK_50),
							.rst(1'b0),
							.outclk_0(sdram_ctrl_clk), // 100.000000 MHz
							.outclk_1(DRAM_CLK),       // 100.000000 MHz phase shift -90 degree
							.outclk_2(D5M_XCLKIN),    //  25.000000 MHz
					      .outclk_3(VGA_CLK)       //   25.000000 MHz
                     // VGA_CLK = D5M_XCLKIN
						   );


// assign   Read_DATA1 = {1'b0,sCCD_G[11:7],sCCD_B[11:2]} ;
// assign   Read_DATA2 = {1'b0,sCCD_G[6:2],sCCD_R[11:2]} ;
reg [49:0] write_counter , read_counter ; // 19 bit  0 ~ 100_1011_0000_0000_0000 
reg [2:0] write_state_of_memory , read_state_of_memory ;
reg [22:0] RD1_ADDR , RD1_MAX_ADDR , RD2_ADDR , RD2_MAX_ADDR , WR1_ADDR , WR1_MAX_ADDR , WR2_ADDR , WR2_MAX_ADDR ;
// reg write_load ;
// initial 
initial begin
   read_counter = 50'd0 ; 
   write_counter = 50'd0 ; 
   write_state_of_memory = 3'b001 ; 
   read_state_of_memory = 3'b001 ; 
end

// write 
always @(posedge ~D5M_PIXLCLK or negedge (KEY[0]) ) begin //25M VGA_CTRL_CLK //~D5M_PIXLCLK
// if 
   if (!KEY[0]) begin //reset 
      write_counter <= 50'd0 ;
      write_state_of_memory <= 3'b001 ;
   end
   else begin      
      if (sCCD_DVAL) begin                            // 18432000 // 50'd10000 very good  // 50'd100000 very bad
         if (write_counter == 50'd307200) begin //  wrong : 307201 , 640*480=307200 , 25000000 ,6144000  50'd100000000 not bad 
         // write_state_of_memory <= 2'b10 ; 614,402
            write_counter <= 50'd0 ;
            case (write_state_of_memory)
               3'b001: begin
                  write_state_of_memory <= 3'b010 ; 
               end
               3'b010: begin
                  write_state_of_memory <= 3'b100 ;
               end
               3'b100: begin
                  write_state_of_memory <= 3'b001 ;
               end
               default: begin
                  write_state_of_memory <= 3'b001 ;
               end
            endcase
         end
         // end
         else begin
            write_counter <= write_counter + 1'b1 ;
         end
      end
      else begin
      end
   end
end

// read 
always @(posedge ~VGA_CTRL_CLK or negedge (KEY[0])) begin //25M VGA_CTRL_CLK //~D5M_PIXLCLK
// if 
   if (!KEY[0]) begin //reset 
      read_counter <= 50'd0 ;
      read_state_of_memory <= 3'b001 ;
   end
   else begin    
      if (Read) begin                              // 18432000 // 50'd10000 very good  // 50'd100000 very bad
         if (read_counter == 50'd307200) begin //  wrong : 307201 , 307200 , 25000000 ,6144000  50'd100000000 not bad 
         // write_state_of_memory <= 2'b10 ; 614,402
            read_counter <= 50'd0 ;
            case (read_state_of_memory)
               3'b001: begin
                  read_state_of_memory <= 3'b010 ; 
               end
               3'b010: begin
                  read_state_of_memory <= 3'b100 ;
               end
               3'b100: begin
                  read_state_of_memory <= 3'b001 ;
               end
               default: begin
                  read_state_of_memory <= 3'b001 ;
               end
            endcase
         end
         // end
         else begin
            read_counter <= read_counter + 1'b1 ;
         end
      end
      else begin

      end
   end
end


// write 
always @(*) begin // 4 frame 
      // read_state_of_memory = 2'b10 ;
      // write_state_of_memory = 2'b00 ;
      case (write_state_of_memory)
         3'b001 : begin // good 
            WR1_ADDR = 0 ;
            WR1_MAX_ADDR = 640*480 ; // 23'd307200 = 4B000
            WR2_ADDR =  640*480+10 ; // WR1_ADDR + 23'h100000
            WR2_MAX_ADDR = 640*480+10+640*480 ;// blocking
         end
         3'b010 : begin // bad 
            // WR1_ADDR = 23'h100000 ; // bad 
            // WR1_ADDR = (640*480)*2+2 ; //  2^23 = 8,388,608 
            // WR1_ADDR = 23'h200000 ; // bad 
            WR1_ADDR = 0 ;
            WR1_MAX_ADDR = 640*480 ; // 23'd307200 = 4B000
            WR2_ADDR =  640*480+10 ; // WR1_ADDR + 23'h100000
            WR2_MAX_ADDR = 640*480+10+640*480 ;// blocking
            // WR1_ADDR = 640*480+20+640*480 ;
            // WR1_MAX_ADDR = 640*480+640*480+20+640*480  ; // 23'd307200 = 4B000
            // WR2_ADDR =  640*480+640*480+20+640*480+10 ; // WR1_ADDR + 23'h100000
            // WR2_MAX_ADDR = 640*480+640*480+20+640*480+10+640*480 ;// blocking
         end
         3'b100 : begin 
            // WR1_ADDR = (640*480)*4+4 ;
            WR1_ADDR = 0 ;
            WR1_MAX_ADDR = 640*480 ; // 23'd307200 = 4B000
            WR2_ADDR =  640*480+10 ; // WR1_ADDR + 23'h100000
            WR2_MAX_ADDR = 640*480+10+640*480 ;// blocking
            // WR1_ADDR = 23'h200000 ;
            // WR1_MAX_ADDR = 23'h200000+640*480  ; // 23'd307200 = 4B000
            // WR2_ADDR =  23'h200000+23'h100000 ; // WR1_ADDR + 23'h100000
            // WR2_MAX_ADDR = 23'h200000+640*480+23'h100000 ;// blocking
         end
         default: begin
            WR1_ADDR = 0 ;
            WR1_MAX_ADDR = 640*480 ; // 23'd307200 = 4B000
            WR2_ADDR =  640*480+10 ; // WR1_ADDR + 23'h100000
            WR2_MAX_ADDR = 640*480+10+640*480 ;// blocking
         end
      endcase
end

//READ
always @(*) begin
   // read_state_of_memory = 2'b01 ; 
   case (read_state_of_memory)//write_state_of_memory) // read_state_of_memory {SW[5:3]}
      3'b001 : begin
         RD1_ADDR = 23'h200000 ;
         RD1_MAX_ADDR = 23'h200000+640*480  ; // + 23'd307200 = 640*480 
         RD2_ADDR = 23'h200000+23'h100000 ; // RDADDR + 23'h100000
         RD2_MAX_ADDR = 23'h200000+640*480+23'h100000 ;// blocking
         // RD1_ADDR = 0 ;
         // RD1_MAX_ADDR = 640*480  ; // + 23'd307200 = 640*480 
         // RD2_ADDR = 640*480+10 ; // RD1_ADDR + 23'h100000
         // RD2_MAX_ADDR = 640*480+10+640*480 ;// blocking
         // RD1_ADDR = 640*480+20+640*480 ;
         // RD1_MAX_ADDR = 640*480+640*480+20+640*480  ; // + 23'd307200 = 640*480 
         // RD2_ADDR = 640*480+640*480+20+640*480+10 ; // RD1_ADDR + 23'h100000
         // RD2_MAX_ADDR = 640*480+640*480+20+640*480+10+640*480 ;// blocking
      end
      3'b010 : begin
         // RD1_ADDR = 23'h200000 ;
         // RD1_MAX_ADDR = 23'h200000+640*480  ; // + 23'd307200 = 640*480 
         // RD2_ADDR = 23'h200000+23'h100000 ; // RD1_ADDR + 23'h100000
         // RD2_MAX_ADDR = 23'h200000+640*480+23'h100000 ;
         RD1_ADDR = 0 ;
         RD1_MAX_ADDR = 640*480  ; // + 23'd307200 = 640*480 
         RD2_ADDR = 640*480+10 ; // RD1_ADDR + 23'h100000
         RD2_MAX_ADDR = 640*480+10+640*480 ;// blocking
      end
      3'b100 : begin
         RD1_ADDR = 640*480+20+640*480 ;
         RD1_MAX_ADDR = 640*480+640*480+20+640*480  ; // + 23'd307200 = 640*480 
         RD2_ADDR = 640*480+640*480+20+640*480+10 ; // RD1_ADDR + 23'h100000
         RD2_MAX_ADDR = 640*480+640*480+20+640*480+10+640*480 ;// blocking
         // RD1_ADDR = 0 ;
         // RD1_MAX_ADDR = 640*480  ; // + 23'd307200 = 640*480 
         // RD2_ADDR = 640*480+10 ; // RD1_ADDR + 23'h100000
         // RD2_MAX_ADDR = 640*480+10+640*480 ;// blocking
      end
      default: begin
         RD1_ADDR = 23'h200000 ;
         RD1_MAX_ADDR = 23'h200000+640*480  ; // + 23'd307200 = 640*480 
         RD2_ADDR = 23'h200000+23'h100000 ; // RD1_ADDR + 23'h100000
         RD2_MAX_ADDR = 23'h200000+640*480+23'h100000 ;// blocking
         // RD1_ADDR = 0 ;
         // RD1_MAX_ADDR = 640*480  ; // + 23'd307200 = 640*480 
         // RD2_ADDR = 640*480+10 ; // RD1_ADDR + 23'h100000
         // RD2_MAX_ADDR = 640*480+10+640*480 ;// blocking
      end
   endcase
end

Sdram_Control	   u7	(	//	HOST Side						
						   .RESET_N(KEY[0]),
							.CLK(sdram_ctrl_clk), // 100M

							//	FIFO Write Side 1 
							.WR1_DATA({1'b0,sCCD_G[11:7],sCCD_B[11:2]}), //{1'b0,sCCD_G[11:7],sCCD_B[11:2]}
							.WR1(sCCD_DVAL) ,
							.WR1_ADDR(SW[8]? (WR1_ADDR):(0)  ) , // 0 
                     .WR1_MAX_ADDR(SW[8]? (WR1_MAX_ADDR):(640*480)  ) , // 640*480
						   .WR1_LENGTH(8'h50) ,
		               .WR1_LOAD((!DLY_RST_0)) ,
							.WR1_CLK(~D5M_PIXLCLK) ,

							//	FIFO Write Side 2
							.WR2_DATA({1'b0,sCCD_G[6:2],sCCD_R[11:2]}), // 1 + 5 + 10  // {1'b0,sCCD_G[6:2],sCCD_R[11:2]}
							.WR2(sCCD_DVAL) ,
							.WR2_ADDR(SW[8]? (WR2_ADDR):(23'h100000)  ), // 23'h100000  // 23'd307201
							.WR2_MAX_ADDR(SW[8]? (WR2_MAX_ADDR):(23'h100000+640*480)  ) , // 23'd307201+(640*480)
							.WR2_LENGTH(8'h50) ,
							.WR2_LOAD((!DLY_RST_0)) ,	
							.WR2_CLK(~D5M_PIXLCLK) ,

                     //	FIFO Read Side 1
						   .RD1_DATA(Read_DATA1), // Read_DATA1 = {1'b0,sCCD_G[11:7],sCCD_B[11:2]}
				        	.RD1(Read),
				        	.RD1_ADDR(SW[8]? (RD1_ADDR):(0) ), // 0 
                     .RD1_MAX_ADDR(SW[8]? (RD1_MAX_ADDR):(640*480) ), // *307,200*  //640*480
							.RD1_LENGTH(8'h50),
							.RD1_LOAD(!DLY_RST_0),
							.RD1_CLK(~VGA_CTRL_CLK),
							
							//	FIFO Read Side 2
						   .RD2_DATA(Read_DATA2) ,
							.RD2(Read) ,
							.RD2_ADDR(SW[8]? (RD2_ADDR):(23'h100000) ) , // 23'h100000 //23'd307201
                     .RD2_MAX_ADDR(SW[8]? (RD2_MAX_ADDR):(23'h100000+640*480) ) , //23'h100000 = 23'b00100000000000000000000 = 1,048,576  //23'd307201+(640*480)
							.RD2_LENGTH(8'h50) ,
                   	.RD2_LOAD(!DLY_RST_0) ,
							.RD2_CLK(~VGA_CTRL_CLK) ,
										
							//	SDRAM Side
						   .SA(DRAM_ADDR),
							.BA(DRAM_BA),
							.CS_N(DRAM_CS_N),
							.CKE(DRAM_CKE),
							.RAS_N(DRAM_RAS_N),
							.CAS_N(DRAM_CAS_N),
							.WE_N(DRAM_WE_N),
							.DQ(DRAM_DQ),
							.DQM({DRAM_UDQM,DRAM_LDQM})
						   );
							
				
//D5M I2C control
I2C_CCD_Config 	u8	(	//	Host Side
							.iCLK(CLOCK2_50),
							.iRST_N(DLY_RST_2),
							.iEXPOSURE_ADJ(KEY[1]),
							.iEXPOSURE_DEC_p(SW[0]),
							.iZOOM_MODE_SW(SW[9]),
							//	I2C Side
							.I2C_SCLK(D5M_SCLK),
							.I2C_SDAT(D5M_SDATA)
						   );
//VGA DISPLAY
VGA_Controller	  u1	(	//	Host Side
							.oRequest(Read),
							.iRed(Read_DATA2[9:0]),//10 
					      .iGreen({Read_DATA1[14:10],Read_DATA2[14:10]}), //5 + 5 
						   .iBlue(Read_DATA1[9:0]), // 10 
						
							//	VGA Side
							.oVGA_R(oVGA_R),
							.oVGA_G(oVGA_G),
							.oVGA_B(oVGA_B),
							.oVGA_H_SYNC(VGA_HS),
							.oVGA_V_SYNC(VGA_VS),
							.oVGA_SYNC(VGA_SYNC_N),
							.oVGA_BLANK(VGA_BLANK_N),
							//	Control Signal
							.iCLK(VGA_CTRL_CLK),
							.iRST_N(DLY_RST_2),
							.iZOOM_MODE_SW(SW[9]) 
						   );

wire [3:0] _HEX0 ;
assign _HEX0 = write_state_of_memory ; 
ssd ssd1( .Din(_HEX0) , .Dout(HEX0) );

							
endmodule

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



