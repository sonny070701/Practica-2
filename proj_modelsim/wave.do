onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {TORRE DESTINO} -color Cyan -label {DISCO 1} -radix decimal {/RISC_V_Single_Cycle_TB/DUV/Data_Memory/ram[8]}
add wave -noupdate -group {TORRE DESTINO} -color Magenta -label {DISCO 2} -radix decimal {/RISC_V_Single_Cycle_TB/DUV/Data_Memory/ram[7]}
add wave -noupdate -group {TORRE DESTINO} -color Blue -label {DISCO 3} -radix decimal {/RISC_V_Single_Cycle_TB/DUV/Data_Memory/ram[6]}
add wave -noupdate -expand -group {TORRE AUXILIAR} -label {DISCO 1} -radix decimal {/RISC_V_Single_Cycle_TB/DUV/Data_Memory/ram[5]}
add wave -noupdate -expand -group {TORRE AUXILIAR} -color Magenta -label {DISCO 2} -radix decimal {/RISC_V_Single_Cycle_TB/DUV/Data_Memory/ram[4]}
add wave -noupdate -expand -group {TORRE AUXILIAR} -color Blue -label {DISCO 3} -radix decimal {/RISC_V_Single_Cycle_TB/DUV/Data_Memory/ram[3]}
add wave -noupdate -expand -group {TORRE ORIGEN} -color Cyan -label {DISCO 1} -radix decimal {/RISC_V_Single_Cycle_TB/DUV/Data_Memory/ram[2]}
add wave -noupdate -expand -group {TORRE ORIGEN} -color Magenta -label {DISCO 2} -radix decimal {/RISC_V_Single_Cycle_TB/DUV/Data_Memory/ram[1]}
add wave -noupdate -expand -group {TORRE ORIGEN} -color Blue -label {DISCO 3} -radix decimal {/RISC_V_Single_Cycle_TB/DUV/Data_Memory/ram[0]}
add wave -noupdate -group ALU -radix hexadecimal /RISC_V_Single_Cycle_TB/DUV/ALU_UNIT/A_i
add wave -noupdate -group ALU -radix hexadecimal /RISC_V_Single_Cycle_TB/DUV/ALU_UNIT/B_i
add wave -noupdate -group ALU -radix hexadecimal /RISC_V_Single_Cycle_TB/DUV/ALU_UNIT/Zero_o
add wave -noupdate -group ALU -radix hexadecimal /RISC_V_Single_Cycle_TB/DUV/ALU_UNIT/ALU_Result_o
add wave -noupdate -expand -group BRANCH /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/Branch_o
add wave -noupdate -expand -group PC -radix hexadecimal /RISC_V_Single_Cycle_TB/DUV/PROGRAM_COUNTER/Next_PC
add wave -noupdate -expand -group PC -radix hexadecimal /RISC_V_Single_Cycle_TB/DUV/PROGRAM_COUNTER/PC_Value
add wave -noupdate -group ADDRESS -radix hexadecimal /RISC_V_Single_Cycle_TB/DUV/Data_Memory/Address_i
add wave -noupdate -group ADDRESS -radix hexadecimal /RISC_V_Single_Cycle_TB/DUV/Data_Memory/real_address
add wave -noupdate -group ADDRESS -radix hexadecimal /RISC_V_Single_Cycle_TB/DUV/Data_Memory/Read_Data_o
add wave -noupdate -group SP -radix hexadecimal /RISC_V_Single_Cycle_TB/DUV/REGISTER_FILE_UNIT/Register_sp/enable
add wave -noupdate -group SP -radix hexadecimal /RISC_V_Single_Cycle_TB/DUV/REGISTER_FILE_UNIT/Register_sp/DataOutput
add wave -noupdate -group SP -radix hexadecimal /RISC_V_Single_Cycle_TB/DUV/REGISTER_FILE_UNIT/Register_sp/DataInput
add wave -noupdate -group S4 -radix decimal /RISC_V_Single_Cycle_TB/DUV/REGISTER_FILE_UNIT/Register_s4/DataOutput
add wave -noupdate -group S5 -radix decimal /RISC_V_Single_Cycle_TB/DUV/REGISTER_FILE_UNIT/Register_s5/DataOutput
TreeUpdate [SetDefaultTree]
WaveRestoreCursors
quietly wave cursor active 0
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
configure wave -timelineunits ps
update
WaveRestoreZoom {196 ps} {247 ps}
