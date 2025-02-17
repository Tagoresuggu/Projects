// Code your testbench here
// or browse Examples
module test_bench_mixed_column_block;
    
  logic [3:0][3:0][7:0] input2mixedcolumn;
  logic [3:0][3:0][7:0] rotate_matrix;
  logic [3:0][3:0][7:0] outputmixedcolumn;
    
    mixed_column_block uut (
        .input2mixedcolumn(input2mixedcolumn),
        .rotate_matrix(rotate_matrix),
        .outputmixedcolumn(outputmixedcolumn)
    );
    
    initial begin
      $display("Testing mixed cloumn");
      
      /*input matrix:
          _              _
         |   87 F2 4D 97  |
         |   6E 4C 90 EC  |
         |   46 E7 4A C3  |
         |_  A6 8C D8 95 _|
         
         
        */ 
        
      input2mixedcolumn = '{'{8'h95, 8'hD8, 8'h8C, 8'hA6},
                          '{8'hC3, 8'h4A, 8'hE7, 8'h46},
                          '{8'hEC, 8'h90, 8'h4C, 8'h6E},
                          '{8'h97, 8'h4D, 8'hF2, 8'h87}};
      
      /*rotate matrix:
          _              _
         |   02 03 01 01  |
         |   01 02 03 01  |
         |   01 01 02 03  |
         |_  03 01 01 02 _|
         
         
        */ 
        
      rotate_matrix  = '{'{8'h02, 8'h01, 8'h01, 8'h03},
                       '{8'h03, 8'h02, 8'h01, 8'h01},
                       '{8'h01, 8'h03, 8'h02, 8'h01},
                       '{8'h01, 8'h01, 8'h03, 8'h02}};
        
        #10;
        
    
        for (int i = 0; i < 4; i++) begin
            for (int j = 0; j < 4; j++) begin
                $display("outputmixedcolumn[%0d][%0d] = %h", i, j, outputmixedcolumn[i][j]);
                 
            end
        end
      $display("-------------------------------------------");
      
      

        
        $finish;
    end
endmodule