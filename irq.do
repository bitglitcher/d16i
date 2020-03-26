onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /core_test_bench/core_0/clk
add wave -noupdate -radix hexadecimal /core_test_bench/core_0/din
add wave -noupdate /core_test_bench/core_0/rst
add wave -noupdate /core_test_bench/core_0/irq
add wave -noupdate /core_test_bench/core_0/irq_id
add wave -noupdate /core_test_bench/core_0/dout
add wave -noupdate /core_test_bench/core_0/wr
add wave -noupdate -radix hexadecimal /core_test_bench/core_0/addr
add wave -noupdate -radix hexadecimal /core_test_bench/core_0/PC_IN_BUS
add wave -noupdate /core_test_bench/core_0/jmp_s
add wave -noupdate -radix hexadecimal /core_test_bench/core_0/IR
add wave -noupdate -radix hexadecimal /core_test_bench/core_0/PC
add wave -noupdate /core_test_bench/core_0/fetch_decode_state
add wave -noupdate /core_test_bench/core_0/IRQ_MASK
add wave -noupdate /core_test_bench/core_0/IRQM_EN
add wave -noupdate /core_test_bench/core_0/IRQ_EN
add wave -noupdate /core_test_bench/core_0/decode
add wave -noupdate /core_test_bench/core_0/fetch
add wave -noupdate /core_test_bench/core_0/irq_ff
add wave -noupdate /core_test_bench/core_0/blk_dec
add wave -noupdate /core_test_bench/core_0/S_NOOP
add wave -noupdate /core_test_bench/core_0/S_LI
add wave -noupdate /core_test_bench/core_0/S_LSINS
add wave -noupdate /core_test_bench/core_0/S_ALUF
add wave -noupdate /core_test_bench/core_0/S_INMI
add wave -noupdate /core_test_bench/core_0/S_JMPFR
add wave -noupdate /core_test_bench/core_0/S_MOVF
add wave -noupdate /core_test_bench/core_0/S_JMPR
add wave -noupdate /core_test_bench/core_0/HL_LI
add wave -noupdate /core_test_bench/core_0/GS_LI
add wave -noupdate /core_test_bench/core_0/RT_LI
add wave -noupdate /core_test_bench/core_0/IMMV_LI
add wave -noupdate /core_test_bench/core_0/OP_ALUF
add wave -noupdate /core_test_bench/core_0/RT_ALUF
add wave -noupdate /core_test_bench/core_0/S1_ALUF
add wave -noupdate /core_test_bench/core_0/S2_ALUF
add wave -noupdate /core_test_bench/core_0/HL_T_MOVF
add wave -noupdate /core_test_bench/core_0/HL_S_MOVF
add wave -noupdate /core_test_bench/core_0/FT_MOVF
add wave -noupdate /core_test_bench/core_0/OP_MOVF
add wave -noupdate /core_test_bench/core_0/RT_MOVF
add wave -noupdate /core_test_bench/core_0/S1_MOVF
add wave -noupdate /core_test_bench/core_0/IVR_JMP
add wave -noupdate /core_test_bench/core_0/OP_JMP
add wave -noupdate /core_test_bench/core_0/AP_JMP
add wave -noupdate /core_test_bench/core_0/T1_JMP
add wave -noupdate /core_test_bench/core_0/T2_JMP
add wave -noupdate /core_test_bench/core_0/LS_LSINS
add wave -noupdate /core_test_bench/core_0/GS1_LSINS
add wave -noupdate /core_test_bench/core_0/GS2_LSINS
add wave -noupdate /core_test_bench/core_0/T1_LSINS
add wave -noupdate /core_test_bench/core_0/P1_LSINS
add wave -noupdate /core_test_bench/core_0/OP_INMI
add wave -noupdate /core_test_bench/core_0/IMM_INMI
add wave -noupdate /core_test_bench/core_0/S_SPPP
add wave -noupdate /core_test_bench/core_0/S_SPDD
add wave -noupdate /core_test_bench/core_0/S_SYSC
add wave -noupdate /core_test_bench/core_0/S_CRSW
add wave -noupdate /core_test_bench/core_0/S_IRQE
add wave -noupdate /core_test_bench/core_0/S_MOVGPRGPR
add wave -noupdate /core_test_bench/core_0/S_MOVGPRSPR
add wave -noupdate /core_test_bench/core_0/S_MOVSPRGPR
add wave -noupdate /core_test_bench/core_0/S_MOVTMRGPR
add wave -noupdate /core_test_bench/core_0/S_MOVGPRDMAR
add wave -noupdate /core_test_bench/core_0/a_bus
add wave -noupdate /core_test_bench/core_0/d_bus
add wave -noupdate /core_test_bench/core_0/s_bus
add wave -noupdate /core_test_bench/core_0/b_bus
add wave -noupdate /core_test_bench/core_0/inmi_sp_bus
add wave -noupdate /core_test_bench/core_0/movf_logic_input
add wave -noupdate /core_test_bench/core_0/movf_bus
add wave -noupdate /core_test_bench/core_0/sel
add wave -noupdate /core_test_bench/core_0/sel_lo
add wave -noupdate /core_test_bench/core_0/sel_hi
add wave -noupdate /core_test_bench/core_0/sel_gs
add wave -noupdate /core_test_bench/core_0/z_bus
add wave -noupdate /core_test_bench/core_0/s_op
add wave -noupdate -radix hexadecimal /core_test_bench/core_0/c_op
add wave -noupdate -radix hexadecimal /core_test_bench/core_0/c_bus
add wave -noupdate /core_test_bench/core_0/a_op
add wave -noupdate /core_test_bench/core_0/b_op
add wave -noupdate /core_test_bench/core_0/d_op
add wave -noupdate /core_test_bench/core_0/e_op
add wave -noupdate /core_test_bench/core_0/e_bus
add wave -noupdate /core_test_bench/core_0/carry_out
add wave -noupdate /core_test_bench/core_0/AB_S
add wave -noupdate /core_test_bench/core_0/EQ_S
add wave -noupdate /core_test_bench/core_0/BA_S
add wave -noupdate /core_test_bench/core_0/NG_S
add wave -noupdate /core_test_bench/core_0/OR_S
add wave -noupdate /core_test_bench/core_0/ZR_S
add wave -noupdate /core_test_bench/core_0/NO_S
add wave -noupdate /core_test_bench/core_0/AB
add wave -noupdate /core_test_bench/core_0/EQ
add wave -noupdate /core_test_bench/core_0/BA
add wave -noupdate /core_test_bench/core_0/NG
add wave -noupdate /core_test_bench/core_0/OR
add wave -noupdate /core_test_bench/core_0/ZR
add wave -noupdate /core_test_bench/core_0/NO
add wave -noupdate /core_test_bench/core_0/branch_s
add wave -noupdate /core_test_bench/core_0/IRQ_S
add wave -noupdate /core_test_bench/core_0/relative_bus
add wave -noupdate /core_test_bench/core_0/IRQ_EN_INPUT
add wave -noupdate /core_test_bench/core_0/irq_mask_in
add wave -noupdate /core_test_bench/core_0/ls_gs_bus_dout
add wave -noupdate /core_test_bench/core_0/irq_bus
add wave -noupdate /core_test_bench/core_0/irq_sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {266088 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 292
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {76685 ps} {526117 ps}
