onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /button_testbench/CLOCK_PERIOD
add wave -noupdate /button_testbench/clk
add wave -noupdate /button_testbench/Reset
add wave -noupdate /button_testbench/pressed
add wave -noupdate /button_testbench/set
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1000 ps} 0}
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
configure wave -gridperiod 300
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {393 ps} {1401 ps}
