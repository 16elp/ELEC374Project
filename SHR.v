//

module SHR(input wire [31:0] in, input wire [31:0] shifts, output wire [31:0] out);
	assign out[31:0] = in>>shifts;
endmodule 


module SHR_tb;
	reg [31:0] in = 0;
	wire [31:0] data_out;
	integer a = 1;
	
	initial begin
		#100 in <= 32'hFFFFFFF0;
	end
	
	SHR shr(
		in,
		a,
		data_out
		);
		
endmodule

	
