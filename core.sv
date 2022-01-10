/*
Autor: Benjamin Herrera Navaro
*/

module core
(
input clk, 
input [15:0] din,
input rst,
input irq,
input [7:0] irq_id,
output logic [15:0] dout,
output logic wr,
output logic [15:0] addr
);

//parameter RESET_VECTOR = 16'hff;
parameter RESET_VECTOR = 16'h00; //Just for testing
parameter FETCH = 1'b0;
parameter DECODE = 1'b0;
parameter IRQ_VECTOR = 16'hff;
//Instructions

parameter iNOOP = 3'h0;
parameter iLI = 3'h1; //Load immediate
parameter iLSINS = 3'h2; //LOAD STORE INSTRUCTIONS
parameter iALUF = 3'h3;
parameter iINMI = 3'h4;
parameter iJMPFR = 3'h5;
parameter iMOVF = 3'h6;
parameter iJMPR = 3'h7; //Jump direct

logic [15:0] PC_IN_BUS;
wire jmp_s;

reg [15:0] IR = 16'h0;
reg [15:0] PC = 16'h0;
reg fetch_decode_state = 1'b0;
//Fetch decode logic
always@(posedge clk)
begin
	if(rst)
	begin
		fetch_decode_state = 1'b0;
	end
	else
	begin
		fetch_decode_state = ~fetch_decode_state;
	end
end
always@(negedge clk)
begin
	if(rst)
	begin
		PC = RESET_VECTOR;
		IR = 16'h0;
	end
	else
	begin
		if(fetch_decode_state)
		begin
			IR = din;
		end
		else
		begin
			if(jmp_s)
			begin
				PC = PC_IN_BUS;  
			end
			else
			begin
				PC = PC + 16'b1;
			end
		end
	end
end

reg IRQ_MASK;
reg IRQM_EN;
reg IRQ_EN;

wire decode = ~fetch_decode_state;
wire fetch = fetch_decode_state;

//reg irq_ff_en;
//always@(negedge clk)
//begin
//	if(rst)
//	begin
//		irq_ff_en = 1'b0;
//	end else if(irq & decode & IRQ_MASK)
//	begin
//		irq_ff_en = irq;
//	end else
//	begin
//		irq_ff_en = 1'b0;
//	end
//end
reg irq_ff;
//wire irq_s_ff;
always@(posedge clk)
begin
	if(rst)
	begin
		irq_ff = 1'b0;
	end
	else //Because it has to be set on the fetch cycle
	begin
		irq_ff = irq;
	end
end
//assign irq_s_ff = irq_ff & fetch;
//
//assign addr = PC;
//Do not decode nothing if there is an irq
wire blk_dec = (irq_ff & IRQ_MASK) & decode;
//Decoding of the instructions
assign S_NOOP = ((((IR [2:0] == iNOOP) ? 1 : 0) & decode) & ~blk_dec);
assign S_LI = ((((IR [2:0] == iLI) ? 1 : 0) & decode) & ~blk_dec);
assign S_LSINS = ((((IR [2:0] == iLSINS) ? 1 : 0) & decode) & ~blk_dec);
assign S_ALUF = ((((IR [2:0] == iALUF) ? 1 : 0) & decode) & ~blk_dec);
assign S_INMI = ((((IR [2:0] == iINMI) ? 1 : 0) & decode) & ~blk_dec);
assign S_JMPFR = ((((IR [2:0] == iJMPFR) ? 1 : 0) & decode) & ~blk_dec);
assign S_MOVF = ((((IR [2:0] == iMOVF) ? 1 : 0) & decode) & ~blk_dec);
assign S_JMPR = ((((IR [2:0] == iJMPR) ? 1 : 0) & decode) & ~blk_dec);

