
module DIV(input [31:0] Q, input [31:0] M, input start, input clk, output reg [31:0] quotient, output wire [31:0] remainder, output wire ready);
   reg [63:0]   Q2, M2, diff;
	assign remainder = Q2[31:0];
   reg [5:0] bit;
   assign ready = !bit;
   initial bit = 0;

   always @( posedge clk )
     if ( ready && start ) begin
        bit = 32;
        quotient = 0;
        Q2 = {32'd0,Q};
        M2 = {1'b0,M,31'd0};
     end else begin
        diff = Q2 - M2;
        quotient = { quotient[30:0], ~diff[63] };
	M2 = { 1'b0, M2[63:1] };
	if ( !diff[63] ) Q2 = diff;
        bit = bit - 1;
     end

endmodule

module DIV(		
		input [31:0] Q,
		input [31:0] M,
		output wire [63:0] result
);
		
		assign result = {Q%M , Q/M};		
		
endmodule


module DIV_32bit_tb;
   reg [31:0]  x, y;
	wire [31:0] quot, rem;

	
   integer    i;
   parameter  num_tests = 10;

   reg        clk;
   initial clk = 0;
   always #1 clk = ~clk;

   reg        start;
   wire       ready;
	
   initial begin
      # 0.5;
      while ( !ready ) #1;
		
		x = 100;
		y = 3;
		start = 1;
		while ( ready ) #1;
		start = 0;
		while ( !ready ) #1;
		$display(" %d / %d  =  %d r %d", x, y, quot, rem);
		
		x = 55;
		y = 10;
		start = 1;
		while ( ready ) #1;
		start = 0;
		while ( !ready ) #1;
		$display(" %d / %d  =  %d r %d", x, y, quot, rem);

   end
	
   DIV div(x,y,start,clk,quot,rem,ready);
	
//	DIV_simple div(x,y,quot);
//	initial
//	$monitor(" %d / %d  =  %d r", x, y, quot);

endmodule
	

	
