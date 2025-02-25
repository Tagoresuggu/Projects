
module mixColumns_InvmixColumns_tb;
  
  logic [7:0]A,B,C,D;
  logic control;
  logic [7:0]P,Q,R,S;
  
  
  mixColumns_InvmixColumns DUT (.A(A), .P(P), .B(B), .C(C), .D(D), .Q(Q), .R(R), .S(S), .control(control));
  
  initial
    begin
      #1;
      control = '1;
      A = 8'h87;
      B = 8'h6E;
      C = 8'h46;
      D = 8'hA6;
      #1;
      $display("Output of mix columns block:");
      $display("-----------------------------------------");
      $display("The input A = %h | output P = %h", A,P);
      $display("The input B = %h | output Q = %h", B,Q);
      $display("The input C = %h | output R = %h", C,R);
      $display("The input D = %h | output S = %h", D,S);
      $display("-----------------------------------------");
      
       #1;
      control = '0;
      A = 8'h47;
      B = 8'h37;
      C = 8'h94;
      D = 8'hED;
      #1;
      $display("Output of inverse mix columns block:");
      $display("-----------------------------------------");
      $display("The input A = %h | output P = %h", A,P);
      $display("The input B = %h | output Q = %h", B,Q);
      $display("The input C = %h | output R = %h", C,R);
      $display("The input D = %h | output S = %h", D,S);
      $display("-----------------------------------------");
      
      
    end
  
  
  
endmodule