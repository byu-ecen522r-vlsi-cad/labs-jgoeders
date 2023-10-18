
set io_placer_hor_layer met3
set io_placer_ver_layer met2


set db_file aes.db

if { [file exists $db_file] == 1} {   
    read_db $db_file
} else {

# Read in library files
read_lef ../third_party/OpenROAD-flow-scripts/flow/platforms/sky130hd/lef/sky130_fd_sc_hd.tlef
read_lef ../third_party/OpenROAD-flow-scripts/flow/platforms/sky130hd/lef/sky130io_fill.lef
read_lef ../third_party/OpenROAD-flow-scripts/flow/platforms/sky130hd/lef/sky130_fd_sc_hd_merged.lef
read_liberty ../third_party/OpenROAD-flow-scripts/flow/platforms/sky130hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Read in design
# read_verilog aes_synth.v
# link_design aes_cipher_top

# read_verilog chameleon.v
# link_design soc_core

read_verilog gcd.v
link_design gcd

set density 1

remove_buffers

# export DIE_AREA   = 0 0 2920 3520
# export CORE_AREA  = 20 20 2900 3500

# Floorplan
initialize_floorplan -utilization $density -aspect_ratio 1 -core_space 1
# initialize_floorplan -die_area 0 0 2920 3620 -core_area 20 20 2900 3500 -site unithd

make_tracks li1  -x_offset 0.23 -x_pitch 0.46 -y_offset 0.17 -y_pitch 0.34
make_tracks met1 -x_offset 0.17 -x_pitch 0.34 -y_offset 0.17 -y_pitch 0.34
make_tracks met2 -x_offset 0.23 -x_pitch 0.46 -y_offset 0.23 -y_pitch 0.46
make_tracks met3 -x_offset 0.34 -x_pitch 0.68 -y_offset 0.34 -y_pitch 0.68
make_tracks met4 -x_offset 0.46 -x_pitch 0.92 -y_offset 0.46 -y_pitch 0.92
make_tracks met5 -x_offset 1.70 -x_pitch 3.40 -y_offset 1.70 -y_pitch 3.40
remove_buffers

# Random I/O placement
place_pins -random -hor_layers $io_placer_hor_layer -ver_layers $io_placer_ver_layer

# Tapcell placement
tapcell -distance 14 -tapcell_master sky130_fd_sc_hd__tapvpwrvgnd_1

# Power distribution network
source ../third_party/OpenROAD-flow-scripts/tools/OpenROAD/test/sky130hd/sky130hd.pdn.tcl/
pdngen

# Global placement (skipping I/Os)
set_routing_layers -signal met1-met5 -clock met3-met5
set_macro_extension 2
global_placement -skip_io -routability_driven -density 0.3 

# I/O Placement
place_pins -hor_layers $io_placer_hor_layer -ver_layers $io_placer_ver_layer

# Re-run global placement
global_placement -routability_driven -density 0.3




# # # Buffer resizing
estimate_parasitics -placement

# # # report_metrics "resizer pre" false false
buffer_ports

repair_design

set tie sky130_fd_sc_hd__conb_1
set hi HI
set lo LO
set tielib [get_name [get_property [lindex [get_lib_cell $tie] 0] library]]
repair_tie_fanout $tielib/$tie/$hi
repair_tie_fanout $tielib/$tie/$lo 

write_db aes.db

}
exit