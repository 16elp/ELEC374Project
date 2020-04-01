
`timescale 1ns/10ps

module CONFF(input [1:0] IR_bits, input signed [31:0] bus, input CONInput, output CONOutput);
	wire [3:0] decoderOutput;
	wire equal;
	wire notEqual;
	wire positive;
	wire negative;
	wire branchFlag;
	
	assign equal 		= (bus == 32'd0) ? 1'b1 : 1'b0;
	assign notEqual		= (bus != 32'd0) ? 1'b1 : 1'b0;
	assign positive		= (bus[31] == 0) ? 1'b1 : 1'b0;
	assign negative 	= (bus[31] == 1) ? 1'b1 : 1'b0;
	
	decoder	dec(IR_bits, decoderOutput);
	
	assign branchFlag=(decoderOutput[0]&equal|decoderOutput[1]&notEqual|decoderOutput[2]&positive|decoderOutput[3]&negative);
	
	ff CONff(.clk(CONInput), .D(branchFlag), .Q(CONOutput));
endmodule

module ff(input wire clk, input wire D, output reg Q, output reg Q_not);	
	initial begin
		Q <= 0;
		Q_not <= 1;
	end
	always@(clk) 
	begin
		Q <= D;
		Q_not <= !D;
	end
endmodule

module decoder(input wire [1:0] decoderInput, output reg [3:0] decoderOutput);
	always@(*) begin
		case(decoderInput)
         		4'b00 : decoderOutput <= 4'b0001;    
       		 	4'b01 : decoderOutput <= 4'b0010;    
         		4'b10 : decoderOutput <= 4'b0100;    
         		4'b11 : decoderOutput <= 4'b1000;    
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
	  #5 IR_bits=2'b00; bus=32'd0; CON_in=0;	
	  #5 IR_bits=2'b00; bus=32'd0; CON_in=1;	
	  #5 IR_bits=2'b00; bus=32'd5; CON_in=0;	
	  #5 IR_bits=2'b00; bus=32'd5; CON_in=1;	

	  #5 IR_bits=2'b01; bus=32'd5; CON_in=0;		
	  #5 IR_bits=2'b01; bus=32'd5; CON_in=1;		 
  	  #5 IR_bits=2'b01; bus=32'd0; CON_in=0;	
	  #5 IR_bits=2'b01; bus=32'd0; CON_in=1;	
	 
	  #5 IR_bits=2'b10; bus=32'd5; CON_in=0;		
	  #5 IR_bits=2'b10; bus=32'd5; CON_in=1;	
	  #5 IR_bits=2'b10; bus=   -5; CON_in=0;	  
	  #5 IR_bits=2'b10; bus=   -5; CON_in=1;	
	     
	  #5 IR_bits=2'b11; bus=   -5; CON_in=0;	
	  #5 IR_bits=2'b11; bus=   -5; CON_in=1;
	  #5 IR_bits=2'b11; bus=    5; CON_in=0;	
	  #5 IR_bits=2'b11; bus=    5; CON_in=1;
	end
	CONFF CONFF(IR_bits, bus, CON_in, CON_out);
endmodule
	
