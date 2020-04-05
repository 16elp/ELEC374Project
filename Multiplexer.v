
`timescale 1ns/10ps

module Multiplexer(input wire [31:0] BusMuxInR0, input wire [31:0] BusMuxInR1, input wire [31:0] BusMuxInR2, input wire [31:0] BusMuxInR3, input wire [31:0] BusMuxInR4, input wire [31:0] BusMuxInR5, input wire [31:0] BusMuxInR6, input wire [31:0] BusMuxInR7, input wire [31:0] BusMuxInR8, input wire [31:0] BusMuxInR9, input wire [31:0] BusMuxInR10, input wire [31:0] BusMuxInR11, input wire [31:0] BusMuxInR12, input wire [31:0] BusMuxInR13, input wire [31:0] BusMuxInR14, input wire [31:0] BusMuxInR15, input wire [31:0] BusMuxInHI, input wire [31:0] BusMuxInLO, input wire [31:0] BusMuxInZhigh, input wire [31:0] BusMuxInZlow, input wire [31:0] BusMuxInPC, input wire [31:0] BusMuxInMDR, input wire [31:0] BusMuxInInPort, input wire [31:0] C_sign_extended, output reg [31:0] BusMuxOut, input wire [4:0] select_signal);	
	always@(*) begin
		case(select_signal)
         		5'd0 : BusMuxOut <= BusMuxInR0[31:0];
         		5'd1 : BusMuxOut <= BusMuxInR1[31:0];
         		5'd2 : BusMuxOut <= BusMuxInR2[31:0];
         		5'd3 : BusMuxOut <= BusMuxInR3[31:0];
			5'd4 : BusMuxOut <= BusMuxInR4[31:0];
		 	5'd5 : BusMuxOut <= BusMuxInR5[31:0];
         		5'd6 : BusMuxOut <= BusMuxInR6[31:0];
         		5'd7 : BusMuxOut <= BusMuxInR7[31:0];
			5'd8 : BusMuxOut <= BusMuxInR8[31:0];
         		5'd9 : BusMuxOut <= BusMuxInR9[31:0];
         		5'd10: BusMuxOut <= BusMuxInR10[31:0];
         		5'd11: BusMuxOut <= BusMuxInR11[31:0];
			5'd12: BusMuxOut <= BusMuxInR12[31:0];
         		5'd13: BusMuxOut <= BusMuxInR13[31:0];
         		5'd14: BusMuxOut <= BusMuxInR14[31:0];
         		5'd15: BusMuxOut <= BusMuxInR15[31:0];
			5'd16: BusMuxOut <= BusMuxInHI[31:0];
         		5'd17: BusMuxOut <= BusMuxInLO[31:0];
         		5'd18: BusMuxOut <= BusMuxInZhigh[31:0];
         		5'd19: BusMuxOut <= BusMuxInZlow[31:0];
			5'd20: BusMuxOut <= BusMuxInPC[31:0];
         		5'd21: BusMuxOut <= BusMuxInMDR[31:0];
         		5'd22: BusMuxOut <= BusMuxInInPort[31:0];
         		5'd23: BusMuxOut <= C_sign_extended[31:0];
			default: BusMuxOut <= 32'd0;
      endcase
   end
endmodule

