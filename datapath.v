`timescale 1ns/10ps

module datapath(input clk, input clr, input RAM_read, input wire [2:0] MDR_read, input wire [31:0] Mdatain, 
		input RAM_write, input IncPC, input R_enable, input Rout, input wire [15:0] R_enableIn, 
		input wire [15:0] Rout_in, input Gra, input Grb, input Grc, input enableMDR, input enableMAR,	
   		input enableHI, input enableLO, input enableZ, input enableY, input enablePC, input enableInPort, 
		input enableOutPort, input enableIR, input enableCON, input MDRout, input InPortout, input OutPortout,
		input PCout, input Yout, input ZLowout, input ZHighout, input LOout, input HIout, input Cout, 
		input BAout, input wire[31:0] InPort_input, output wire[31:0] OutPort_output, output wire [31:0] BusMuxOut,
		output wire [4:0] opcode); 

wire [15:0] enableR_IR; 
wire [15:0] Rout_IR;
reg [15:0]  enableR; 
reg [15:0]  Rout;
wire [3:0]  decoder_in;
wire [31:0] BusMuxInR0_to_AND;
wire [31:0] BusMuxInR0;
wire [31:0] BusMuxInR1;
wire [31:0] BusMuxInR2;
wire [31:0] BusMuxInR3;
wire [31:0] BusMuxInR4;
wire [31:0] BusMuxInR5;
wire [31:0] BusMuxInR6;
wire [31:0] BusMuxInR7;
wire [31:0] BusMuxInR8;
wire [31:0] BusMuxInR9;
wire [31:0] BusMuxInR10;	
wire [31:0] BusMuxInR11;
wire [31:0] BusMuxInR12;x
wire [31:0] BusMuxInR13;
wire [31:0] BusMuxInR14;
wire [31:0] BusMuxInR15;
wire [31:0] HI_data_out;
wire [31:0] LO_data_out;
wire [31:0] Y_data_out;
wire [31:0] ZHigh_data_out;
wire [31:0] ZLow_data_out;
wire [31:0] PC_data_out;
wire [31:0] InPort_data_out;
wire [63:0] C_data_out;
wire [31:0] C_sign_extended;   
wire [31:0] IR_data_out;
wire [31:0] MDR_mux_data_out;
wire [31:0] MDR_data_out;
wire [31:0] MAR_data_out;
wire [4:0]  bus_encoder_signal;
wire [31:0] RAM_data_out;
wire CON_out;
	
always@(*)begin		
	if (enableR_IR)enableR<=enableR_IR; 
	else enableR<=R_enableIn;
	if (Rout_IR)Rout<=Rout_IR; 
	else Rout<=Rout_in;
end 
	
Registers R0(clk, clr, enableR[0], BusMuxOut, BusMuxInR0_to_AND);
assign BusMuxInR0 = {32{!BAout}} & BusMuxInR0_to_AND;
Registers R1(clk, clr, enableR[1], BusMuxOut, BusMuxInR1);
Registers R2(clk, clr, enableR[2], BusMuxOut, BusMuxInR2);
Registers R3(clk, clr, enableR[3], BusMuxOut, BusMuxInR3);
Registers R4(clk, clr, enableR[4], BusMuxOut, BusMuxInR4);
Registers R5(clk, clr, enableR[5], BusMuxOut, BusMuxInR5);
Registers R6(clk, clr, enableR[6], BusMuxOut, BusMuxInR6);
Registers R7(clk, clr, enableR[7], BusMuxOut, BusMuxInR7);
Registers R8(clk, clr, enableR[8], BusMuxOut, BusMuxInR8);
Registers R9(clk, clr, enableR[9], BusMuxOut, BusMuxInR9);
Registers R10(clk, clr, enableR[10], BusMuxOut, BusMuxInR10);
Registers R11(clk, clr, enableR[11], BusMuxOut, BusMuxInR11);
Registers R12(clk, clr, enableR[12], BusMuxOut, BusMuxInR12);
Registers R13(clk, clr, enableR[13], BusMuxOut, BusMuxInR13);
Registers R14(clk, clr, enableR[14], BusMuxOut, BusMuxInR14);
Registers R15(clk, clr, enableR[15], BusMuxOut, BusMuxInR15);
Registers ZHigh(clk, clr, enableZ, C_data_out[63:32], ZHigh_data_out);
Registers ZLow(clk, clr, enableZ, C_data_out[31:0], ZLow_data_out);
Registers Yreg(clk, clr, enableY, BusMuxOut, Y_data_out);
Registers HIreg(clk, clr, enableHI, BusMuxOut, HI_data_out);
Registers LOreg(clk, clr, enableLO, BusMuxOut, LO_data_out);

Registers In_port(clk,clr,enableInPort,InPort_input, InPort_data_out);
Registers Out_port(clk,clr,enableOutPort,BusMuxOut, OutPort_output);

Registers IR_reg(clk, clr, enableIR, BusMuxOut, IR_data_out);
IR_logic IR_log(IR_data_out,Gra,Grb,Grc,R_enable,Rout,BAout,opcode,C_sign_extended,enableR_IR,Rout_IR,decoder_in);
	
CONFF CON_FF(IR_data_out[20:19], BusMuxOut, enableCON, CON_out);

Registers PC_reg(clk, clr, enablePC, BusMuxOut, PC_data_out);
	
RAM ram(MDR_data_out,MAR_data_out,RAM_write,clk,RAM_data_out);
	
multiplexer3to1 MDR_mux(BusMuxOut,RAM_data_out,Mdatain,MDR_read, MDR_mux_data_out);
Registers MDR(clk, clr, enableMDR, MDR_mux_data_out, MDR_data_out);
Registers MAR(clk, clr, enableMAR, BusMuxOut, MAR_data_out);

Encoder busEncoder({{8{1'b0}},Cout,InPortout,MDRout,PCout,ZLowout,ZHighout,LOout,HIout,Rout}, bus_encoder_signal);
	
Multiplexer Mux(.BusMuxInR0(BusMuxInR0), .BusMuxInR1(BusMuxInR1), .BusMuxInR2(BusMuxInR2), .BusMuxInR3(BusMuxInR3), 
		.BusMuxInR4(BusMuxInR4), .BusMuxInR5(BusMuxInR5), .BusMuxInR6(BusMuxInR6), .BusMuxInR7(BusMuxInR7), 
		.BusMuxInR8(BusMuxInR8), .BusMuxInR9(BusMuxInR9), .BusMuxInR10(BusMuxInR10), .BusMuxInR11(BusMuxInR11), 
		.BusMuxInR12(BusMuxInR12), .BusMuxInR13(BusMuxInR13), .BusMuxInR14(BusMuxInR14), .BusMuxInR15(BusMuxInR15), 
		.BusMuxInHI(HI_data_out),.BusMuxInLO(LO_data_out), .BusMuxInZhigh(ZHigh_data_out),.BusMuxInZlow(ZLow_data_out), 
		.BusMuxInPC(PC_data_out), .BusMuxInMDR(MDR_data_out), .BusMuxInInPort(InPort_data_out), 
		.C_sign_extended(C_sign_extended), .select_signal(bus_encoder_signal), .BusMuxOut(BusMuxOut));
	
ALU alu(.clk(clk), .clear(clr), .A(BusMuxOut), .B(BusMuxOut), .Y(Y_data_out),  
	.opcode(opcode), .C(C_data_out), .branch_flag(CON_out), .IncPC(IncPC));	
endmodule
