// File Name: AND_32bit.v

`timescale 1ns / 1ps
module AND_32bit(
	input wire [31:0] Ra,
	input wire [31:0] Rb,
	output wire [31:0] Rz
	);
	
//	assign Rz = Ra & Rb;
	
	genvar i;
	generate
		for (i=0; i<32;i=i+1) begin : loop
			assign Rz[i] = ((Ra[i])&(Rb[i]));
		end
	endgenerate
endmodule



//Testbench
module AND_32bit_tb;
	reg [31:0] x,y;
	wire [31:0] z;
	 
	initial begin
	  x=0; y=0;
	  #10 x=32'h00000000; 	y=32'hABCD1234; 	// z=32'h00000000
	  #10 x=32'hAAAAAAAA; 	y=32'h55555555; 	// z=32'h00000000
	  #10 x=32'hFFFFFFFF; 	y=32'hABCD1234; 	// z=32'hABCD1234
	  #10 x=32'h00000037; 	y=32'h00000073; 	// z=32'h00000033
	end
	
	AND_32bit and_op(.Ra(x), .Rb(y),.Rz(z));
	
	initial
	  $monitor( "X=%h, Y=%h, Z= %h", x,y,z);

endmodule

