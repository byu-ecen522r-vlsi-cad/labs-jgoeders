set db_file aes.db

if { [file exists $db_file] == 1} {   
    read_db $db_file
} else {
    read_lef /fsj/jgoeders/labs-jgoeders/third_party/OpenROAD-flow-scripts/flow/platforms/sky130hd/lef/sky130_fd_sc_hd_merged.lef
    read_verilog aes_synth.v

    link_design aes_cipher_top

    write_db aes.db
}


initialize_floorplan -utilization 0.5