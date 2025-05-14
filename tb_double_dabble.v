`timescale 1ns/1ns

module tb();
	reg clk_1mhz_tb, rst_tb;
	reg [12:0] binary_data_ip_tb;
	wire [15:0] bcd_data_op_tb;
	always #5 clk_1mhz_tb = ~clk_1mhz_tb;
	initial begin
		binary_data_ip_tb = 8000;
		clk_1mhz_tb = 0;
		rst_tb = 1;
		#10
		rst_tb = 0;
		//#220
		//binary_data_ip_tb = 77;
	end
	binary_to_bcd uut0(clk_1mhz_tb, rst_tb, binary_data_ip_tb, bcd_data_op_tb);
endmodule