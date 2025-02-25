/* The Control signal chooses between mix columns and inverse columns output. if control = '1 mix column block"s output is choosen else if control is '1 it chooses output of inverse mic column block. 
*/


module mixColumns_InvmixColumns (

  input [7:0]A,B,C,D,
  input logic control,
  output [7:0]P,Q,R,S
  
);
  
  
  column_1 mulby2311(.A(A),.B(B), .C(C), .D(D), .P(P), .control(control));
  column_2 mulby1231(.A(A),.B(B), .C(C), .D(D), .Q(Q), .control(control));
  column_3 mulby1123(.A(A),.B(B), .C(C), .D(D), .R(R), .control(control));
  column_4 mulby3112(.A(A),.B(B), .C(C), .D(D), .S(S), .control(control));
  
  
 
endmodule

//-------------------------Column 1--------------------------------------------------
module column_1(input logic [7:0]A,B,C,D, input logic control, output logic [7:0]P);
  logic [7:0]temp_P1,temp_P2,temp1,temp2,temp3,temp4;
  
  
  
  assign temp_P1 = {A[6],A[5],A[4],(A[3]^A[7]),(A[2]^A[7]),A[1],(A[0]^A[7]),A[7]}; // A$02
  
  
  assign temp_P2 = {(B[6]^B[7]),           //P7
                    (B[5]^B[6]), 
                    (B[4]^B[5]), 
                    (B[3]^B[7]^B[4]), 
                    (B[2]^B[7]^B[3]), 
                    (B[1]^B[2]),
                    (B[0]^B[7]^B[1]),
                    (B[7]^B[0]) };          //P0          //B$03

//--------------------------inverse mixcolumn----------------------------

 assign temp1 =  {(A[6]^A[5]^A[4]),      // P7
                  (A[3]^A[4]^A[5]^A[7]),
                  (A[2]^A[3]^A[4]^A[6]),
                  (A[1]^A[2]^A[3]^A[5]),
                  (A[0]^A[1]^A[2]^A[5]^A[6]),
                  (A[0]^A[1]^A[6]),
                  (A[0]^A[5]),
                  (A[5]^A[6]^A[7]) };    //P0       // A$0e
  
  
  assign temp2 = {(B[4]^B[6]^B[7]),                 // P7
                  (B[3]^B[5]^B[6]^B[7]),
                  (B[2]^B[4]^B[5]^B[6]^B[7]),
                  (B[1]^B[3]^B[4]^B[5]^B[6]^B[7]),
                  (B[0]^B[2]^B[3]^B[5]),
                  (B[1]^B[2]^B[6]^B[7]),
                  (B[0]^B[1]^B[5]^B[6]^B[7]),
                  (B[0]^B[5]^B[7]) };               //P0       // B$0b
  
  
  
  assign temp3 = {(C[4]^C[5]^C[7]),                  // P7
                  (C[3]^C[4]^C[6]^C[7]),
                  (C[2]^C[3]^C[5]^C[6]),
                  (C[1]^C[2]^C[4]^C[5]^C[7]),
                  (C[0]^C[1]^C[3]^C[5]^C[6]^C[7]),
                  (C[0]^C[2]^C[6]),
                  (C[1]^C[5]^C[7]),
                  (C[0]^C[5]^C[6]) };                //P0       // C$0d

  
  
  assign temp4 = {(D[4]^D[7]),                          // P7
                  (D[3]^D[6]^D[7]),
                  (D[2]^D[5]^D[6]^D[7]),
                  (D[1]^D[4]^D[5]^D[6]),
                  (D[0]^D[3]^D[5]^D[7]),
                  (D[2]^D[6]^D[7]),
                  (D[1]^D[5]^D[6]),
                  (D[0]^D[5]) };                       //P0       // D$09
   
  
  //-----------selection between mix column and inverse mix column
  assign P = control?(C^temp_P2^temp_P1^D):(temp1^temp2^temp3^temp4); 
   
endmodule

//-------------------------Column 2--------------------------------------------------
module column_2(input logic [7:0]A,B,C,D, input logic control, output logic [7:0]Q);
  logic [7:0]temp_P1,temp_P2,temp1,temp2,temp3,temp4;
  
  
 
  assign temp_P1 = {B[6],B[5],B[4],(B[3]^B[7]),(B[2]^B[7]),B[1],(B[0]^B[7]),B[7]}; // B$02
  
  
  assign temp_P2 = {(C[6]^C[7]),                       //P7
                    (C[5]^C[6]), 
                    (C[4]^C[5]), 
                    (C[3]^C[7]^C[4]), 
                    (C[2]^C[7]^C[3]), 
                    (C[1]^C[2]),
                    (C[0]^C[7]^C[1]),
                    (C[7]^C[0]) };                     //P0          //C$03
  
