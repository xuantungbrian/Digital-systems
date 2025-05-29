onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /main_fsm_tb/DUT/clk
add wave -noupdate /main_fsm_tb/DUT/reset_n
add wave -noupdate /main_fsm_tb/DUT/invalid_ascii
add wave -noupdate /main_fsm_tb/DUT/finish_init
add wave -noupdate /main_fsm_tb/DUT/finish_shuffle
add wave -noupdate /main_fsm_tb/DUT/finish_compute
add wave -noupdate /main_fsm_tb/DUT/start_init
add wave -noupdate /main_fsm_tb/DUT/start_shuffle
add wave -noupdate /main_fsm_tb/DUT/start_compute
add wave -noupdate /main_fsm_tb/DUT/LEDR
add wave -noupdate /main_fsm_tb/DUT/secret_key
add wave -noupdate /main_fsm_tb/DUT/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {493 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 233
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
WaveRestoreZoom {0 ps} {233 ps}
