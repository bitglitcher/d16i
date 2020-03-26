module full_adder_x16_test_bench();



reg [15:0] a;
reg [15:0] b;
reg cin;
wire cout;
wire [15:0] z;

full_adder_x16 adder_0
(
    .a(a),
    .b(b),
    .cin(cin),
    .cout(cout),
    .z(z)
);

initial begin
    $monitor("a=%b, b=%b, z=%b, cin=%b, cout=%b", a, b, z, cin, cout);
    a = 16'b0;
    b = 16'b0;
    cin = 16'b0;
    #10
    //Test carry out
    a = 16'hffff;
    b = 16'h1;
    #10
    //Test carry in
    a = 16'h0f;
    b = 16'hf0;
    cin = 1'b1;
    //#10
end


endmodule