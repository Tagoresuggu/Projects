module mixed_column_block (
    input  logic [3:0][3:0][7:0] input2mixedcolumn,
    input  logic [3:0][3:0][7:0] rotate_matrix,
    output logic [3:0][3:0][7:0] outputmixedcolumn
);
    logic [7:0] temp[3:0][3:0][3:0];

    genvar i, j, k;
    generate
         for (i = 0; i < 4; i++) begin         
            for (j = 0; j < 4; j++) begin 
                for (k = 0; k < 4; k++) begin 
                    gf2m_multiplier mult_inst (
                        .a(input2mixedcolumn[k][j]),
                        .b(rotate_matrix[i][k]),
                        .product(temp[i][j][k])
                    );
                end
            end
        end
    endgenerate

   
    always_comb begin
        for (int i = 0; i < 4; i++) begin
            for (int j = 0; j < 4; j++) begin
                outputmixedcolumn[i][j] = 8'b0; 
                for (int k = 0; k < 4; k++) begin
                  outputmixedcolumn[i][j] = outputmixedcolumn[i][j]^temp[i][j][k];
                end
            end
        end
    end

endmodule

module gf2m_multiplier (
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] product
);
    logic [15:0] temp;
    logic [7:0] irreducible_poly = 8'b10001_1011;
    
    always_comb begin
        case (b)
            8'h01: product = a;
            8'h02: begin
                      temp = a << 1;
                      product = (temp[15:8]) ? temp[7:0] ^ irreducible_poly : temp[7:0];
                   end
            8'h03: begin
                      temp = a << 1;
                      if(temp[15:8]) temp = a ^ (temp[7:0] ^ irreducible_poly);
                      else temp = temp[7:0] ^ a;
                      product = temp[7:0];
                  end
            default: product = 8'h00;
        endcase
    end
endmodule
