//// File Name: IncPC_32bit.v
//
`timescale 1ns / 1ps
module IncPC_32bit(
	input [31:0] PCin,
	input  IncPC,
	output wire[31:0] PCnew
	);
	
	assign PCnew = PCin + 1;
				
//	always @ (IncPC)	
//		$monitor( "PCin=%h, PCnew=%h\n",PCin,PCnew);
endmodule
