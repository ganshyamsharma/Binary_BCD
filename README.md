# Binary Number to BCD Converter
Synthesizable Verilog code to convert a binary number into bcd using the Double Dabble algorithm.
## I/O Description
- i_clk: Input clock
- i_reset: Reset input to reset the conversion process.
- i_binary_data: Binary data (maximum 13 bits) which is required to be converted into corresponding BCD value.
- o_bcd_data: 16 bit (four digits) BCD value of the converted binary input <br>
<br> **The conversion process takes a total of 13 clock cycles for complete conversion.** <br>
<br> The module is tested at a clock frequency of 100Mhz on the Basys-3 development board.
