/*
Autor: Benjamin Herrera Navarro
3/24/2020 2:25PM Module Prescaler para la arquitectura D16i
*/


module prescaler
(
    input clk,
    input clk_en,
    input rst,
    input [3:0] div,
    output logic clk_out
);

reg [31:0] count;

always@(posedge clk)
begin
    if(rst)
    begin
        count = 32'b0;
    end else if(clk_en)
    begin
        count = count + 1;
    end
end

always_comb
begin
    unique case(div)
        4'h00: clk_out = count [4'h00:4'h00];
        4'h01: clk_out = count [4'h01:4'h01];
        4'h02: clk_out = count [4'h02:4'h02];
        4'h03: clk_out = count [4'h03:4'h03];
        4'h04: clk_out = count [4'h04:4'h04];
        4'h05: clk_out = count [4'h05:4'h05];
        4'h06: clk_out = count [4'h06:4'h06];
        4'h07: clk_out = count [4'h07:4'h07];
        4'h08: clk_out = count [4'h08:4'h08];
        4'h09: clk_out = count [4'h09:4'h09];
        4'h0a: clk_out = count [4'h0a:4'h0a];
        4'h0b: clk_out = count [4'h0b:4'h0b];
        4'h0c: clk_out = count [4'h0c:4'h0c];
        4'h0d: clk_out = count [4'h0d:4'h0d];
        4'h0e: clk_out = count [4'h0e:4'h0e];
        4'h0f: clk_out = count [4'h0f:4'h0f];
        4'h10: clk_out = count [4'h10:4'h10];
        4'h11: clk_out = count [4'h11:4'h11];
        4'h12: clk_out = count [4'h12:4'h12];
        4'h13: clk_out = count [4'h13:4'h13];
        4'h14: clk_out = count [4'h14:4'h14];
        4'h15: clk_out = count [4'h15:4'h15];
        4'h16: clk_out = count [4'h16:4'h16];
        4'h17: clk_out = count [4'h17:4'h17];
        4'h18: clk_out = count [4'h18:4'h18];
        4'h19: clk_out = count [4'h19:4'h19];
        4'h1a: clk_out = count [4'h1a:4'h1a];
        4'h1b: clk_out = count [4'h1b:4'h1b];
        4'h1c: clk_out = count [4'h1c:4'h1c];
        4'h1d: clk_out = count [4'h1d:4'h1d];
        4'h1e: clk_out = count [4'h1e:4'h1e];
        4'h1f: clk_out = count [4'h1f:4'h1f];
    endcase
end

endmodule