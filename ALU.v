
/

module ALU(input clk, input clear, input branch_flag, input IncPC, input wire [31:0] A, input wire [31:0] Y, input wire [31:0] B, input wire [4:0] opcode, output reg [63:0] C_reg);
	
wire [31:0] IncPCOutput, shrOutput, shlOutput, lorOutput, landOutput, negOutput, notOutput, adderSum, adderOutput, subSum, subOutput, rolOutput, rorOutput;
wire [63:0] mulOutput, divOutput;
	
always @(*) 
	begin
		if (IncPC==1) begin
			C[31:0] <= IncPCOutput[31:0];
			C[63:32] <= 32'd0;
		end
	case (opcode) 
		5'b00011, 5'b01011,5'b00000, 5'b00001, 5'b00010 : begin
			C[31:0] <= adderSum[31:0];
			C[63:32] <= 32'd0;
		end
		5'b00100 : begin
			C[31:0] <= subSum[31:0];	
			C[63:32] <= 32'd0;
		end
		5'b01010, 5'b01101 : begin
			C_reg[31:0] <= lorOutput[31:0];
			C_reg[63:32] <= 32'd0;
		end
		5'b01001, 5'b01100 : begin
			C[31:0] <= landOutput[31:0];
			C[63:32] <= 32'd0;
		end
		5'b10000 : begin
			C[31:0] <= negOutput[31:0];
			C[63:32] <= 32'd0;
		end
		5'b10001 : begin
			C_reg[31:0] <= notOutput[31:0];
			C_reg[63:32] <= 32'd0;
		end
		5'b00110 : begin
			C[31:0] <= shlOutput[31:0];
			C[63:32] <= 32'd0;
		end
		5'b00101 : begin
			C[31:0] <= shrOutput[31:0];
			C[63:32] <= 32'd0;
		end
		5'b00111 : begin
			C[31:0] <= rorOutput[31:0];
			C[63:32] <= 32'd0;
		end
		5'b01000 : begin
			C[31:0] <= rolOutput[31:0];
			C[63:32] <= 32'd0;
		end
		5'b01110 : begin
			C_reg[63:0] <= mulOutput[63:0];
		end
		5'b01111 : begin
			C[63:0] <= divOutput[63:0];
		end
		5'b10010 : begin
			if(branch_flag==1) begin
				C[31:0] <= adderSum[31:0];
				C[63:32] <= 32'd0;
			end 
			else begin
				C[31:0] <= Y[31:0];
				C[63:32] <= 32'd0;
			end
		end	
	endcase
end
SHL shl(Y,B,shlOutput);
SHR shr(Y,B,shrOutput);
OR lor(Y,B,lorOutput);
AND land(Y,B,landOutput);
NEGATE neg(A,negOutput);
NOT not_module(A,notOutput);
ADD adder(.Ra(Y), .Rb(B),.cin({1'd0}),.sum(adderSum),.cout(adderOutput));
SUB subtractor(.Ra(Y), .Rb(B),.cin({1'd0}),.sum(sub_sum),.cout(subOutput));
ROL rol_op(Y,B,rolOutput);
ROR ror_op(Y,B,rorOutput);
DIV div(Y,B,divOutput);
MUL mul(Y,B,mulOutput);
IncPC pcInc(A,IncPC,IncPCOutput);
endmodule
