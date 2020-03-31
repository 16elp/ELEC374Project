// File Name: IR.v
`timescale 1ns/10ps

module IR_logic(
	input [31:0] instruction,
	input Gra,
	input Grb,
	input Grc,
	input Rin,
	input Rout,
	input BAout,
	output [4:0] opcode,
	output [31:0] C_sign_extended,
	output [15:0] R0_R15_in,
	output [15:0] R0_R15_out,
	output wire [3:0] decoder_in
	);
	
	//wire [3:0] decoder_in;
	wire [15:0] decoder_out;
	
	assign decoder_in = (instruction[26:23]&{4{Gra}}) | (instruction[22:19]&{4{Grb}}) | (instruction[18:15]&{4{Grc}});
	decoder_4_to_16	dec_op(decoder_in, decoder_out);
	
	assign opcode = instruction[31:27];
	assign C_sign_extended = {{13{instruction[18]}},instruction[18:0]};
	assign R0_R15_in = {16{Rin}} & decoder_out;
	assign R0_R15_out = ({16{Rout}} | {16{BAout}}) & decoder_out;
	
	always @ (instruction)
	  $monitor( "ins_opcode=%b, ins_Ra=%b, ins_Rb=%b, ins_Rc=%b, ins_C= %b, opcode=%b, R0_R15_in=%b, R0_R15_out=%b, C_out=%b, decoder_in", instruction[31:27],instruction[26:23],instruction[22:19],instruction[18:15],instruction[14:0], opcode, R0_R15_in, R0_R15_out, C_sign_extended,decoder_in);
	
	
endmodule

module decoder_4_to_16(
	input wire [3:0] decoder_in,
	output reg [15:0] decoder_out
	);
		
	always@(*) begin
		case(decoder_in)
         4'b0000 : decoder_out <= 16'h0001;  //R0     
         4'b0001 : decoder_out <= 16'h0002;  //R1     
			4'b0010 : decoder_out <= 16'h0004;  //R2    
         4'b0011 : decoder_out <= 16'h0008;  //R3    
         4'b0100 : decoder_out <= 16'h0010;  //R4    
         4'b0101 : decoder_out <= 16'h0020;  //R5    
         4'b0110 : decoder_out <= 16'h0040;  //R6    
         4'b0111 : decoder_out <= 16'h0080;  //R7    
         4'b1000 : decoder_out <= 16'h0100;  //R8    
         4'b1001 : decoder_out <= 16'h0200;  //R9    
         4'b1010 : decoder_out <= 16'h0400;  //R10   
         4'b1011 : decoder_out <= 16'h0800;  //R11   
         4'b1100 : decoder_out <= 16'h1000;  //R12   
         4'b1101 : decoder_out <= 16'h2000;  //R13   
         4'b1110 : decoder_out <= 16'h4000;  //R14   
         4'b1111 : decoder_out <= 16'h8000;  //R15   
      endcase
   end
endmodule


module IR_logic_tb();
	reg [31:0] instruction;
	reg Gra, Grb, Grc, Rin, Rout, BAout;
	wire [31:0] C_out;
	wire [15:0] R0_R15_in, R0_R15_out;
	wire [4:0] opcode;
	wire [3:0] decoder_in;
	
	 
	initial begin
		instruction=0; Gra=0; Grb=0; Grc=0; Rin=0; Rout=0; BAout=0;
	  #10 instruction=32'b01110010100100011000011010001011; Gra=1; Grb=0; Grc=0; Rin=1; Rout=0; BAout=0;
	  #10 instruction=32'b01110010100100011000011010001011; Gra=0; Grb=1; Grc=0; Rin=1; Rout=0; BAout=0;
	  #10 instruction=32'b01110010100100011000011010001011; Gra=0; Grb=0; Grc=1; Rin=1; Rout=0; BAout=0;
	  #10 instruction=32'b01110010100100011000011010001011; Gra=0; Grb=1; Grc=0; Rin=0; Rout=1; BAout=0;
	  #10 instruction=32'b01110010100100011000011010001011; Gra=0; Grb=1; Grc=0; Rin=0; Rout=0; BAout=1;
	end
	
	
	initial 
	  $monitor( "ins_opcode=%b, ins_Ra=%b, ins_Rb=%b, ins_Rc=%b, ins_C= %b, opcode=%b, R0_R15_in=%b, R0_R15_out=%b, C_out=%b, decoder_in", instruction[31:27],instruction[26:23],instruction[22:19],instruction[18:15],instruction[14:0], opcode, R0_R15_in, R0_R15_out, C_out,decoder_in);
	
	IR_logic IR(instruction,Gra,Grb,Grc,Rin,Rout,BAout,opcode,C_out,R0_R15_in,R0_R15_out,decoder_in);
endmodule
	