//insruction: C1000000


Reg_load1a: begin
	Mdatain <= 32'h0000FFAA; 
	enableMDR <= 1; MDR_read<=3'd2;
	#15 enableMDR <= 0;MDR_read<=3'd0;
end

Reg_load1b: begin 
	MDRout <= 1; enableLO<=1;   
	#15 MDRout <= 0; enableLO<= 0; 
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
	#15 PCout <= 0; enableMAR <= 0;  IncPC<=0; enableZ<=0;
end

T1: begin 
	enableMDR <= 1; MDR_read<=3'd1; ZLowout<=1; enablePC<=1;   
	#15 enableMDR <= 0; MDR_read<=3'd0; ZLowout<=0; enablePC<=0;
end

T2: begin
	MDRout <= 1; enableIR <= 1;
	#15 MDRout <= 0; enableIR <= 0;			
end

T3: begin
	Gra<=1;R_enable<=1;LOout<=1;
	#15 Gra<=0;R_enable<=0;LOout<=1;
end	
