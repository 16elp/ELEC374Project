// File Name: CONFF.v
`timescale 1ns/10ps

module CONFF(
	input [1:0] IR_bits,
	input signed [31:0] bus,
	input CON_in,
	output CON_out
	);
	
	wire [3:0] dec_out;
	
	wire eq;
	wire not_eq;
	wire pos;
	wire neg;
	wire branch_flag;
	
	assign eq 		= (bus == 32'd0) ? 1'b1 : 1'b0;
	assign not_eq	= (bus != 32'd0) ? 1'b1 : 1'b0;
	assign pos		= (bus[31] == 0) ? 1'b1 : 1'b0;
	assign neg 		= (bus[31] == 1) ? 1'b1 : 1'b0;
	
	decoder_2_to_4	dec_op(IR_bits, dec_out);
	
	assign branch_flag = (dec_out[0]&eq | dec_out[1]&not_eq | dec_out[2]&pos | dec_out[3]&neg);
	
	ff CON_ff(.clk(CON_in), .d(branch_flag), .q(CON_out));
	
endmodule


module ff(
	input wire clk, 
	input wire d,
	output reg q,
	output reg q_not
);
		
	initial begin
		q <= 0;
		q_not <= 1;
	end
	
	always@(clk) 
	begin
		q <= d;
		q_not <= !d;
	end

endmodule

module decoder_2_to_4(
	input wire [1:0] decoder_in,
	output reg [3:0] decoder_out
	);
		
	always@(*) begin
		case(decoder_in)
         4'b00 : decoder_out <= 4'b0001;    
         4'b01 : decoder_out <= 4'b0010;    
         4'b10 : decoder_out <= 4'b0100;    
         4'b11 : decoder_out <= 4'b1000;    

      endcase
   end
endmodule

module CONFF_logic_tb();
	reg [1:0] IR_bits;
	reg signed [31:0] bus;
	reg CON_in;
	wire CON_out;
	
	 
	initial begin
		  IR_bits=2'b00; bus=32'd0; CON_in=0;
	  #5 IR_bits=2'b00; bus=32'd0; CON_in=0;		//CON_out = 0
	  #5 IR_bits=2'b00; bus=32'd0; CON_in=1;		//CON_out = 1
	  #5 IR_bits=2'b00; bus=32'd5; CON_in=0;		//CON_out = 0
	  #5 IR_bits=2'b00; bus=32'd5; CON_in=1;		//CON_out = 0

	  #5 IR_bits=2'b01; bus=32'd5; CON_in=0;		//CON_out = 0
	  #5 IR_bits=2'b01; bus=32'd5; CON_in=1;		//CON_out = 1	 
  	  #5 IR_bits=2'b01; bus=32'd0; CON_in=0;		//CON_out = 0
	  #5 IR_bits=2'b01; bus=32'd0; CON_in=1;		//CON_out = 0
	 
	  #5 IR_bits=2'b10; bus=32'd5; CON_in=0;		//CON_out = 0
	  #5 IR_bits=2'b10; bus=32'd5; CON_in=1;		//CON_out = 1
	  #5 IR_bits=2'b10; bus=   -5; CON_in=0;	   //CON_out = 0
	  #5 IR_bits=2'b10; bus=   -5; CON_in=1;	   //CON_out = 0
	     
	  #5 IR_bits=2'b11; bus=   -5; CON_in=0;	   //CON_out = 0
	  #5 IR_bits=2'b11; bus=   -5; CON_in=1;	   //CON_out = 1
	  #5 IR_bits=2'b11; bus=    5; CON_in=0;	   //CON_out = 0
	  #5 IR_bits=2'b11; bus=    5; CON_in=1;	   //CON_out = 0


	end
	
	
	initial 
	  $monitor( "IR_bits=%b, bus=%d, CON_in=%b, CON_out=%b", IR_bits, bus, CON_in, CON_out);
	
	CONFF CONFF(IR_bits, bus, CON_in, CON_out);
endmodule
	