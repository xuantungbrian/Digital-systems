onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /swap_tb/DUT/clk
add wave -noupdate /swap_tb/DUT/q
add wave -noupdate /swap_tb/DUT/SW
add wave -noupdate /swap_tb/DUT/data
add wave -noupdate /swap_tb/DUT/address
add wave -noupdate /swap_tb/DUT/finish
add wave -noupdate /swap_tb/DUT/wren
add wave -noupdate /swap_tb/DUT/state
add wave -noupdate /swap_tb/DUT/temp_val_i
add wave -noupdate /swap_tb/DUT/temp_addr_i
add wave -noupdate /swap_tb/DUT/temp_val_j
add wave -noupdate /swap_tb/DUT/temp_addr_j
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 218
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
WaveRestoreZoom {0 ps} {60 ps}