//Instruction addressing decoding
//LI INSTRUCTION
wire HL_LI = IR [3:3];
wire GS_LI = IR [4:4];
wire [2:0] RT_LI = IR [7:5];
wire [7:0] IMMV_LI = IR [15:8];
//ALUF INSTRUCTION DECODING
wire [3:0] OP_ALUF = IR [6:3]; 
wire [2:0] RT_ALUF = IR [9:7];
wire [2:0] S1_ALUF = IR [12:10];
wire [2:0] S2_ALUF = IR [15:13];
//MOVF INSTRUCTION DECODING
wire HL_T_MOVF = IR [3:3];
wire HL_S_MOVF = IR [4:4];
wire FT_MOVF = IR [5:5];
wire [3:0] OP_MOVF = IR [9:6];
wire [2:0] RT_MOVF = IR [12:10];
wire [2:0] S1_MOVF = IR [15:13];
//JMPFR AND JMPR DECODING
wire IVR_JMP = IR [3:3];
wire [2:0] OP_JMP = IR [6:4];
wire [2:0] AP_JMP = IR [9:7];
wire [2:0] T1_JMP = IR [12:10];
wire [2:0] T2_JMP = IR [15:13];
//LSINS INSTRUCTION DECODING
wire LS_LSINS = IR [3:3];
wire GS1_LSINS = IR [4:4];
wire GS2_LSINS = IR [5:5];
wire [2:0] T1_LSINS = IR [8:6]; //GPR/SPR
wire [2:0] P1_LSINS = IR [11:9];
//wire IMM_LSINS = IR [15:12]; //NOT USED
//wire HL2_LSINS = IR [5:5];
//INMI INSTRUCTION DECODING
wire [4:0] OP_INMI = IR [7:3];
wire [7:0] IMM_INMI = IR [15:8];

parameter iSPPP = 5'h0;
parameter iSPDD = 5'h1;
parameter iSYSC = 5'h2;
parameter iCRSW = 5'h3;
parameter iIRQE = 5'h4; //Set IRQ Enable Mode
//INMI OP DECODING
assign S_SPPP = ((OP_INMI == iSPPP) ? 1 : 0);
assign S_SPDD = ((OP_INMI == iSPDD) ? 1 : 0);
assign S_SYSC = ((OP_INMI == iSYSC) ? 1 : 0);
assign S_CRSW = ((OP_INMI == iCRSW) ? 1 : 0);
assign S_IRQE = ((OP_INMI == iIRQE) ? 1 : 0);
//STMR State Machine Register
/*
0:0 IRQ_ENABLE/IRQ MASK
*/
//reg IRQ_MASK; //MOVED UP SO IT CAN BE USED ON THE FETCH/DECODE logic
//reg IRQM_EN;
//reg IRQ_EN;
reg [15:0] PC_PRE_INC_FETCH; //JUST USED so iCALL can have a PC pre incremented save
always@(negedge clk)
begin
	if(rst)
	begin
		PC_PRE_INC_FETCH = 16'b0;
	end else if(fetch)
	begin
		PC_PRE_INC_FETCH = PC + 1;
	end
end
parameter iMOVGPRGPR = 4'h0;
parameter iMOVGPRSPR = 4'h1;
parameter iMOVSPRGPR = 4'h2;
parameter iMOVTMRGPR = 4'h3;
parameter iMOVGPRDMAR = 4'h4; 

//MOVF OP DECODING
assign S_MOVGPRGPR = ((OP_MOVF == iMOVGPRGPR) ? 1 : 0);
assign S_MOVGPRSPR = ((OP_MOVF == iMOVGPRSPR) ? 1 : 0);
assign S_MOVSPRGPR = ((OP_MOVF == iMOVSPRGPR) ? 1 : 0);
assign S_MOVTMRGPR = ((OP_MOVF == iMOVTMRGPR) ? 1 : 0);
assign S_MOVGPRDMAR = ((OP_MOVF == iMOVGPRDMAR) ? 1 : 0);

//Register file buses
wire [15:0] a_bus, d_bus, s_bus, b_bus;

