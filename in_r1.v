//insruction: A8800000

Reg_load1a: begin
	InPort_input <= 32'hFFFFFFFF; enableInPort<=1;   
	#15 InPort_input <= 32'd0; enableInPort<=0;   
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
	Gra<=1;R_enable<=1; InPortout<=1;
	#15 Gra<=0;R_enable<=0;InPortout<=1;
end

T2: begin
	MDRout <= 1; IR_enable <= 1;
	#15 MDRout <= 0; IR_enable <= 0;			
end

T3: begin
	Gra<=1;R_enable<=1; InPortout<=1;
	#15 Gra<=0;R_enable<=0;InPortout<=1;
end


