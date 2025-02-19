module MemoryIO( Intel8088Pins.Peripheral bus ,input cs);

parameter msizelow,msizehigh;
parameter Active = 0;
parameter choosing= 2'b00;

typedef enum logic[4:0] {T1=5'b00001, T2=5'b00010, T3R=5'b00100, T3W=5'b01000, T4=5'b10000} State;
State PS,NS; 

logic oe,writetodata;
logic Load_address;
logic [19:0]address;

reg [7:0]mem[msizelow:msizehigh];                                //MEMORY REGISTER


assign bus.Data = (Active && oe && cs )?mem[address]: 'z;        //ASSIGNING DATA THE VALUE INSIDE MEM[ADDRESS]

always_ff@(posedge bus.CLK)
 begin
 if(cs & writetodata) mem[address]  <= bus.Data;                // WRITTING DATA ON TO MEM[ADDRESS]
 end


initial
begin
unique0 case(choosing)
    0 :$readmemh("random_data_mem1.txt",mem);                   //INITIALISES RANDOM DATA INTO MEM REGISTER CORRESPONDING TO MEM1
    1: $readmemh("random_data_mem2.txt",mem);                   //INITIALISES RANDOM DATA INTO MEM REGISTER CORRESPONDING TO MEM2
    2: $readmemh("random_data_IO1.txt",mem);                    //INITIALISES RANDOM DATA INTO MEM REGISTER CORRESPONDING TO IO1
    3: $readmemh("random_data_IO2.txt",mem);                    //INITIALISES RANDOM DATA INTO MEM REGISTER CORRESPONDING TO IO2
	endcase
end

/*-----------------------------------------------------------INTERNAL ADDRESS REGISTER TO LAOD ADDRESS-----------------------------------*/
always_ff@(posedge bus.CLK)
begin
if(Load_address & ~bus.IOM) address <= bus.Address;
else if(Load_address & bus.IOM) address<= bus.Address[15:0];
else address <= 'z;
end 

/*---------------------------------------------------------------FSM-----------------------------------------------*/


always_ff@(posedge bus.CLK)
 begin
  if(bus.RESET) PS <= T1;
  else      PS <= NS;
 end

//next state combinational logic

always_comb                                    
 begin
	 NS = PS;
	unique0 case(PS)
      T1:  if(Active && cs && bus.ALE )  NS = T2;
	  
      T2: begin
		   if (bus.RD == 0)  NS = T3R; 
		   else if(bus.WR == 0)  NS = T3W;       
	      end
		  
      T3R: NS = T4; 
	 
	  T3W: NS = T4; 
	 
	  T4:  NS = T1;
    endcase   
 end

//output combinational logic

always_comb
 begin
 {writetodata,oe,Load_address} = '0;
 unique0 case(PS)
  T1:  begin  end
  T2:  begin  Load_address = '1; end
  T3R: begin  oe='1; end
  T3W: begin  writetodata = '1; end
  T4 : begin   end

 endcase

 end 
 
endmodule