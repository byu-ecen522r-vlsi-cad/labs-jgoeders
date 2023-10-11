
set io_placer_hor_layer met3
set io_placer_ver_layer met2


set db_file aes.db

if { [file exists $db_file] == 1} {   
    read_db $db_file
} else {


    read_lef ../third_party/OpenROAD-flow-scripts/flow/platforms/sky130hd/lef/sky130_fd_sc_hd.tlef

    read_lef ../third_party/OpenROAD-flow-scripts/flow/platforms/sky130hd/lef/sky130io_fill.lef

    read_lef ../third_party/OpenROAD-flow-scripts/flow/platforms/sky130hd/lef/sky130_fd_sc_hd_merged.lef

    read_liberty ../third_party/OpenROAD-flow-scripts/flow/platforms/sky130hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    
    read_verilog aes_synth.v

    link_design aes_cipher_top



initialize_floorplan -utilization 0.5

make_tracks li1  -x_offset 0.23 -x_pitch 0.46 -y_offset 0.17 -y_pitch 0.34
make_tracks met1 -x_offset 0.17 -x_pitch 0.34 -y_offset 0.17 -y_pitch 0.34
make_tracks met2 -x_offset 0.23 -x_pitch 0.46 -y_offset 0.23 -y_pitch 0.46
make_tracks met3 -x_offset 0.34 -x_pitch 0.68 -y_offset 0.34 -y_pitch 0.68
make_tracks met4 -x_offset 0.46 -x_pitch 0.92 -y_offset 0.46 -y_pitch 0.92
make_tracks met5 -x_offset 1.70 -x_pitch 3.40 -y_offset 1.70 -y_pitch 3.40

remove_buffers

place_pins -random -hor_layers $io_placer_hor_layer -ver_layers $io_placer_ver_layer


# tapcell -distance 14 -tapcell_master sky130_fd_sc_hd__tapvpwrvgnd_1

source ../third_party/OpenROAD-flow-scripts/tools/OpenROAD/test/sky130hd/sky130hd.pdn.tcl/
pdngen

write_db aes.db
}


# set global_routing_layer_adjustments {{met1 0.5} {met2 0.5} {met3 0.5} {met4 0.5} {met5 0.5}}
# foreach layer_adjustment $global_routing_layer_adjustments {
#   lassign $layer_adjustment layer adjustment
#   set_global_routing_layer_adjustment $layer $adjustment
# }

set_routing_layers -signal met1-met5 -clock met3-met5
# set_macro_extension 2

global_placement -routability_driven -density 0.5
gui::show