//INMI SP PP and DD bus
logic inmi_sp_bus;
always_comb
begin
	casex({S_SPPP, S_SPDD})
		2'b1x: inmi_sp_bus = s_bus + 1; 
		2'bx1: inmi_sp_bus = s_bus - 1;
		default: inmi_sp_bus = 16'b0;
	endcase

end

//Select the movf source to target logic
logic [15:0] movf_logic_input;
always_comb
begin
	unique case(OP_MOVF)
		iMOVGPRGPR: movf_logic_input = a_bus; //GPR BUS
		iMOVGPRSPR: movf_logic_input = a_bus; //GPR BUS
		iMOVSPRGPR: movf_logic_input = s_bus; //SPR BUS
		default: movf_logic_input = 16'b0;
	endcase
end
//MOVF Bus hi lo logic
logic [15:0] movf_bus;
always_comb
begin
	casex({FT_MOVF, HL_S_MOVF})
		2'b1x: movf_bus = movf_logic_input; //Full Transfer
		2'bx1: movf_bus = {8'b0, movf_logic_input [15:8]}; //High bits
		2'b00: movf_bus = {8'b0, movf_logic_input [7:0]}; //Low Bits
		default: movf_bus = 16'b0;
	endcase
end

//REGISTER FILE CONTROL SIGNALS
wire sel = (S_ALUF | (S_MOVF & FT_MOVF) | (S_LSINS & ~LS_LSINS) | (S_INMI & (S_SPPP | S_SPDD)) | ((irq_ff & fetch) & IRQ_MASK) | S_SYSC);
wire sel_lo = ((S_LI & ~HL_LI) | (S_MOVF & (~HL_T_MOVF & ~FT_MOVF)));
wire sel_hi = ((S_LI & HL_LI) | (S_MOVF & (HL_T_MOVF & ~FT_MOVF)));
wire sel_gs = ((S_LI & GS_LI) | (~S_MOVGPRGPR & S_MOVF) | (S_LSINS & GS1_LSINS) | (S_INMI & (S_SPPP | S_SPDD)) | ((irq_ff & fetch) & IRQ_MASK) | S_SYSC);

//ALUF BUS
wire [15:0] z_bus;


//S OP
logic [3:0] s_op;
always_comb
begin
	casex({S_MOVF, LS_LSINS})
		2'b1x: s_op = S1_MOVF;
		2'bx1: s_op = P1_LSINS; //Address pointer
		default: s_op = 3'b0;
	endcase
end
//C OP
logic [2:0] c_op;
always_comb
begin
	casex({S_LI, S_ALUF, S_MOVF, (S_LSINS & ~LS_LSINS), (S_INMI & (S_SPPP | S_SPDD)), (IRQ_MASK & (irq_ff & fetch)), S_SYSC})
		7'b1xxxxxx: c_op = RT_LI;
		7'bx1xxxxx: c_op = RT_ALUF;
		7'bxx1xxxx: c_op = RT_MOVF;
		7'bxxx1xxx: c_op = T1_LSINS;
		7'bxxxx1xx: c_op = 3'b0; //SP
		7'bxxxxx1x: c_op = 3'h6; //LPR
		7'bxxxxxx1: c_op = 3'h6; //LPR
		default: c_op = 3'b0;
	endcase
end

//C BUS
logic [15:0] c_bus;
always_comb
begin
	casex({S_LI, S_ALUF, S_MOVF, (S_LSINS & ~LS_LSINS), (S_INMI & (S_SPPP | S_SPDD)), (IRQ_MASK & (irq_ff & fetch)), S_SYSC})
		7'b1xxxxxx: c_bus = {8'h0 , IMMV_LI};
		7'bx1xxxxx: c_bus = z_bus;
		7'bxx1xxxx: c_bus = movf_bus;
		7'bxxx1xxx: c_bus = din;
		7'bxxxx1xx: c_bus = inmi_sp_bus;
		7'bxxxxx1x: c_bus = PC;
		7'bxxxxxx1: c_bus = PC_PRE_INC_FETCH;
		default: c_bus = 16'b0;
	endcase
