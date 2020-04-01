// File Name: NOT_32bit.v

`timescale 1ns / 1ps
module NOT(
	input wire [31:0] Ra,
	output wire [31:0] Rz
	);
	
//	assign Rz = !Ra;
	
	genvar i;
	generate
		for (i=0; i<32;i=i+1) begin : loop
			assign Rz[i] = !Ra[i];
		end
	endgenerate
endmodule



//Testbench
module NOT_tb;
	reg [31:0] x;
	wire [31:0] z;
	 
	initial begin
	  x=0;
	  #10 x=32'h00000000; 	// z=32'hFFFFFFFF
	  #10 x=32'hAAAAAAAA; 	// z=32'h55555555
	  #10 x=32'hFFFFFFFF; 	// z=32'h00000000
	end
	
	NOT not_op(.Ra(x),.Rz(z));
	
	initial
	  $monitor( "X=%h, Z= %h", x,z);

endmodule

