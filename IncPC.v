
`timescale 1ns / 1ps
module IncPC(input [31:0] PCinput, input  IncPC, output wire[31:0] newPC);
	assign newPC = PCinput + 1;
endmodule