end
//A OP
logic [2:0] a_op;
always_comb
begin
	casex({S_ALUF, S_MOVF, (S_JMPFR | S_JMPR), S_LSINS})
		4'b1xxx: a_op = S1_ALUF;
		4'bx1xx: a_op = S1_MOVF;
		4'bxx1x: a_op = T1_JMP;
		4'bxxx1: a_op = P1_LSINS;
		default: a_op = 3'b0;
	endcase
end
//B OP
logic [2:0] b_op;
always_comb
begin
	casex({S_ALUF, (S_JMPFR | S_JMPR), (S_LSINS & LS_LSINS)})
		3'b1xx: b_op = S2_ALUF;
		3'bx1x: b_op = T2_JMP;
		3'bxx1: b_op = T1_LSINS;
		default: b_op = 3'b0;
	endcase
end
//D_BUS
logic [2:0] d_op;
always_comb
begin
	casex({(S_JMPFR | S_JMPR)})
			1'b1: d_op = AP_JMP;
		default: d_op = 3'b0;
	endcase
end
//E OP
logic [2:0] e_op;
always_comb
begin
	casex({(S_LSINS & LS_LSINS)})
			1'b1: e_op = T1_LSINS; //Data to store
		default: e_op = 3'b0;
	endcase
end
//IRQ INPUT
wire IRQ_S; //To use it up here
logic [7:0] irq_bus;
always_comb
begin
	casex({IRQ_S, S_SYSC})
			2'b1x: irq_bus = {8'b0, irq_id};
			2'bx1: irq_bus = 16'b0;
		default irq_bus = 8'b0;
	endcase
end
wire irq_sel;
//REGISTER FILE
regfile regfile_0
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
    .e_op(e_op),
    .c_bus(c_bus),
    .a_bus(a_bus),
    .b_bus(b_bus),
    .d_bus(d_bus),
    .s_bus(s_bus),
    .e_bus(e_bus),
	.irq_sel(irq_sel),
	.irq_bus(irq_bus)
);

