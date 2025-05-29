onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fsm_tb/clk
add wave -noupdate /fsm_tb/flash_mem_waitrequest
add wave -noupdate /fsm_tb/flash_mem_readdatavalid
add wave -noupdate /fsm_tb/fsm_stim
add wave -noupdate /fsm_tb/stop
add wave -noupdate /fsm_tb/flash_mem_byteenable
add wave -noupdate /fsm_tb/flash_mem_read
add wave -noupdate /fsm_tb/DUT/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {1 ns}
