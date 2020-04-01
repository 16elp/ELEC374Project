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
			   	Mdatain <= 32'hFFFB;   
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
				#15 Gra<=0;Rout<=0; enableCON<=0;
			end
			
			T4: begin
				PCout<=1; enableY <= 1;
				#15 PCout<=0; enableY <= 0;
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

