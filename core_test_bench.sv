

`timescale 1 ns / 1 ps

module core_test_bench();


reg clk;
logic [15:0] din;
wire [15:0] dout;
wire wr;
reg rst;
wire [15:0] addr;
reg irq;
reg [7:0] irq_id;
//Simulated RAM
reg [15:0] memory [0:16'hffff];

core core_0
(
.clk(clk), 
.din(din),
.rst(rst),
.irq(irq),
.irq_id(irq_id),
.dout(dout),
.wr(wr),
.addr(addr)
);
initial 
begin
	$readmemb("rom.mem", memory);
	$monitor("ckl=%b, rst=%b, din=%b, addr=%b", clk, rst, din, addr); 
	irq = 1'b0;
	irq_id = 8'b0;
    clk = 1'b0;
    rst = 1'b1;
	#10
	clk = 1'b1;
	rst = 1'b1;
    #10
	clk = 1'b0;
	rst = 1'b1;
    #10
    rst = 1'b0;
	clk = 1;
	//repeat(256) #10 clk = ~clk;	
	//repeat(60) #10 clk = ~clk;	
	//IRQ test
	irq = 1'b0;
	repeat(22) #10 clk = ~clk;	
	irq = 1'b1;
	repeat(40) #10 clk = ~clk;	
end

//RAM
always@(negedge clk)
begin
	if(wr)
	begin
		memory [addr] = dout;
	end
end

always_comb
begin
	case(addr)
		16'b0: din =  16'b0000000100100100;
		16'h104: din = 16'b0000000000010100;
	default: din = 16'b0;
	endcase
end
//assign din = 16'b0;//memory [addr];

endmodule 