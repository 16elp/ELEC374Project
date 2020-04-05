//Filename: SHL_32bit.v

module SHL(input wire [31:0] in, input wire [31:0] shifts, output wire [31:0] out);
	assign out[31:0] = in<<shifts;
endmodule

module SHL_tb;
	reg [31:0] in = 0;
	wire [31:0] data_out;
	integer a = 2;
	
	initial begin
		#100 in <= 32'hFFFFFFF0;
	end
	
	SHL shl(
		in,
		a,
		data_out
		);
		
endmodule

	
