set_property PACKAGE_PIN H16 [get_ports i_clk]
set_property PACKAGE_PIN L19 [get_ports i_user_btn]
set_property PACKAGE_PIN D19 [get_ports i_rst]
set_property PACKAGE_PIN G17 [get_ports o_pwd_valid]
set_property PACKAGE_PIN N15 [get_ports o_pwd_invalid]
set_property PACKAGE_PIN M15 [get_ports o_lockout]
set_property PACKAGE_PIN R14 [get_ports o_clk]

set_property IOSTANDARD LVCMOS33 [get_ports i_clk]
set_property IOSTANDARD LVCMOS33 [get_ports i_user_btn]
set_property IOSTANDARD LVCMOS33 [get_ports i_rst]
set_property IOSTANDARD LVCMOS33 [get_ports o_pwd_valid]
set_property IOSTANDARD LVCMOS33 [get_ports o_pwd_invalid]
set_property IOSTANDARD LVCMOS33 [get_ports o_lockout]
set_property IOSTANDARD LVCMOS33 [get_ports o_clk]

create_clock -period 8.000 -name clk -waveform {0.000 4.000} -add i_clk

