module alu
(
    input [15:0] a,
    input [15:0] b,
    output reg [15:0] z,
    input [3:0] op,
    input cin,
    output cout
);

//ALU Instructions (OPs)
parameter iADD = 4'h0;
parameter iSUB = 4'h1;
parameter iADDCO = 4'h2; //Carry out
parameter iSUBCO = 4'h3;
parameter iADDCI = 4'h4; //Carry In
parameter iSUBCI = 4'h5;
parameter iADDCOCI = 4'h6; //Carry out Carry in
parameter iSUBCOCI = 4'h7;
parameter iAND = 4'h8;
parameter iXOR = 4'h9;
parameter iOR = 4'ha;
parameter iNOT = 4'hb;
parameter iSHFTL = 4'hc;
parameter iSHFTR = 4'hd;

wire [15:0] adder_bus;
assign adder_cin_en = ((op == iADDCI) | (op == iADDCOCI)) ? 1 : 0;
assign adder_cout_en = ((op == iADDCO) | (op == iADDCOCI)) ? 1 : 0;
wire adder_cout_s; //Signal from the adder
full_adder_x16 adder_0
(
    .a(a),
    .b(b),
    .cin(cin & adder_cin_en),
    .cout(adder_cout_s),
    .z(adder_bus)
);
assign adder_cout = (adder_cout_s & adder_cout_en);


wire [15:0] sub_bus;
assign subtractor_cin_en = ((op == iSUBCI) | (op == iSUBCOCI)) ? 1 : 0;
assign subtractor_cout_en = ((op == iSUBCO) | (op == iSUBCOCI)) ? 1 : 0;
wire sub_cout_s;
full_subtractor_x16 subtractor_0
(
    .a(a),
    .b(b),
    .cin(cin & subtractor_cin_en),
    .cout(sub_cout_s),
    .z(sub_bus)
);
assign sub_cout = (sub_cout_s & subtractor_cout_en);


assign cout = (sub_cout | adder_cout);

always_comb
begin
    unique case(op)
        iADD: z = adder_bus;
        iSUB: z = sub_bus;
        iADDCO: z = adder_bus; //Carry out
        iSUBCO: z = sub_bus;
        iADDCI: z = adder_bus;
        iSUBCI: z = sub_bus;
        iADDCOCI: z = adder_bus;
        iSUBCOCI: z = sub_bus;
        iAND: z = a & b;
        iXOR: z = a ^ b;
        iOR: z = a | b;
        iNOT: z = ~a;
        iSHFTL: z = a << b;
        iSHFTR: z = a >> b;
        default: z = 16'b0;
    endcase    
end



endmodule