onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TESTBENCH /UART_TX_tb/currect_Testcase
add wave -noupdate -expand -group TESTBENCH /UART_TX_tb/CLK_tb
add wave -noupdate -expand -group TESTBENCH /UART_TX_tb/RST_tb
add wave -noupdate -expand -group TESTBENCH -color White /UART_TX_tb/P_DATA_tb
add wave -noupdate -expand -group TESTBENCH -color White /UART_TX_tb/DATA_VALID_tb
add wave -noupdate -expand -group TESTBENCH -color White /UART_TX_tb/PAR_EN_tb
add wave -noupdate -expand -group TESTBENCH -color White /UART_TX_tb/PAR_TYP_tb
add wave -noupdate -expand -group TESTBENCH /UART_TX_tb/TX_OUT_tb
add wave -noupdate -expand -group TESTBENCH /UART_TX_tb/Busy_tb
add wave -noupdate -expand -group TESTBENCH /UART_TX_tb/Recived_data
add wave -noupdate -expand -group TESTBENCH /UART_TX_tb/parity_bit_Expec
add wave -noupdate -expand -group FSM /UART_TX_tb/UART_TX/FSM/Current_State
add wave -noupdate -expand -group FSM /UART_TX_tb/UART_TX/FSM/Next_State
add wave -noupdate -expand -group FSM -color White /UART_TX_tb/UART_TX/FSM/DATA_VALID
add wave -noupdate -expand -group FSM -color White /UART_TX_tb/UART_TX/FSM/PAR_EN
add wave -noupdate -expand -group FSM -color Cyan /UART_TX_tb/UART_TX/FSM/Ser_Done
add wave -noupdate -expand -group FSM -color Cyan /UART_TX_tb/UART_TX/FSM/Ser_En
add wave -noupdate -expand -group FSM -color {Cornflower Blue} /UART_TX_tb/UART_TX/FSM/MUX_Sel
add wave -noupdate -expand -group FSM /UART_TX_tb/UART_TX/FSM/Busy
add wave -noupdate -expand -group SERIALIZER /UART_TX_tb/UART_TX/Serial_Data/P_DATA
add wave -noupdate -expand -group SERIALIZER -color Cyan /UART_TX_tb/UART_TX/Serial_Data/Ser_En
add wave -noupdate -expand -group SERIALIZER -color Cyan /UART_TX_tb/UART_TX/Serial_Data/Ser_Done
add wave -noupdate -expand -group SERIALIZER /UART_TX_tb/UART_TX/Serial_Data/Ser_Data
add wave -noupdate -expand -group SERIALIZER /UART_TX_tb/UART_TX/Serial_Data/Counter
add wave -noupdate -group {REG INPUTS} /UART_TX_tb/UART_TX/reg_inputs/DATA_VALID
add wave -noupdate -group {REG INPUTS} /UART_TX_tb/UART_TX/reg_inputs/Busy
add wave -noupdate -group {REG INPUTS} -color Cyan /UART_TX_tb/UART_TX/reg_inputs/P_DATA
add wave -noupdate -group {REG INPUTS} -color Cyan /UART_TX_tb/UART_TX/reg_inputs/P_DATA_reg
add wave -noupdate -group {REG INPUTS} -color Violet /UART_TX_tb/UART_TX/reg_inputs/PAR_EN
add wave -noupdate -group {REG INPUTS} -color Violet /UART_TX_tb/UART_TX/reg_inputs/PAR_EN_reg
add wave -noupdate -group {REG INPUTS} -color {Cadet Blue} /UART_TX_tb/UART_TX/reg_inputs/PAR_TYP
add wave -noupdate -group {REG INPUTS} -color {Cadet Blue} /UART_TX_tb/UART_TX/reg_inputs/PAR_TYP_reg
add wave -noupdate -group PARITY /UART_TX_tb/UART_TX/Parity/P_DATA
add wave -noupdate -group PARITY /UART_TX_tb/UART_TX/Parity/PAR_TYP
add wave -noupdate -group PARITY /UART_TX_tb/UART_TX/Parity/Par_Bit
add wave -noupdate -group MUX /UART_TX_tb/UART_TX/MUX/MUX_Sel
add wave -noupdate -group MUX /UART_TX_tb/UART_TX/MUX/Ser_Data
add wave -noupdate -group MUX /UART_TX_tb/UART_TX/MUX/Par_Bit
add wave -noupdate -group MUX /UART_TX_tb/UART_TX/MUX/Busy
add wave -noupdate -group MUX /UART_TX_tb/UART_TX/MUX/DATA_VALID
add wave -noupdate -group MUX -color {Cornflower Blue} /UART_TX_tb/UART_TX/MUX/TX_OUT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {227500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ns
update
WaveRestoreZoom {306400 ps} {394400 ps}
