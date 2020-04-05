

`timescale 1ns / 1ps
module ADD(input [31:0] Ra, input [31:0] Rb, input wire cin, output wire[31:0] sum, output wire cout);
wire cout1;
CLA16 CLA1(.Ra(Ra[15:0]), .Rb(Rb[15:0]), .cin(cin), .sum(sum[15:0]), .cout(cout1));
CLA16 CLA2(.Ra(Ra[31:16]), .Rb(Rb[31:16]), .cin(cout1), .sum(sum[31:16]), .cout(cout));
endmodule

module CLA16(input wire [15:0] Ra, input wire [15:0] Rb, input wire cin, output wire [15:0] sum, output wire cout);
wire cout1,cout2,cout3;
CLA4 CLA1(.Ra(Ra[3:0]), .Rb(Rb[3:0]), .cin(cin), .sum(sum[3:0]), .cout(cout1));
CLA4 CLA2(.Ra(Ra[7:4]), .Rb(Rb[7:4]), .cin(cout1), .sum(sum[7:4]), .cout(cout2));				
CLA4 CLA3(.Ra(Ra[11:8]), .Rb(Rb[11:8]), .cin(cout2), .sum(sum[11:8]), .cout(cout3));
CLA4 CLA4(.Ra(Ra[15:12]), .Rb(Rb[15:12]), .cin(cout3), .sum(sum[15:12]), .cout(cout));
endmodule
 
module CLA4(input wire [3:0] Ra, input wire [3:0] Rb, input wire cin, output wire[3:0] sum, output wire cout);
	wire [3:0] P,G,c;
	assign P=Ra^Rb;	
	assign G=Ra&Rb;
	assign c[0]= cin;
	assign c[1]= G[0] | (P[0]&c[0]);
	assign c[2]= G[1] | (P[1]&G[0]) | P[1]&P[0]&c[0];
	assign c[3]= G[2] | (P[2]&G[1]) | P[2]&P[1]&G[0] | P[2]&P[1]&P[0]&c[0];
	assign cout = G[3] | (P[3]&G[2]) | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0] | P[3]&P[2]&P[1]&P[0]&c[0];
	assign sum[3:0] =P^c;
endmodule



//Testbench
module ADD_tb;
	reg [31:0] x,y;
	reg cin;
	wire [31:0] z;
	wire cout_f;
		 
	initial begin
	  x=0; y=0; cin=0;
//	  #10 x=32'd1; 	y=32'd1;  cin=1'd1;		//sum = 2, 		cout = 0
//	  #10 x=32'd1; 	y=32'd0;	 cin=1'd1;		//sum = 2, 		cout = 0
//	  #10 x=32'd15;	y=32'd15; cin=1'd1;		//sum = 31, 	cout = 0	
//	  #10 x=32'd999; 	y=32'd0;  cin=1'd1; 		//sum = 1000,	cout = 0
		#10 x=32'h0000000F; 	y=32'h000000001;  cin=1'h0; 		//sum = 10,	cout = 0
		#10 x=32'hFFFFFFFF; 	y=32'h000000001;  cin=1'h0; 		//sum = 00000000,	cout = 1

		end
	
	ADD adder(.Ra(x), .Rb(y),.cin(cin),.sum(z),.cout(cout_f));
	
	initial
	  $monitor( "X=%h, Y=%h, Cin= %h, Z=%h, Cout=%h", x,y,cin,z,cout_f);

endmodule


////Testbench
module CLA16_tb;
reg [15:0] a,b;
reg cin;
wire [15:0] sum;
wire cout;
 
  CLA16 uut(.Ra(a), .Rb(b),.cin(cin),.sum(sum),.cout(cout));
 
initial begin
  a=0; b=0; cin=0;
  #10 a=16'hffff; b=16'd0; cin=1'd1;		// sum = 16'h0000, cout = 1
  #10 a=16'hffff; b=16'd1; cin=1'd0;		// sum = 16'h0000, cout = 1

end
 
initial
  $monitor( "A=%h, B=%h, Cin= %h, Sum=%h, Cout=%h", a,b,cin,sum,cout);
endmodule
