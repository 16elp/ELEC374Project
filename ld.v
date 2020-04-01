//Instruction: 00800055 // ld r1, 85
			


			Reg_load1a: begin
				Mdatain <= 32'h00000000;     //Data to be inserted into R2
				enableMDR <= 1; MDR_read<=3'd2;
				#15 enableMDR <= 0;MDR_read<=3'd0;
			end
			Reg_load1b: begin    
				MDRout <= 1; R0_R15_enable<=16'h0001; //to enable R2 
				#15 MDRout <= 0; R0_R15_enable<= 16'd0;
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
				PCout <= 1; enableMAR <= 1; 
				#15 PCout <= 0; enableMAR <= 0; 
			end
			T1: begin
			   	enableMDR <= 1; MDR_read<=3'd1;   //Loads MDR from RAM output
				#15 enableMDR <= 0; MDR_read<=3'd0;
			end
			T2: begin
				MDRout <= 1; enableIR <= 1;
				#15 MDRout <= 0; enableIR <= 0;			
			end
			T3: begin
				Grb<=1;BAout<=1;enableY<=1;
				#15 Grb<=0;BAout<=0;enableY<=0;
			end
			T4: begin
				Cout<=1;enableZ <= 1;
				#15 Cout<=0;enableZ <= 0;
			end
			T5: begin
			   	ZLowout <= 1; enableMAR <= 1; 
				#15 ZLowout <= 0; enableMAR <= 0;
			end
			T6: begin
			 	MDR_read<=3'd1; enableMDR <= 1;
				#15 MDR_read<=3'd0; enableMDR <= 0;
			end
			T7: begin
			   	MDRout <= 1; Gra <= 1; R_enable <= 1;
				#15 MDRout <= 0; Gra <= 1; R_enable <= 0; Rout <= 1;
			end



