set db_file aes.db

if { [file exists $db_file] == 1} {   
    read_db $db_file
} else {


    read_lef ../third_party/OpenROAD-flow-scripts/flow/platforms/sky130hd/lef/sky130_fd_sc_hd.tlef

    # read_lef ../third_party/OpenROAD-flow-scripts/tools/OpenROAD/test/sky130hd/sky130hd.tlef

    read_lef ../third_party/OpenROAD-flow-scripts/flow/platforms/sky130hd/lef/sky130io_fill.lef


    read_lef ../third_party/OpenROAD-flow-scripts/flow/platforms/sky130hd/lef/sky130_fd_sc_hd_merged.lef

    read_liberty ../third_party/OpenROAD-flow-scripts/flow/platforms/sky130hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

    # read_lib ../third_party/OpenROAD-flow-scripts/flow/platforms/sky130hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    # read_lef ../third_party/OpenROAD-flow-scripts/flow/platforms/sky130hd/lef/sky130_fd_sc_hd_merged.lef
    # read_lef ../third_party/OpenROAD-flow-scripts/flow/platforms/sky130hd/lef/sky130_fd_sc_hd.tlef
    
    read_verilog aes_synth.v

    link_design aes_cipher_top

    # write_db aes.db
}


initialize_floorplan -utilization 0.5