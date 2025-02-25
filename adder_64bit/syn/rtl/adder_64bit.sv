//64 bit adder using one instance of 32bit.

module adder_64bit #(parameter N = 64)(input clk , rst, input logic signed [N-1:0] inp1, logic signed [N-1:0] inp2, output logic signed [N-1:0] sum , logic cout);

typedef enum logic[1:0] { LOAD = 2'b00 , SHIFT = 2'b01 , SUM_S = 2'b10 } state;
state PS , NS;
localparam M = N/2;

logic [M-1:0] A;
logic [M-1:0] B;
logic temp_c;
logic [M-1:0] sum_a;
logic cout_a;
logic [M-1:0] low_output;
logic [M-1:0] high_output;
logic temp_cin;

adder #(M) m1 ( A ,B , temp_c , sum_a , cout_a);

always_ff@(posedge clk or negedge rst) begin
   if(!rst) 
     begin 
       PS <= LOAD;
     end 
   else 
       PS <= NS;
end
   
always_comb 
begin 
   case(PS)
		LOAD : NS = SHIFT;
		SHIFT: NS = SUM_S;
		SUM_S: NS = LOAD;
      endcase 
end 

always_comb 
begin 
	{A,B,temp_c,low_output,temp_cin,high_output,cout,sum} = '0;
   case(PS)
		LOAD : begin  A = inp1[M-1:0]; B = inp2[M-1:0]; temp_c = 0; low_output = sum_a; temp_cin = cout_a; end
		SHIFT: begin   temp_c = temp_cin;A = inp1[N-1:M]; B = inp2[N-1:M]; high_output = sum_a;  end
		SUM_S : begin sum = {high_output,low_output};cout = cout_a; end
      endcase 
end 

endmodule


module adder #(parameter M = 32 )( input logic [M-1:0] A , B , input logic cin, output logic [M-1:0] sum , logic cout );
always_comb begin 
{cout,sum} = A + B + cin;
end 
endmodule
