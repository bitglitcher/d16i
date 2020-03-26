
/*
Autor: Benjamin Herrera Navarro
Creado el dia 3/10/2020
Full Subtractor para la arquitectura D16i
*/

module full_subtractor
(
    input a,
    input b,
    input cin,
    output cout,
    output z
);

wire p;
wire r;
wire s;

xor(p, a, b);
xor(z, a, cin);
and(r, ~p, cin);
and(s, ~a, b);
or(cout, r, s);

endmodule