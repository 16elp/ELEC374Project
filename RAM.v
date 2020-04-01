
module RAM(input [31:0] data, input [7:0] address, input we, clk, output [31:0] q);

	reg [31:0] ram[511:0];
	reg [31:0] addressReg;
	
	initial
	begin : INIT
		$readmemh("init.mif", ram); 
	end
	
	always @(posedge clk)
	begin
		if (we)
			ram[address] <= data;
		addressReg <= address;
	end
	assign q = ram[addressReg];
endmodule


