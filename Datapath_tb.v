 //Datapath_tb.v file
`timescale 1ns/10ps

module Datapath_tb;
	reg clk, clr;
	reg IncPC, CON_enable; //Not actually implemented in Datapath yet
	reg [31:0] Mdatain;
	wire [31:0] bus_contents;
	reg RAM_write, MDR_enable, MDRout, MAR_enable, IR_enable;
	reg [2:0] MDR_read;
	reg R_enable, Rout;
	reg [15:0] R0_R15_enable, R0_R15_out;
	reg Gra, Grb, Grc;
	reg HI_enable, LO_enable, Z_enable, Y_enable, PC_enable, InPort_enable, OutPort_enable;
	reg InPortout, PCout, Yout, ZLowout, ZHighout, LOout, HIout, BAout, Cout;
	wire [4:0] opcode;
	wire[31:0] OutPort_output;
	reg [31:0] InPort_input;
	
	parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
	reg [3:0] Present_state = Default;

Datapath DUT(	
   .clk(clk),								
	.clr(clr),                       
	                                 
	.Mdatain(Mdatain), 
	.MDR_read(MDR_read),
	.RAM_write(RAM_write),
		
	.IncPC(IncPC),
	
	.R_enable(R_enable),					
	.Rout(Rout),		
	.R0_R15_enable_in(R0_R15_enable), 
	.R0_R15_out_in(R0_R15_out),
	
	.MDR_enable(MDR_enable),         
	.MDRout(MDRout),                 
	.MAR_enable(MAR_enable),         
												
	.Gra(Gra),								
	.Grb(Grb),                       
	.Grc(Grc),                       
		                              
	.HI_enable(HI_enable),        	
	.LO_enable(LO_enable),        	
   .Z_enable(Z_enable),          	
	.Y_enable(Y_enable),          	
   .PC_enable(PC_enable),        	
   .InPort_enable(InPort_enable),
	.OutPort_enable(OutPort_enable),
	.IR_enable(IR_enable),				
	.CON_enable(CON_enable),		
	
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
	.bus_contents(bus_contents)
);


initial
	begin
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

always @(Present_state) // do the required job in each state
	begin
		case (Present_state) // assert the required signals in each clock cycle
			Default: begin
				PCout <= 0; ZLowout <= 0; MDRout <= 0; // initialize the signals
				MAR_enable <= 0; Z_enable <= 0; CON_enable<=0; 
				InPort_enable<=0; OutPort_enable<=0; InPort_input<=32'd0;
				PC_enable <=0; MDR_enable <= 0; IR_enable <= 0; Y_enable <= 0;
				IncPC <= 0; RAM_write<=0;
				Mdatain <= 32'h00000000; Gra<=0; Grb<=0; Grc<=0; BAout<=0; Cout<=0;
				InPortout<=0; ZHighout<=0; LOout<=0; HIout<=0; 
				HI_enable<=0; LO_enable<=0;
				Rout<=0;R_enable<=0;MDR_read<=2'b00;
				R0_R15_enable<= 16'd0; R0_R15_out<=16'd0;// set to nothing to have the IR control the ins and outs
			end
			
			//IR output is taken if the IR signal is there (non-null) OUR OWN R0_R15_enable and R0_R15_out signals are ZERO
			//Otherwise, we use our IRs R0_R15_enable and R0_R15_out signals
			//MDR now has 3 inputs to its mux, MDR_read selects 0 for bus_contents, 1 for RAM_data_out, or 2 for the Mdatain that we set
			
						
//Instruction: 91100023 // brpl R2, 35
			
			Reg_load1a: begin
				Mdatain <= 32'h00000000;     //Data to be inserted into R0
				MDR_enable <= 1; MDR_read<=3'd2;
				#15 MDR_enable <= 0;MDR_read<=3'd0;
			end
			
			Reg_load1b: begin    
				MDRout <= 1; R0_R15_enable<=16'h0001; //to enable R0 
				#15 MDRout <= 0; R0_R15_enable<= 16'd0;
			end
			
			Reg_load2a: begin
			   	Mdatain <= 32'hFFFFFFFB;      //Data to be inserted into R2
			  	MDR_enable <= 1;MDR_read<=3'd2;
				#15 MDR_enable <= 0;MDR_read<=3'd0;
			end
			
			Reg_load2b: begin
				MDRout <= 1; R0_R15_enable<=16'h0004;  //enable R2   
				#15 MDRout <= 0; R0_R15_enable<= 16'd0;
			end
			
			Reg_load3a: begin
				Mdatain <= 32'h00000000;   
			   MDR_enable <= 1;MDR_read<=3'd2;
				#15 MDR_enable <= 0;MDR_read<=3'd0; //Load PC with what is in RAM at location Zero
			end
			
			Reg_load3b: begin
				MDRout <= 1; PC_enable<=1;     //whatever you enable must be disbled 15 time units after
				#15 MDRout <= 0; PC_enable<=0;
			end
			
			T0: begin 
				PCout <= 1; MAR_enable <= 1; IncPC<=1; Z_enable<=1;
				#15 PCout <= 0; MAR_enable <= 0; IncPC<=0; Z_enable<=0;
			end
			
			T1: begin
			   MDR_enable <= 1; MDR_read<=3'd1; ZLowout<=1; PC_enable<=1;   //Loads MDR from RAM output
				#15 MDR_enable <= 0; MDR_read<=3'd0;ZLowout<=0; PC_enable<=0;
			end
			
			T2: begin
				MDRout <= 1; IR_enable <= 1;
				#15 MDRout <= 0; IR_enable <= 0;			
			end
			
			T3: begin
				Gra<=1;Rout<=1; CON_enable<=1;
				#15 Gra<=0;Rout<=0;CON_enable<=0;
			end
			
			T4: begin
				PCout<=1;Y_enable <= 1;
				#15 PCout<=0;Y_enable <= 0;

			end
			
			T5: begin
			   Cout <= 1; Z_enable <= 1; 
				#15 Cout <= 0; Z_enable <= 0;
			end
			
			T6: begin
			   ZLowout<=1; PC_enable<=1;
				#15 ZLowout<=0; PC_enable<=0;
			end
			
			T7: begin
				PCout<=1;
			end
		endcase
	end
	
	
endmodule


