onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /UART_RX_tb/TX_CLOCK_PERIOD
add wave -noupdate /UART_RX_tb/RX_CLOCK_PERIOD
add wave -noupdate /UART_RX_tb/i
add wave -noupdate -radix decimal /UART_RX_tb/Current_testcase
add wave -noupdate -expand -group {TB SIGNALS} /UART_RX_tb/RX_CLK_tb
add wave -noupdate -expand -group {TB SIGNALS} /UART_RX_tb/TX_CLK_tb
add wave -noupdate -expand -group {TB SIGNALS} -color White /UART_RX_tb/RST_tb
add wave -noupdate -expand -group {TB SIGNALS} -divider INPUTS
add wave -noupdate -expand -group {TB SIGNALS} -color White /UART_RX_tb/RX_IN_tb
add wave -noupdate -expand -group {TB SIGNALS} -color White /UART_RX_tb/PAR_EN_tb
add wave -noupdate -expand -group {TB SIGNALS} -color White /UART_RX_tb/Prescale_tb
add wave -noupdate -expand -group {TB SIGNALS} -color White /UART_RX_tb/PAR_TYP_tb
add wave -noupdate -expand -group {TB SIGNALS} -divider OUTPUTS
add wave -noupdate -expand -group {TB SIGNALS} -color Turquoise /UART_RX_tb/P_DATA_tb
add wave -noupdate -expand -group {TB SIGNALS} -color Turquoise /UART_RX_tb/Parity_Error_tb
add wave -noupdate -expand -group {TB SIGNALS} -color Turquoise /UART_RX_tb/Stop_Error_tb
add wave -noupdate -expand -group {TB SIGNALS} -color Turquoise /UART_RX_tb/DATA_VALID_tb
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/FSM/CLK
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/FSM/RST
add wave -noupdate -expand -group FSM -divider INPUTS
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/FSM/RX_IN
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/FSM/Data_Recived
add wave -noupdate -expand -group FSM -color {Light Blue} /UART_RX_tb/DUT/FSM/bit_done
add wave -noupdate -expand -group FSM -color {Light Blue} /UART_RX_tb/DUT/FSM/bit_cnt
add wave -noupdate -expand -group FSM -color {Medium Aquamarine} /UART_RX_tb/DUT/FSM/strt_glitch
add wave -noupdate -expand -group FSM -color Pink /UART_RX_tb/DUT/FSM/PAR_EN
add wave -noupdate -expand -group FSM -color Pink /UART_RX_tb/DUT/FSM/par_chk_en
add wave -noupdate -expand -group FSM -color Pink /UART_RX_tb/DUT/FSM/par_err
add wave -noupdate -expand -group FSM -color Cyan /UART_RX_tb/DUT/FSM/stp_err
add wave -noupdate -expand -group FSM -divider OUTPUTS
add wave -noupdate -expand -group FSM -color {Light Blue} /UART_RX_tb/DUT/FSM/enable
add wave -noupdate -expand -group FSM -color {Light Blue} /UART_RX_tb/DUT/FSM/count_rst
add wave -noupdate -expand -group FSM -color White /UART_RX_tb/DUT/FSM/data_samp_en
add wave -noupdate -expand -group FSM -color White /UART_RX_tb/DUT/FSM/deser_en
add wave -noupdate -expand -group FSM -color {Medium Aquamarine} /UART_RX_tb/DUT/FSM/strt_chk_en
add wave -noupdate -expand -group FSM -color Pink /UART_RX_tb/DUT/FSM/par_save_bit
add wave -noupdate -expand -group FSM -color Cyan /UART_RX_tb/DUT/FSM/stp_chk_en
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/FSM/Parity_Error
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/FSM/Stop_Error
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/FSM/DATA_VALID
add wave -noupdate -expand -group FSM -divider STATES
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/FSM/Current_State
add wave -noupdate -expand -group FSM /UART_RX_tb/DUT/FSM/Next_State
add wave -noupdate -expand -group {EDGE CNT} -divider INPUTS
add wave -noupdate -expand -group {EDGE CNT} /UART_RX_tb/DUT/Edge_Counter/CLK
add wave -noupdate -expand -group {EDGE CNT} /UART_RX_tb/DUT/Edge_Counter/RST
add wave -noupdate -expand -group {EDGE CNT} -color {Sky Blue} /UART_RX_tb/DUT/Edge_Counter/Prescale
add wave -noupdate -expand -group {EDGE CNT} -color {Sky Blue} /UART_RX_tb/DUT/Edge_Counter/enable
add wave -noupdate -expand -group {EDGE CNT} -color {Sky Blue} /UART_RX_tb/DUT/Edge_Counter/count_rst
add wave -noupdate -expand -group {EDGE CNT} -color {Sky Blue} /UART_RX_tb/DUT/Edge_Counter/clock_edge_cnt
add wave -noupdate -expand -group {EDGE CNT} -divider OUTPUTS
add wave -noupdate -expand -group {EDGE CNT} -color White /UART_RX_tb/DUT/Edge_Counter/bit_cnt
add wave -noupdate -expand -group {EDGE CNT} -color White /UART_RX_tb/DUT/Edge_Counter/edge_cnt
add wave -noupdate -expand -group {EDGE CNT} -color White /UART_RX_tb/DUT/Edge_Counter/bit_done
add wave -noupdate -expand -group {DATA SAMPLER} /UART_RX_tb/DUT/Data_Sampler/CLK
add wave -noupdate -expand -group {DATA SAMPLER} /UART_RX_tb/DUT/Data_Sampler/RST
add wave -noupdate -expand -group {DATA SAMPLER} -divider INPUTS
add wave -noupdate -expand -group {DATA SAMPLER} -color {Medium Aquamarine} /UART_RX_tb/DUT/Data_Sampler/Prescale
add wave -noupdate -expand -group {DATA SAMPLER} -color {Medium Aquamarine} /UART_RX_tb/DUT/Data_Sampler/RX_IN
add wave -noupdate -expand -group {DATA SAMPLER} -color {Medium Aquamarine} /UART_RX_tb/DUT/Data_Sampler/data_samp_en
add wave -noupdate -expand -group {DATA SAMPLER} -color {Medium Aquamarine} /UART_RX_tb/DUT/Data_Sampler/edge_cnt
add wave -noupdate -expand -group {DATA SAMPLER} -divider OUTPUTS
add wave -noupdate -expand -group {DATA SAMPLER} -color White /UART_RX_tb/DUT/Data_Sampler/sampled_bit
add wave -noupdate -expand -group {DATA SAMPLER} -color White /UART_RX_tb/DUT/Data_Sampler/Middle_bits
add wave -noupdate -expand -group DESERIALIZER /UART_RX_tb/DUT/Deserializer/CLK
add wave -noupdate -expand -group DESERIALIZER /UART_RX_tb/DUT/Deserializer/RST
add wave -noupdate -expand -group DESERIALIZER -divider INPUTS
add wave -noupdate -expand -group DESERIALIZER -color {Light Steel Blue} /UART_RX_tb/DUT/Deserializer/deser_en
add wave -noupdate -expand -group DESERIALIZER -color {Light Steel Blue} /UART_RX_tb/DUT/Deserializer/sampled_bit
add wave -noupdate -expand -group DESERIALIZER -color {Light Steel Blue} /UART_RX_tb/DUT/Deserializer/bit_done
add wave -noupdate -expand -group DESERIALIZER -color {Light Steel Blue} /UART_RX_tb/DUT/Deserializer/bit_cnt
add wave -noupdate -expand -group DESERIALIZER -divider OUTPUTS
add wave -noupdate -expand -group DESERIALIZER -color {Cornflower Blue} /UART_RX_tb/DUT/Deserializer/P_DATA
add wave -noupdate -group {PARITY CHECK} /UART_RX_tb/DUT/Parity_Checker/CLK
add wave -noupdate -group {PARITY CHECK} /UART_RX_tb/DUT/Parity_Checker/RST
add wave -noupdate -group {PARITY CHECK} -divider INPUTS
add wave -noupdate -group {PARITY CHECK} -color {Cornflower Blue} /UART_RX_tb/DUT/Parity_Checker/par_chk_en
add wave -noupdate -group {PARITY CHECK} -color {Cornflower Blue} /UART_RX_tb/DUT/Parity_Checker/par_save_bit
add wave -noupdate -group {PARITY CHECK} -color {Cornflower Blue} /UART_RX_tb/DUT/Parity_Checker/PAR_TYP
add wave -noupdate -group {PARITY CHECK} -color {Cornflower Blue} /UART_RX_tb/DUT/Parity_Checker/sampled_bit
add wave -noupdate -group {PARITY CHECK} -color {Cornflower Blue} /UART_RX_tb/DUT/Parity_Checker/bit_done
add wave -noupdate -group {PARITY CHECK} -divider OUTPUTS
add wave -noupdate -group {PARITY CHECK} -color {Sky Blue} /UART_RX_tb/DUT/Parity_Checker/par_err
add wave -noupdate -group {PARITY CHECK} -color {Sky Blue} /UART_RX_tb/DUT/Parity_Checker/parity_calculated
add wave -noupdate -group {START CHECK} /UART_RX_tb/DUT/Start_Checker/CLK
add wave -noupdate -group {START CHECK} /UART_RX_tb/DUT/Start_Checker/RST
add wave -noupdate -group {START CHECK} -divider INPUTS
add wave -noupdate -group {START CHECK} -color {Cornflower Blue} /UART_RX_tb/DUT/Start_Checker/strt_chk_en
add wave -noupdate -group {START CHECK} -color {Cornflower Blue} /UART_RX_tb/DUT/Start_Checker/sampled_bit
add wave -noupdate -group {START CHECK} -divider OUTPUTS
add wave -noupdate -group {START CHECK} -color {Sky Blue} /UART_RX_tb/DUT/Start_Checker/strt_glitch
add wave -noupdate -group {STOP CHECK} /UART_RX_tb/DUT/Stop_Checker/RST
add wave -noupdate -group {STOP CHECK} /UART_RX_tb/DUT/Stop_Checker/CLK
add wave -noupdate -group {STOP CHECK} -divider INPUTS
add wave -noupdate -group {STOP CHECK} -color {Cornflower Blue} /UART_RX_tb/DUT/Stop_Checker/stp_chk_en
add wave -noupdate -group {STOP CHECK} -color {Cornflower Blue} /UART_RX_tb/DUT/Stop_Checker/sampled_bit
add wave -noupdate -group {STOP CHECK} -divider OUTPUTS
add wave -noupdate -group {STOP CHECK} -color {Sky Blue} /UART_RX_tb/DUT/Stop_Checker/stp_err
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2291678400 ps} 0} {{Cursor 2} {2387165000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 242
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {2291678400 ps} {2387165 ns}