wire carry_out;
//ARITHMETIC LOGIC UNIT
alu alu_0
(
	.a(a_bus [15:0]),
	.b(b_bus [15:0]),
	.z(z_bus),
	.op(OP_ALUF),
	.cin(1'b0),
	.cout(carry_out)
);


/*
	The negative sign will be calculated by the LSB
	Calculate OVR
*/

//CPU FLAGS/BRANCH LOGIC
assign AB_S = (a_bus > b_bus) ? 1 : 0;
assign EQ_S = (a_bus == b_bus) ? 1 : 0;
assign BA_S = (a_bus < b_bus) ? 1 : 0; 
assign NG_S = (z_bus [15:15]);
assign OR_S = (z_bus [15:15] & carry_out);
assign ZR_S = (z_bus == 16'h0);
assign NO_S = (1'b1);

assign AB = (IVR_JMP) ? ~AB_S : AB_S;
assign EQ = (IVR_JMP) ? ~EQ_S : EQ_S;
assign BA = (IVR_JMP) ? ~BA_S : BA_S;
assign NG = (IVR_JMP) ? ~NG_S : NG_S;
assign OR = (IVR_JMP) ? ~OR_S : OR_S;
assign ZR = (IVR_JMP) ? ~ZR_S : ZR_S;
assign NO = (IVR_JMP) ? ~NO_S : NO_S;

parameter iJMPAB = 3'h00;
parameter iJMPEQ = 3'h01;
parameter iJMPBA = 3'h02;
parameter iJMPNEG = 3'h03;
parameter iJMPOVR = 3'h04;
parameter iJMPZERO = 3'h05;
parameter iJMPNONE = 3'h06; 

logic branch_s; //true when branch condition true
//JMP LOGIC
always_comb
begin
	unique case(OP_JMP)
		iJMPAB: branch_s = AB; 
		iJMPEQ: branch_s = EQ; 
		iJMPBA: branch_s = BA; 
		iJMPNEG: branch_s = NG; 
		iJMPOVR: branch_s = OR; 
		iJMPZERO: branch_s = ZR; 
		iJMPNONE: branch_s = NO; 
		default: branch_s = 1'b0;
	endcase	
end

assign IRQ_S = decode & (irq_ff & IRQ_MASK);
assign jmp_s = (branch_s & (S_JMPFR | S_JMPFR) | IRQ_S | S_SYSC);
assign irq_sel = (IRQ_S | S_SYSC);

//RELATIVE BUS CALCULATE
/*
	THE LSB of the A_BUS will determine if to jump relative to PC negative or positive
*/

logic [15:0] relative_bus;
always_comb
begin
	if(a_bus [15:15])
	begin
		relative_bus = (PC - {1'b0, a_bus});
	end
	else
	begin
		relative_bus = (PC + {1'b0, a_bus});
	end
end

//IRQ VECTOR ID LOGIC
//On Decode Signal the IRQ_MASK will be set to high
//On Decode Signal the PC <= IRQ_VECTOR
//On Decode Signal and negedge clk LPR <= PC
logic IRQ_EN_INPUT;
always_comb
begin
	if((S_IRQE & S_INMI))
	begin
		IRQ_EN_INPUT = IMM_INMI [0:0];
	end else
	begin
		IRQ_EN_INPUT = 1'b0;
	end
end
always@(negedge clk)
begin
	if(rst)
	begin
		IRQ_EN = 1'b0;
	end else if((S_IRQE & S_INMI) | (IRQ_MASK & fetch))
	begin
		IRQ_EN = IRQ_EN_INPUT;
	end
end

always@(negedge clk)
begin
	if(rst)
	begin
		 IRQM_EN = 1'b0;
	end
	else if(decode & (IRQ_MASK & irq_ff))
	begin
			IRQM_EN = 1'b1;
	end else
	begin
		IRQM_EN = 1'b0;
	end
end

//IRQ MASK input
logic irq_mask_in;
always_comb
begin
	casex({IRQ_EN})
			1'b1: irq_mask_in = 1'b1;
		default: irq_mask_in = 1'b0;
	endcase
end
	    
//When masked the IRQ will be fetched
always@(posedge clk)
begin
	if(rst)
	begin
		IRQ_MASK = 1'b0;
	end
	else if(IRQ_EN | IRQM_EN)
	begin
		IRQ_MASK = irq_mask_in;
	end
end


//logic [15:0] PC_IN_BUS;

always_comb
begin
	casex({S_JMPFR, S_JMPR, (IRQ_S | S_SYSC)})
			3'b1xx: PC_IN_BUS = d_bus;
			3'bx1x: PC_IN_BUS = relative_bus;
			3'bxx1: PC_IN_BUS = IRQ_VECTOR;
		default: PC_IN_BUS = 16'b0;
	endcase
end


//LSINS LOGIC
logic [15:0] ls_gs_bus_dout;
always_comb
begin
	if(GS1_LSINS)
	begin
		ls_gs_bus_dout = e_bus;
	end
	else
	begin
		ls_gs_bus_dout = b_bus;
	end
end
//ADDR OUTPUT LOGIC

always_comb
begin
	logic [15:0] ls_gs_bus_addr;
	if(GS2_LSINS)
	begin
		ls_gs_bus_addr = s_bus;
	end
	else
	begin
		ls_gs_bus_addr = a_bus;
	end


	casex({S_LSINS})
			1'b1: addr = ls_gs_bus_addr;
		default: addr = PC;
	endcase
end

//DATA OUTPUT LOGIC
always_comb
begin
	casex({(S_LSINS & LS_LSINS)})
			1'b1: dout = ls_gs_bus_dout;
		default: dout = 16'b0;
	endcase
end

assign wr = (S_LSINS & LS_LSINS);



endmodule 
