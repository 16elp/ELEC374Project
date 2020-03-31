//Quartus II Verilog Template
//Single port RAM with single read/write address 

module RAM(
	input [31:0] data,
	input [7:0] addr,
	input we, clk,
	output [31:0] q
);

	// Declare the RAM variable
	reg [31:0] ram[511:0];

	// Variable to hold the registered read address
	reg [31:0] addr_reg;
	
	// Specify the initial contents.  You can also use the $readmemb
	// system task to initialize the RAM variable from a text file.
	// See the $readmemb template page for details.
	
	initial
	begin : INIT
		$readmemh("init.mif", ram); 
	end

	
	always @(posedge clk)
	begin
		// Write
		if (we)
			ram[addr] <= data;

		addr_reg <= addr;
	end
	
	
	assign q = ram[addr_reg];
			// Continuous assignment implies read returns NEW data.
			// This is the natural behavior of the TriMatrix memory
			// blocks in Single Port mode.  

//	always @ (clk)	
//	 $monitor( "q=%h",ram[addr_reg]);

endmodule
