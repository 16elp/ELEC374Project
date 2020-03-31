//Filename: SHR_32bit.v

module SHR_32bit(
	input wire [31:0] data_in,
	input wire [31:0] num_shifts,
	output wire [31:0] out
);
	assign out[31:0] = data_in>>num_shifts;
//always@(*) 
//	begin
//		if (num_shifts)
//			out[31:0] <= data_in>>num_shifts;
//	end

endmodule 


module SHR_32bit_tb;
	reg [31:0] in = 0;
	wire [31:0] data_out;
	integer a = 1;
	
	initial begin
		#100 in <= 32'hFFFFFFF0;
	end
	
	SHR_32bit shr(
		in,
		a,
		data_out
		);
		
endmodule

	