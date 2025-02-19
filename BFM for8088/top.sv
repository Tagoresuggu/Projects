module top;

bit CLK ;
bit RESET; 
logic [3:0]cs;                                                        //CHIP SELECT



Intel8088Pins bus(.CLK(CLK), .RESET(RESET));                         //INTERFACE

Intel8088 P(bus.Processor);   


parameter Active =0;                                               // USED RO SELECT THE MODULE IF ACTIVE = 1 MODULE IS SELECTED. IF ACTIVE =0 THAT MODULE IS DISABLED
parameter choosing= 2'b00;                                        //USED TO SELECT TEXT FILE

assign  cs[0] = ( bus.IOM && bus.Address[15])?1'b1:1'b0;         // referring to iom1
assign  cs[1] = ( bus.IOM && ~bus.Address[15])? 1'b1:1'b0;      //reffering TO iom2
assign  cs[2] = ( ~bus.IOM && ~ bus.Address[19])? 1'b1:1'b0;   //refering to mem1
assign  cs[3] = ( ~ bus.IOM && bus.Address[19])? 1'b1:1'b0;   //refering to mem2



MemoryIO  #(.Active(1), .msizelow(20'h0),   .msizehigh(20'h7ffff), .choosing(2'b00))  M1(.bus(bus.Peripheral),  .cs(cs[2]));  //mem1
MemoryIO  #(.Active(1),.msizelow(20'h80000),.msizehigh(20'hfffff), .choosing(2'b01))M2(.bus(bus.Peripheral),  .cs(cs[3]));    //mem2
MemoryIO  #(.Active(1),.msizelow(16'hFF00), .msizehigh(16'hFF0F),  .choosing(2'b10)) IOM1(.bus(bus.Peripheral), .cs(cs[0])); // IO1
MemoryIO  #(.Active(1),.msizelow(16'h1C00), .msizehigh(16'h1DFF),  .choosing(2'b11)) IOM2(.bus(bus.Peripheral),  .cs(cs[1])); //IO2

// 8282 Latch to latch bus address
always_latch
begin
if (bus.ALE)
	bus.Address <= {bus.A, bus.AD};
end

// 8286 transceiver
assign bus.Data =  (bus.DTR & ~bus.DEN) ? bus.AD   : 'z;
assign bus.AD   = (~bus.DTR & ~bus.DEN) ? bus.Data : 'z;


always #50 CLK = ~CLK;

initial
begin
$dumpfile("dump.vcd"); $dumpvars;

repeat (2) @(posedge CLK);
RESET = '1;
repeat (5) @(posedge CLK);
RESET = '0;

repeat(10000) @(posedge CLK);
$finish();
end

endmodule

