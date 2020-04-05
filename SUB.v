

`timescale 1ns / 1ps
module SUB(input wire [31:0] Ra, input wire [31:0] Rb, input wire cin, output wire [31:0] sum, output wire cout);
	wire [31:0] temp; 
	NEGATE neg(.Ra(Rb),.Rz(temp));
	ADD add(.Ra(Ra), .Rb(temp),.cin(cin),.sum(sum),.cout(cout));
endmodule



//Testbench
module SUB_tb;
	reg [31:0] x,y;
	reg cin;
	wire signed [31:0] z;
	wire cout;
	 
	initial begin
	  x=0; y=0; cin=0;
	  #10 x=32'd1; 	y=32'd1;  	cin=1'd0;		//sum = 0, 		cout = 0
	  #10 x=32'd235; 	y=32'd35;	cin=1'd0;		//sum = 2, 		cout = 0
	  #10 x=32'd20;	y=32'd25; 	cin=1'd0;		//sum = -5, 	cout = 0	
//	  #10 x=32'd999; 	y=32'd; 	cin=1'd0; 		//sum = 1000,	cout = 0
	end
	
	
	SUB sub_op(.Ra(x), .Rb(y),.cin(cin),.sum(z),.cout(cout));
	
	initial
	  $monitor( "X=%d, Y=%d, Cin= %d, Z=%d, Cout=%d", x,y,cin,z,cout);

endmodule

