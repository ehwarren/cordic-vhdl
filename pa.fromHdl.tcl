
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name CORDIC -dir "M:/441/cordic-vhdl/planAhead_run_2" -part xc3s500efg320-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "CORDIC.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {ROM.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {RegisterBank.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {Controller.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ALU.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {CORDIC.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top CORDIC $srcset
add_files [list {CORDIC.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s500efg320-4
