//Filename: SHL_32bit.v

module SHL_32bit(
	input wire [31:0] data_in,
	input wire [31:0] num_shifts,
	output wire [31:0] out
);

	assign out[31:0] = data_in<<num_shifts;

	
endmodule

module SHL_32bit_tb;
	reg [31:0] in = 0;
	wire [31:0] data_out;
	integer a = 2;
	
	initial begin
		#100 in <= 32'hFFFFFFF0;
	end
	
	SHL_32bit shl(
		in,
		a,
		data_out
		);
		
endmodule

	