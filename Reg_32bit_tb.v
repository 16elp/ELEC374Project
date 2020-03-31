// File Name: Reg_32bit_tb
`timescale 1ns/10ps
module Reg_32bit_tb;
	reg clr;
	reg clk; 
	reg R1in;
	reg [31:0] d;
	wire [31:0] q;
	
	
	initial 
		begin
	
		clk = 0;			
	
	
		#10 
			d <= 32'd0;
			R1in <= 1'b0;
			clr <= 1'b1;
			
		 		//checking that R1in works
		#10 
			d <= 32'd15;
			R1in <= 1'b1;
			clr <= 1'b0;
			
				
				//checking that R1out works
		#10 
			d <= 32'd10;
			R1in <= 1'b0;
		   clr <= 1'b0;
			
				
		 		//clearing at the end with a another signal asserted
		#10 
			d <= 32'd15;
			R1in <= 1'b1;
			clr <= 1'b1;	
			
	end
	
	always
		#10 clk <= ~clk;

	Reg_32bit reg_32bit(
		clk,
		clr,
		R1in,
		d,
		q
			);
			
	initial
		$monitor( "clock=%d, clear=%d, enable= %d, d=%d, q=%d", clk,clr,R1in,d,q);

		
endmodule
