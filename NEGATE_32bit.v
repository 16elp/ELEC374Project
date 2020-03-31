// File Name: NOT_32bit.v

`timescale 1ns / 1ps
module NEGATE_32bit(
	input wire [31:0] Ra,
	output wire [31:0] Rz
	);
	//	assign Rz =!Ra +1;
	
	wire [31:0] temp; 
	wire cout;
	NOT_32bit not_op(.Ra(Ra),.Rz(temp));
	ADD_32bit add_op(.Ra(temp), .Rb(32'd1),.cin(1'd0),.sum(Rz),.cout(cout));
	

endmodule



//Testbench
module NEGATE_32bit_tb;
	reg [31:0] x;
	wire [31:0] z;
	 
	initial begin
	  x=0;
	  #10 x=32'h00000000; 	// z=32'h00000000
	  #10 x=32'hAAAAAAAA; 	// z=32'h55555556
	  #10 x=32'hFFFFFFFF; 	// z=32'h00000001
	end
	
	NEGATE_32bit negate_op(.Ra(x),.Rz(z));
	
	initial
	  $monitor( "X=%h, Z= %h", x,z);

endmodule

