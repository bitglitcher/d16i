module full_subtractor_x16
(
    input [15:0] a,
    input [15:0] b,
    input cin,
    output cout,
    output [15:0] z
);
wire cout_0, cout_1, cout_2, cout_3, cout_4, cout_5, cout_6, cout_7, cout_8, cout_9, cout_10, cout_11, cout_12, cout_13, cout_14;
full_subtractor full_subtractor_0(.a(a [0:0]),   .b(b [0:0]),   .cin(cin), .cout(cout_0), .z(z [0:0]));
full_subtractor full_subtractor_1(.a(a [1:1]),   .b(b [1:1]),   .cin(cout_0), .cout(cout_1), .z(z [1:1]));
full_subtractor full_subtractor_2(.a(a [2:2]),   .b(b [2:2]),   .cin(cout_1), .cout(cout_2), .z(z [2:2]));
full_subtractor full_subtractor_3(.a(a [3:3]),   .b(b [3:3]),   .cin(cout_2), .cout(cout_3), .z(z [3:3]));
full_subtractor full_subtractor_4(.a(a [4:4]),   .b(b [4:4]),   .cin(cout_3), .cout(cout_4), .z(z [4:4]));
full_subtractor full_subtractor_5(.a(a [5:5]),   .b(b [5:5]),   .cin(cout_4), .cout(cout_5), .z(z [5:5]));
full_subtractor full_subtractor_6(.a(a [6:6]),   .b(b [6:6]),   .cin(cout_5), .cout(cout_6), .z(z [6:6]));
full_subtractor full_subtractor_7(.a(a [7:7]),   .b(b [7:7]),   .cin(cout_6), .cout(cout_7), .z(z [7:7]));
full_subtractor full_subtractor_8(.a(a [8:8]),   .b(b [8:8]),   .cin(cout_7), .cout(cout_8), .z(z [8:8]));
full_subtractor full_subtractor_9(.a(a [9:9]),   .b(b [9:9]),   .cin(cout_8), .cout(cout_9), .z(z [9:9]));
full_subtractor full_subtractor_a(.a(a [10:10]), .b(b [10:10]), .cin(cout_9), .cout(cout_10), .z(z [10:10]));
full_subtractor full_subtractor_b(.a(a [11:11]), .b(b [11:11]), .cin(cout_10), .cout(cout_11), .z(z [11:11]));
full_subtractor full_subtractor_c(.a(a [12:12]), .b(b [12:12]), .cin(cout_11), .cout(cout_12), .z(z [12:12]));
full_subtractor full_subtractor_d(.a(a [13:13]), .b(b [13:13]), .cin(cout_12), .cout(cout_13), .z(z [13:13]));
full_subtractor full_subtractor_e(.a(a [14:14]), .b(b [14:14]), .cin(cout_13), .cout(cout_14), .z(z [14:14]));
full_subtractor full_subtractor_f(.a(a [15:15]), .b(b [15:15]), .cin(cout_14), .cout(cout), .z(z [15:15]));

endmodule 