module tb;
parameter N = 64;

bit clk , rst;
reg signed [N-1:0] inp1, inp2;
wire signed [N-1:0] sum ; wire cout;
wire signed [N-1:0] sumk ; wire coutk;

adder_64bit #(N)dut(.*);


always 
#5 clk = ~clk;

int i,j;

initial begin
rst = 1;
#7 rst = 0;
#2 rst = 1;


repeat(3)
@(negedge clk);
inp1 = 64'h0000_0000_0000_000f; inp2 = 64'hffff_ffff_ffff_fffc;  // sum = 11 cout = 0 

repeat(3)
@(negedge clk);
inp1 = 64'hffff_ffff_ffff_fff6; inp2 = 64'h0000_0000_0000_0002; // sum = -3 cout = 0 

repeat(3)
@(negedge clk);
inp1 = 64'h8000_0000_0000_0000; inp2 = 64'h8000_0000_0000_0000; // s = 0 cout = 1  overflow

repeat(3)
@(negedge clk);
inp1 = 64'h7fff_ffff_ffff_ffff; inp2 = 64'h7fff_ffff_ffff_ffff; // s = -2 cout = 0  underflow
                                               
repeat(3)
@(negedge clk);
inp1 = 64'h8000_0000_0000_0000; inp2 = 64'h8000_0000_0000_0000; // s = 0 cout = 1  	

repeat(3)
@(negedge clk);
inp1 = 64'h0000_0000_0000_0000; inp2 = 64'h8000_0000_0000_0000; // s = 0 cout = 1  

repeat(3)
@(negedge clk);
inp1 = 64'h1234_5678_9abc_def0; inp2 = 64'h0efd_cba9_8765_4321; // s = 0 cout = 1  

repeat(3)
@(negedge clk);
inp1 = 64'h7fff_ffff_ffff_ffff; inp2 = 64'h7fff_ffff_ffff_ffff; // s = 0 cout = 1  									

#50 $stop;
end


endmodule

