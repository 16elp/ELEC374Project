// File Name: encoder_32to5.v
`timescale 1ns/10ps

module encoder_32to5(
	input wire [31:0] encoder_in,
	output reg [4:0] encoder_out
	);
		
	always@(*) begin
		case(encoder_in)
         32'h00000001 : encoder_out <= 5'd0; //R0     
         32'h00000002 : encoder_out <= 5'd1; //R1     
			32'h00000004 : encoder_out <= 5'd2;  //R2    
         32'h00000008 : encoder_out <= 5'd3;  //R3    
         32'h00000010 : encoder_out <= 5'd4;  //R4    
         32'h00000020 : encoder_out <= 5'd5;  //R5    
         32'h00000040 : encoder_out <= 5'd6;  //R6    
         32'h00000080 : encoder_out <= 5'd7;  //R7    
         32'h00000100 : encoder_out <= 5'd8;  //R8    
         32'h00000200 : encoder_out <= 5'd9;  //R9    
         32'h00000400 : encoder_out <= 5'd10; //R10   
         32'h00000800 : encoder_out <= 5'd11; //R11   
         32'h00001000 : encoder_out <= 5'd12; //R12   
         32'h00002000 : encoder_out <= 5'd13; //R13   
         32'h00004000 : encoder_out <= 5'd14; //R14   
         32'h00008000 : encoder_out <= 5'd15; //R15   
			32'h00010000 : encoder_out <= 5'd16; //HI    
         32'h00020000 : encoder_out <= 5'd17; //LO    
         32'h00040000 : encoder_out <= 5'd18; //Zhigh 
			32'h00080000 : encoder_out <= 5'd19; //Zlow  
         32'h00100000 : encoder_out <= 5'd20; //PC    
         32'h00200000 : encoder_out <= 5'd21; //MDR   
			32'h00400000 : encoder_out <= 5'd22; //InPort
         32'h00800000 : encoder_out <= 5'd23; //C_sign_extended    
//         32'h01000000 : encoder_out <= 5'd24;
//         32'h02000000 : encoder_out <= 5'd25;
//         32'h04000000 : encoder_out <= 5'd26;
//         32'h08000000 : encoder_out <= 5'd27;
//         32'h10000000 : encoder_out <= 5'd28;
//         32'h20000000 : encoder_out <= 5'd29;
//         32'h40000000 : encoder_out <= 5'd30;
//         32'h80000000 : encoder_out <= 5'd31;
			default: encoder_out <= 5'd31;
      endcase
   end
endmodule

