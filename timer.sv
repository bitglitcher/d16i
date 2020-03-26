/*
3/24/2020 2:12PM Timer para la arquitectura D16i

Address Mapped registers

0x00 Prescaler
0x01 Count
0x02 IRQ_EN
0x03 TMR_EN
0x04 IRQ_REG

*/

module timer
(
    input clk,
    input rst,
    input [15:0] din,
    input [15:0] addr,
    input we,
    output logic irq,
    output [15:0] dout
);
parameter Prescaler = 4'h0;
parameter Count = 4'h1;
parameter IRQ_EN = 4'h2;
parameter TMR_EN = 4'h3;
parameter IRQ = 4'h4;

reg [15:0] REGS [4:0];

always@(negedge clk)
begin
    if(rst)
    begin
        REGS [Prescaler] = 16'b0;
        REGS [Count] = 16'b0;
        REGS [IRQ_EN] = 16'b0;
        REGS [TMR_EN] = 16'b0;
        REGS [IRQ] = 16'b0;
    end else if(we)
    begin
        REGS [addr] = din;        
    end
end

assign dout = REGS [addr];

//Prescaler
wire clk_out;
prescaler prescaler_0
(
    .clk(clk),
    .clk_en(REGS [TMR_EN]),
    .rst(rst),
    .div(REGS [Prescaler]),
    .clk_out(clk_out)
);

reg [15:0] counter;
always@(negedge clk_out) //Negedge just because of the reset stuff
begin
    if(rst)
    begin
        counter = 16'b0;
        REGS [IRQ] [0:0] = 1'b0;
    end else if(REGS [TMR_EN])
    begin
        if(counter == REGS [Count])
        begin
            if(REGS [IRQ_EN])
            begin
                REGS [IRQ] [0:0] = 1'b1;
            end
        end
        counter = counter + 16'b1;
    end
end

assign irq = REGS [IRQ] [0:0];

endmodule