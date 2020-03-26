/*
Autor: Benjamin Herrera Navarro
Fecha: 2/9/2020
9:02 PM
Register file para la arquitectura D16i
*/

module regfile
(
    input clk,
    input rst,
    input sel,
    input sel_lo,
    input sel_hi,
    input sel_gs,
    input [2:0] a_op,
    input [2:0] b_op,
    input [2:0] c_op,
    input [2:0] d_op,
    input [2:0] s_op,
    input [2:0] e_op,
    input [15:0] c_bus,
    output [15:0] a_bus,
    output [15:0] b_bus,
    output [15:0] d_bus,
    output [15:0] s_bus,
    output [15:0] e_bus,
    input irq_sel,
    input [16:0] irq_bus
);

//registers
reg [7:0] GPR_HI [7:0];// = {8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0};
reg [7:0] GPR_LO [7:0];// = {8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0};
reg [7:0] SPR_HI [7:0];// = {8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0};
reg [7:0] SPR_LO [7:0];// = {8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0, 8'b0};

parameter SPR_RESET_VECTOR = 8'hff;

always@(negedge clk)
begin
    if(rst)
    begin
        GPR_HI [0] = 8'h0; GPR_LO [0] = 8'h0;
        GPR_HI [1] = 8'h0; GPR_LO [1] = 8'h0;
        GPR_HI [2] = 8'h0; GPR_LO [2] = 8'h0;
        GPR_HI [3] = 8'h0; GPR_LO [3] = 8'h0;
        GPR_HI [4] = 8'h0; GPR_LO [4] = 8'h0;
        GPR_HI [5] = 8'h0; GPR_LO [5] = 8'h0;
        GPR_HI [6] = 8'h0; GPR_LO [6] = 8'h0;
        GPR_HI [7] = 8'h0; GPR_LO [7] = 8'h0;
        SPR_HI [0] = SPR_RESET_VECTOR; SPR_LO [0] = SPR_RESET_VECTOR;
        SPR_HI [1] = 8'h0; SPR_LO [1] = 8'h0;
        SPR_HI [2] = 8'h0; SPR_LO [2] = 8'h0;
        SPR_HI [3] = 8'h0; SPR_LO [3] = 8'h0;
        SPR_HI [4] = 8'h0; SPR_LO [4] = 8'h0;
        SPR_HI [5] = 8'h0; SPR_LO [5] = 8'h0;
        SPR_HI [6] = 8'h0; SPR_LO [6] = 8'h0;
        SPR_HI [7] = 8'h0; SPR_LO [7] = 8'h0;
    end
    else 
    begin
        unique casex({sel, sel_hi, sel_lo})
            3'b1xx: //SEL
                begin
                    if(sel_gs)//Select SPR
                    begin
                        {SPR_HI [c_op], SPR_LO [c_op]} = c_bus;
                    end
                    else //Select GPR
                    begin
                        {GPR_HI [c_op], GPR_LO [c_op]} = c_bus;
                    end
                end
            3'b01x: //SEL HI
                begin
                    if(sel_gs)//Select SPR
                    begin
                        SPR_HI [c_op] = c_bus [7:0];
                    end
                    else //Select GPR
                    begin
                        GPR_HI [c_op] = c_bus [7:0];
                    end
                end
            3'b0x1: //SEL LO
                begin
                    if(sel_gs)//Select SPR
                    begin
                        SPR_LO [c_op] = c_bus [7:0];
                    end
                    else //Select GPR
                    begin
                        GPR_LO [c_op] = c_bus [7:0];
                    end
                end
        endcase

        //IRQ ID STUFF
        if(irq_sel)
        begin
            SPR_HI [2] = irq_bus [15:8];
            SPR_LO [2] = irq_bus [7:0];
        end
    end
end

//Output buses
assign a_bus = {GPR_HI [a_op], GPR_LO [a_op]};
assign b_bus = {GPR_HI [b_op], GPR_LO [b_op]};
assign d_bus = {GPR_HI [d_op], GPR_LO [d_op]};
assign s_bus = {SPR_HI [s_op], SPR_LO [s_op]};
assign e_bus = {SPR_HI [e_op], SPR_LO [e_op]};

endmodule
