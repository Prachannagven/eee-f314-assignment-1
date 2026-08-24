set_property PACKAGE_PIN H16 [get_ports i_clk]
set_property PACKAGE_PIN L19 [get_ports i_rst]
set_property PACKAGE_PIN M14 [get_ports o_current_val]
set_property PACKAGE_PIN G17 [get_ports o_pattern_valid]
set_property PACKAGE_PIN R14 [get_ports o_clk_slow]


set_property IOSTANDARD LVCMOS33 [get_ports i_clk]
set_property IOSTANDARD LVCMOS33 [get_ports i_rst]
set_property IOSTANDARD LVCMOS33 [get_ports o_current_val]
set_property IOSTANDARD LVCMOS33 [get_ports o_pattern_valid]
set_property IOSTANDARD LVCMOS33 [get_ports o_clk_slow]


create_clock -period 8.000 -name clk -waveform {0.000 4.000} -add i_clk

