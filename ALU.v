// File Name: ALU.v
`timescale 1ns/10ps

module ALU(
	input clk,
	input clear,
	input branch_flag,
	input IncPC,
	
	input wire [31:0] A_reg,
	input wire [31:0] Y_reg,
	input wire [31:0] B_reg,

	input wire [4:0] opcode,

	output reg [63:0] C_reg //this has to be sent to a high and low 3register
);
	parameter Addition = 5'b00011, Subtraction = 5'b00100, Multiplication = 5'b01110, Division = 5'b01111, Shift_right = 5'b00101, Shift_left = 5'b00110, Rotate_right = 5'b00111, Rotate_left = 5'b01000, Logical_AND = 5'b01001, Logical_OR = 5'b01010, Negate = 5'b10000, _Not = 5'b10001, Branch = 5'b10010, Imm_Addition = 5'b01011, Imm_Logical_AND = 5'b01100, Imm_Logical_OR	=5'b01101, Load_Dir=5'b00000, Load_Imm=5'b00001, Store_Dir=5'b00010, JR=5'b10011, JAL=5'b10100, In=5'b10101, Out=5'b10110, MFHI= 5'b10111, MFLO=5'b11000;
	
	wire [31:0] IncPC_out, shr_out, shl_out, lor_out, land_out, neg_out, not_out, adder_sum, adder_cout, sub_sum, sub_cout, rol_out, ror_out;
	wire [63:0] mul_out, div_out;

	
	always @(*) 
		begin
			if (IncPC==1) begin
					C_reg[31:0] <= IncPC_out[31:0];
					C_reg[63:32] <= 32'd0;
			end
			case (opcode) 
				Addition,Imm_Addition,Load_Dir,Load_Imm,Store_Dir: begin
					C_reg[31:0] <= adder_sum[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				Subtraction: begin
					C_reg[31:0] <= sub_sum[31:0];	
					C_reg[63:32] <= 32'd0;
				end
				
				Logical_OR, Imm_Logical_OR: begin
					C_reg[31:0] <= lor_out[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				Logical_AND, Imm_Logical_AND: begin
					C_reg[31:0] <= land_out[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				Negate: begin
					C_reg[31:0] <= neg_out[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				_Not: begin
					C_reg[31:0] <= not_out[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				Shift_left: begin
					C_reg[31:0] <= shl_out[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				Shift_right: begin
					C_reg[31:0] <= shr_out[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				Rotate_right: begin
					C_reg[31:0] <= ror_out[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				Rotate_left: begin
					C_reg[31:0] <= rol_out[31:0];
					C_reg[63:32] <= 32'd0;
				end
				
				Multiplication: begin
					C_reg[63:0] <= mul_out[63:0];
				end
				
				Division: begin
					C_reg[63:0] <= div_out[63:0];
				end
				
				Branch: begin
					if(branch_flag==1) begin
						C_reg[31:0] <= adder_sum[31:0];
						C_reg[63:32] <= 32'd0;
					end 
					else begin
						C_reg[31:0] <= Y_reg[31:0];
						C_reg[63:32] <= 32'd0;
					end
				end	
			endcase
	end
	
	//ALU Operations
	SHL_32bit shl(Y_reg,B_reg,shl_out);
	SHR_32bit shr(Y_reg,B_reg,shr_out);
	OR_32bit lor(Y_reg,B_reg,lor_out);
	AND_32bit land(Y_reg,B_reg,land_out);
	NEGATE_32bit neg(A_reg,neg_out);
	NOT_32bit not_module(A_reg,not_out);
	ADD_32bit adder(.Ra(Y_reg), .Rb(B_reg),.cin({1'd0}),.sum(adder_sum),.cout(adder_cout));
	SUB_32bit subtractor(.Ra(Y_reg), .Rb(B_reg),.cin({1'd0}),.sum(sub_sum),.cout(sub_cout));
	ROL_32bit rol_op(Y_reg,B_reg,rol_out);
	ROR_32bit ror_op(Y_reg,B_reg,ror_out);
	DIV_simple div(Y_reg,B_reg,div_out);
	MUL_32bit mul(Y_reg,B_reg,mul_out);
	//PC Incrementor
	IncPC_32bit pcInc(A_reg,IncPC,IncPC_out);

endmodule
