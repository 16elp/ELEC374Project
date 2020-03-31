// File Name: bus_tb;
`timescale 1ns/10ps
module bus_tb;
	reg clk, clr;
	reg R1_enable, R2_enable , R1_out, R2_out;
	reg [31:0] R1_in, R2_in;
	wire [31:0] R1_data_out, R2_data_out;
	wire [4:0] encoder_signal;
	wire [31:0] bus_data;


	initial 
		begin
	
		clk = 0;			
	end
	
	initial 
		begin
		
		#100 	//Assert R1_enable and put information into R1 
			R2_enable <= 1'b1;
			R2_in <= 32'd15;
			clr <= 1'b0;
		
			
		#100  //Assert signal to encoder to put R1_out onto the busout
			R1_out <= 1'b0;
			R2_out <= 1'b1;
		
	end
	
	
	always
		#10 clk <= ~clk;
		
	Reg_32bit R1(clk, clr, R1_enable, R1_in, R1_data_out);
	Reg_32bit R2(clk, clr, R2_enable, R2_in, R2_data_out);
	
	encoder_32to5 busEncoder({{29{1'b0}}, R2_out, R1_out, 1'b0}, encoder_signal);

	mux_32to1 busMux(
		.BusMuxIn_R1(R1_data_out), 
		.BusMuxIn_R2(R2_data_out), 
		.select_signal(encoder_signal),
		.BusMuxOut(bus_data)
		);
	
	
	
	endmodule
