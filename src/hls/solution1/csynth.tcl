############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
############################################################
open_project Cordic_hls
set_top Cordic
add_files Cordic_hls/testbench.cpp
add_files Cordic_hls/Cordic_Float.h
add_files Cordic_hls/Cordic_Float.cpp
add_files -tb Cordic_hls/testbench.cpp
add_files -tb Cordic_hls/datos_entrada.txt
add_files -tb Cordic_hls/Dataset_manual.txt
add_files -tb Cordic_hls/Dataset.txt
open_solution "solution1"
set_part {xc7z020clg484-1}
create_clock -period 10 -name default
source "./Cordic_hls/solution1/directives.tcl"
csynth_design
