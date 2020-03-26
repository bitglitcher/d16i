module regfile_test_bench();

reg clk;
reg rst;
reg sel;
reg sel_lo;
reg sel_hi;
reg sel_gs;
reg  [2:0] a_op;
reg  [2:0] b_op;
reg  [2:0] c_op;
reg  [2:0] d_op;
reg  [2:0] s_op;
reg [15:0] c_bus;
wire [15:0] a_bus;
wire [15:0] b_bus;
wire [15:0] d_bus;
wire [15:0] s_bus;

regfile regile_0
(
    .clk(clk),
    .rst(rst),
    .sel(sel),
    .sel_lo(sel_lo),
    .sel_hi(sel_hi),
    .sel_gs(sel_gs),
    .a_op(a_op),
    .b_op(b_op),
    .c_op(c_op),
    .d_op(d_op),
    .s_op(s_op),
    .c_bus(c_bus),
    .a_bus(a_bus),
    .b_bus(b_bus),
    .d_bus(d_bus),
    .s_bus(s_bus)
);

initial 
begin
	$monitor("ckl=%b, rst=%b, sel=%b, sel_lo=%b, sel_hi=%b, sel_gs=%b, a_bus=%b", clk, rst, sel, sel_lo, sel_hi, sel_gs, a_bus); 
    clk = 1'b0;
    rst = 1'b1;
    sel = 1'b0;
    sel_lo = 1'b0;
    sel_hi = 1'b0;
    sel_gs = 1'b0;
    a_op = 3'b0;
    b_op = 3'b0;
    c_op = 3'b0;
    d_op = 3'b0;
    s_op = 3'b0;
    c_bus = 16'b0;
	#10
	clk = 1'b1;
	rst = 1'b1;
    sel = 1'b1;
    #10
	clk = 1'b0;
    #10
    rst = 1'b0;
	repeat(256) #10 clk = ~clk;
    //Load something on an GPR
end

parameter MAX_NREGS = 15; //8 lo and 8 hi - 1
always@(posedge clk)
begin
    c_bus = c_bus + 1;
    c_op = c_op + 1;
    a_op = a_op + 1;
    if(c_op == MAX_NREGS) sel_gs = 1'b1;
end




endmodule 