//--------------------------inverse mixcolumn----------------------------
  
  assign temp1 = {(B[6]^B[5]^B[4]),                    // P7
                  (B[3]^B[4]^B[5]^B[7]),
                  (B[2]^B[3]^B[4]^B[6]),
                  (B[1]^B[2]^B[3]^B[5]),
                  (B[0]^B[1]^B[2]^B[5]^B[6]),
                  (B[0]^B[1]^B[6]),
                  (B[0]^B[5]),
                  (B[5]^B[6]^B[7]) };                  //P0       // B$0e
  
  
  assign temp2 = {(C[4]^C[6]^C[7]),                     // P7
                  (C[3]^C[5]^C[6]^C[7]),
                  (C[2]^C[4]^C[5]^C[6]^C[7]),
                  (C[1]^C[3]^C[4]^C[5]^C[6]^C[7]),
                  (C[0]^C[2]^C[3]^C[5]),
                  (C[1]^C[2]^C[6]^C[7]),
                  (C[0]^C[1]^C[5]^C[6]^C[7]),
                  (C[0]^C[5]^C[7]) };                    //P0       // C$0b
  
  
  
  assign temp3 = {(D[4]^D[5]^D[7]),                       // P7
                  (D[3]^D[4]^D[6]^D[7]),
                  (D[2]^D[3]^D[5]^D[6]),
                  (D[1]^D[2]^D[4]^D[5]^D[7]),
                  (D[0]^D[1]^D[3]^D[5]^D[6]^D[7]),
                  (D[0]^D[2]^D[6]),
                  (D[1]^D[5]^D[7]),
                  (D[0]^D[5]^D[6]) };                    //P0       // D$0d

  
  
  assign temp4 = {(A[4]^A[7]),                             // P7
                  (A[3]^A[6]^A[7]),
                  (A[2]^A[5]^A[6]^A[7]),
                  (A[1]^A[4]^A[5]^A[6]),
                  (A[0]^A[3]^A[5]^A[7]),
                  (A[2]^A[6]^A[7]),
                  (A[1]^A[5]^A[6]),
                  (A[0]^A[5]) };                            //P0       // A$09

  
  
  
  //-----------selection between mix column and inverse mix column
  assign Q = control?(A^temp_P2^temp_P1^D):(temp1^temp2^temp3^temp4); 
endmodule

//-------------------------Column 3--------------------------------------------------
module column_3(input logic [7:0]A,B,C,D, input logic control,output logic [7:0]R);
  logic [7:0]temp_P1,temp_P2,temp1,temp2,temp3,temp4;
  
  
  
  assign temp_P1 = {C[6],C[5],C[4],(C[3]^C[7]),(C[2]^C[7]),C[1],(C[0]^C[7]),C[7]}; // C$02
  
  
  assign temp_P2 = {(D[6]^D[7]),           //P7
                    (D[5]^D[6]), 
                    (D[4]^D[5]), 
                    (D[3]^D[7]^D[4]), 
                    (D[2]^D[7]^D[3]), 
                    (D[1]^D[2]),
                    (D[0]^D[7]^D[1]),
                    (D[7]^D[0]) };          //P0          //D$03
  
 //--------------------------inverse mixcolumn----------------------------
 
  
  assign temp1 = {(C[6]^C[5]^C[4]),             // P7
                  (C[3]^C[4]^C[5]^C[7]),
                  (C[2]^C[3]^C[4]^C[6]),
                  (C[1]^C[2]^C[3]^C[5]),
                  (C[0]^C[1]^C[2]^C[5]^C[6]),
                  (C[0]^C[1]^C[6]),
                  (C[0]^C[5]),
                  (C[5]^C[6]^C[7]) };          //P0       // C$0e  

  
  
  assign temp2 = {(D[4]^D[6]^D[7]),                 // P7
                  (D[3]^D[5]^D[6]^D[7]),
                  (D[2]^D[4]^D[5]^D[6]^D[7]),
                  (D[1]^D[3]^D[4]^D[5]^D[6]^D[7]),
                  (D[0]^D[2]^D[3]^D[5]),
                  (D[1]^D[2]^D[6]^D[7]),
                  (D[0]^D[1]^D[5]^D[6]^D[7]),
                  (D[0]^D[5]^D[7]) };               //P0       // D$0b 

   
  assign temp3 = {(A[4]^A[5]^A[7]),                  // P7
                  (A[3]^A[4]^A[6]^A[7]),
                  (A[2]^A[3]^A[5]^A[6]),
                  (A[1]^A[2]^A[4]^A[5]^A[7]),
                  (A[0]^A[1]^A[3]^A[5]^A[6]^A[7]),
                  (A[0]^A[2]^A[6]),
                  (A[1]^A[5]^A[7]),
                  (A[0]^A[5]^A[6]) };                //P0       // A$0d 

  
  
  assign temp4 = {(B[4]^B[7]),                          // P7
                  (B[3]^B[6]^B[7]),
                  (B[2]^B[5]^B[6]^B[7]),
                  (B[1]^B[4]^B[5]^B[6]),
                  (B[0]^B[3]^B[5]^B[7]),
                  (B[2]^B[6]^B[7]),
                  (B[1]^B[5]^B[6]),
                  (B[0]^B[5]) };                   //P0.      //B$09
  
  

  
  
 //-----------selection between mix column and inverse mix column 
  assign R = control?(A^temp_P2^temp_P1^B):(temp1^temp2^temp3^temp4); 
   
