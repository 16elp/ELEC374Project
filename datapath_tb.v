`timescale 1ns/10ps

module datapath_tb;
reg clk, clr;
reg IncPC, enableCON; 
reg [31:0] Mdatain;
wire [31:0] BusMuxOut;
reg RAM_write, enableMDR, MDRout, enableMAR, enableIR;
reg [2:0] MDR_read;
reg R_enable, Rout;
reg [15:0] enableR, Rout;
reg Gra, Grb, Grc;
reg enableHI, enableLO, enableZ, enableY, enablePC, enableInPort, enableOutPort;
reg InPortout, PCout, Yout, ZLowout, ZHighout, LOout, HIout, BAout, Cout;
wire [4:0] opcode;
wire[31:0] OutPort_output;
reg [31:0] InPort_input;	

parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
reg [3:0] Present_state = Default;

Datapath DUT(	.clk(clk),								
		.clr(clr),                       
	        .Mdatain(Mdatain), 
		.MDR_read(MDR_read),
		.RAM_write(RAM_write),
		.IncPC(IncPC),
		.R_enable(R_enable),					
		.Rout(Rout),		
		.R_enableIn(enableR), 
		.Rout_in(Rout),
		.enableMDR(enableMDR),         
		.MDRout(MDRout),                 
		.enableMAR(enableMAR),         
		.Gra(Gra),								
		.Grb(Grb),                       
		.Grc(Grc),                       
		.enableHI(enableHI),        	
		.enableLO(enableLO),        	
 		.enableZ(enableZ),          	
		.enableY(enableY),          	
  		.enablePC(enablePC),        	
   		.enableInPort(enableInPort),
		.enableOutPort(enableOutPort),
		.enableIR(enableIR),				
		.enableCON(enableCON),		
		.InPortout(InPortout),
		.PCout(PCout),                	
		.Yout(Yout),                  	
		.ZLowout(ZLowout),            	
		.ZHighout(ZHighout),          	
		.LOout(LOout),                	
		.HIout(HIout), 
		.Cout(Cout),
		.BAout(BAout),
		.InPort_input(InPort_input),
		.OutPort_output(OutPort_output),
		.opcode(opcode),
		.BusMuxOut(BusMuxOut));


initial begin
	clk = 0;
end

always
	#10 clk <= ~clk;

always @(posedge clk) 
	begin
		case (Present_state)
			Default : Present_state = Reg_load1a;
			Reg_load1a : Present_state = Reg_load1b;
			Reg_load1b : Present_state = Reg_load2a;
			Reg_load2a : Present_state = Reg_load2b;
			Reg_load2b : Present_state = Reg_load3a;
			Reg_load3a : Present_state = Reg_load3b;
			Reg_load3b : Present_state = T0;
			T0 : Present_state = T1;
			T1 : Present_state = T2;
			T2 : Present_state = T3;
			T3 : Present_state = T4;
			T4 : Present_state = T5;
			T5 : Present_state = T6;
			T6 : Present_state = T7;
		endcase
	end

always @(Present_state) 
	begin
		case (Present_state) 
			Default: begin
				PCout <= 0; ZLowout <= 0; MDRout <= 0; 
				enableMAR <= 0; enableZ <= 0; enableCON<=0; 
				enableInPort<=0; enableOutPort<=0; InPort_input<=32'd0;
				enablePC <=0; enableMDR <= 0; enableIR <= 0; enableY <= 0;
				IncPC <= 0; RAM_write<=0;
				Mdatain <= 32'h00000000; Gra<=0; Grb<=0; Grc<=0; BAout<=0; Cout<=0;
				InPortout<=0; ZHighout<=0; LOout<=0; HIout<=0; 
				enableHI<=0; enableLO<=0;
				Rout<=0;R_enable<=0;MDR_read<=2'b00;
				enableR<= 16'd0; Rout<=16'd0;
			end

						
//Instruction: 91100023 // brpl R2, 35
			
			Reg_load1a: begin
				Mdatain <= 32'h00000000;     
				enableMDR <= 1; MDR_read<=3'd2;
				#15 enableMDR <= 0;MDR_read<=3'd0;
			end
			Reg_load1b: begin    
				MDRout <= 1; enableR<=16'h0001;
				#15 MDRout <= 0; enableR<= 16'd0;
			end
			Reg_load2a: begin
			   	Mdatain <= 32'hFFFFFFFB;
			  	enableMDR <= 1;MDR_read<=3'd2;
				#15 enableMDR <= 0;MDR_read<=3'd0;
			end
			Reg_load2b: begin
				MDRout <= 1; enableR<=16'h0004;   
				#15 MDRout <= 0; enableR<= 16'd0;
			end
			Reg_load3a: begin
				Mdatain <= 32'h00000000;   
			   enableMDR <= 1;MDR_read<=3'd2;
				#15 enableMDR <= 0;MDR_read<=3'd0;
			end
			Reg_load3b: begin
				MDRout <= 1; enablePC<=1;
				#15 MDRout <= 0; enablePC<=0;
			end
			T0: begin 
				PCout <= 1; enableMAR <= 1; IncPC<=1; enableZ<=1;
				#15 PCout <= 0; enableMAR <= 0; IncPC<=0; enableZ<=0;
			end
			T1: begin
			   enableMDR <= 1; MDR_read<=3'd1; ZLowout<=1; enablePC<=1;  
				#15 enableMDR <= 0; MDR_read<=3'd0;ZLowout<=0; enablePC<=0;
			end
			T2: begin
				MDRout <= 1; enableIR <= 1;
				#15 MDRout <= 0; enableIR <= 0;			
			end
			T3: begin
				Gra<=1;Rout<=1; enableCON<=1;
				#15 Gra<=0;Rout<=0;enableCON<=0;
			end
			T4: begin
				PCout<=1;enableY <= 1;
				#15 PCout<=0;enableY <= 0;
			end
			T5: begin
			   Cout <= 1; enableZ <= 1; 
				#15 Cout <= 0; enableZ <= 0;
			end
			T6: begin
			   ZLowout<=1; enablePC<=1;
				#15 ZLowout<=0; enablePC<=0;
			end
			T7: begin
				PCout<=1;
			end
		endcase
	end
endmodule
