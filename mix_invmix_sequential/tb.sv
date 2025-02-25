module tb;
  
  logic [7:0]A,B,C,D;
  logic control;
  logic [7:0]P,Q,R,S;
  bit clk,reset;
  
  
  sequential_mix_invmix DUT (.A(A), .P(P), .B(B), .C(C), .D(D), .Q(Q), .R(R), .S(S), .control(control), .clk(clk), .reset(reset));
  

always #5 clk = ~clk;
    
  
  initial
    begin
      #1;
      reset = '0;
      #15;
      reset = '1;
      
      @(negedge clk);
        control = '1;
        A = 8'h87;
        B = 8'h6E;
        C = 8'h46;
        D = 8'hA6;
     
      
      @(negedge clk);
       control = '0;
       A = 8'h47;
       B = 8'h37;
       C = 8'h94;
       D = 8'hED;
     
      
      #300 $stop;
      
      
    end
  
  initial
    begin
      $monitor("time: %0t inputs A:%h B:%h C:%h D:%h,control: %0b outputs P:%h Q:%h R:%h S:%h ", $time, A,B,C,D,control,P,Q,R,S);
    end
  
  
  /* #1;
      $display("Output of mix columns block:");
      $display("-----------------------------------------");
      $display("The input A = %h | output P = %h", A,P);
      $display("The input B = %h | output Q = %h", B,Q);
      $display("The input C = %h | output R = %h", C,R);
      $display("The input D = %h | output S = %h", D,S);
      $display("-----------------------------------------"); */
  
  
  /* #1;
      $display("Output of inverse mix columns block:");
      $display("-----------------------------------------");
      $display("The input A = %h | output P = %h", A,P);
      $display("The input B = %h | output Q = %h", B,Q);
      $display("The input C = %h | output R = %h", C,R);
      $display("The input D = %h | output S = %h", D,S);
      $display("-----------------------------------------"); */
  
  initial 
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
    end

  
  
  
endmodule