endmodule

//-------------------------Column 4--------------------------------------------------
module column_4(input logic [7:0]A,B,C,D, input logic control, output logic [7:0]S);
  logic [7:0]temp_P1,temp_P2,temp1,temp2,temp3,temp4;
  
  
  
  assign temp_P1 = {D[6],D[5],D[4],(D[3]^D[7]),(D[2]^D[7]),D[1],(D[0]^D[7]),D[7]}; // D$02
  
  
  assign temp_P2 = {(A[6]^A[7]),           //P7
                    (A[5]^A[6]), 
                    (A[4]^A[5]), 
                    (A[3]^A[7]^A[4]), 
                    (A[2]^A[7]^A[3]), 
                    (A[1]^A[2]),
                    (A[0]^A[7]^A[1]),
                    (A[7]^A[0]) };          //P0          //A$03
  
 //--------------------------inverse mixcolumn----------------------------
 
  assign temp1 = {(D[6]^D[5]^D[4]),      // P7
                  (D[3]^D[4]^D[5]^D[7]),
                  (D[2]^D[3]^D[4]^D[6]),
                  (D[1]^D[2]^D[3]^D[5]),
                  (D[0]^D[1]^D[2]^D[5]^D[6]),
                  (D[0]^D[1]^D[6]),
                  (D[0]^D[5]),
                  (D[5]^D[6]^D[7]) };        //P0       // D$0e

  
  assign temp2 = {(A[4]^A[6]^A[7]),                 // P7
                  (A[3]^A[5]^A[6]^A[7]),
                  (A[2]^A[4]^A[5]^A[6]^A[7]),
                  (A[1]^A[3]^A[4]^A[5]^A[6]^A[7]),
                  (A[0]^A[2]^A[3]^A[5]),
                  (A[1]^A[2]^A[6]^A[7]),
                  (A[0]^A[1]^A[5]^A[6]^A[7]),
                  (A[0]^A[5]^A[7]) };               //P0       // A$0b

  
  
  assign temp3 = {(B[4]^B[5]^B[7]),                  // P7
                  (B[3]^B[4]^B[6]^B[7]),
                  (B[2]^B[3]^B[5]^B[6]),
                  (B[1]^B[2]^B[4]^B[5]^B[7]),
                  (B[0]^B[1]^B[3]^B[5]^B[6]^B[7]),
                  (B[0]^B[2]^B[6]),
                  (B[1]^B[5]^B[7]),
                  (B[0]^B[5]^B[6]) };                //P0       // B$0d       

  
  
  assign temp4 = {(C[4]^C[7]),                          // P7
                  (C[3]^C[6]^C[7]),
                  (C[2]^C[5]^C[6]^C[7]),
                  (C[1]^C[4]^C[5]^C[6]),
                  (C[0]^C[3]^C[5]^C[7]),
                  (C[2]^C[6]^C[7]),
                  (C[1]^C[5]^C[6]),
                  (C[0]^C[5]) };               //P0       // C$09 

  
  
  
  
 //-----------selection between mix column and inverse mix column 
  assign S = control?(B^temp_P2^temp_P1^C):(temp1^temp2^temp3^temp4); 
   
endmodule
//----------------------------------------end------------------------------------------------



 