
// dependent files: MDMux_32bit.v MDR_32bit.v
`timescale 1ns/10ps
module MDR_32bit_tb;
	reg clr;
	reg clk; 
	reg read;
	reg MDRin;
	reg [31:0] Mdatain;
	reg [31:0] BusMuxOut;
	wire [31:0] d;
	wire [31:0] q;
	
	
	initial 
		begin
	
		clk = 0;			
	
	
		#100   //testing MDR input storage functionality
			clr <= 1'd0;
			read <= 1'd1;
			Mdatain <= 32'd15;
			MDRin <= 1'd1;
			
		 		
		#100  //testing the clear function
			clr <= 1'd1;
			
			
				
				////testing Bus input storage functionality
		#100 
			clr <= 1'd0;
			read <= 1'd0;
			BusMuxOut <= 32'd30;
			MDRin <= 1'd1;		
			
	end
	
	always
		#10 clk <= ~clk;

	mux_2to1 md_mux(
		Mdatain,
		BusMuxOut,
	   read,
		d
		);
			
	Reg_32bit mdr(
		d,
		clk,
		clr,
		MDRin,
		q
		);
	
		
endmodule
