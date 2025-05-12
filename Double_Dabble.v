
module binary_to_bcd(
	input clk, reset,
	input [7:0] binary_data,
	output reg [11:0] bcd_data
);
	reg [7:0] ip_data;
	reg [3:0] st1, st2, st3, conv_counter;
	reg conv_comp, st1_cmp, st2_cmp, st3_cmp;
	
	always @(*) begin
		if(st1 > 4)
			st1_cmp = 1;
		else
			st1_cmp = 0;
		if(st2 > 4)
			st2_cmp = 1;
		else
			st2_cmp = 0;
		if(st3 > 4)
			st3_cmp = 1;
		else
			st3_cmp = 0;
	end
	
	always @(posedge clk) begin
		if(reset) begin
			ip_data <= 0;
			conv_comp <= 0;
			conv_counter <= 0;
			st1 <= 0;
			st2 <= 0;
			st3 <= 0;
		end
		else if(conv_comp == 1) begin
			ip_data <= binary data;
			bcd_data <= {st3, st2, st1};
			conv_comp <= 0;
		end
		else
			ip_data <= ip_data;
	end
	
	always @(posedge clk) begin
		if(st1_cmp == 0 & st2_cmp == 0 & st3_cmp == 0) begin
			if(conv_counter == 11) begin
				conv_counter <= 0;
				conv_comp <= 1;
			end
			else begin
				conv_counter <= conv_counter + 1;
				conv_comp <= 0;
			end
			ip_data <= {ip_data[6:0], 1'b0};
			st1 <= {st1[2:0], ip_data[7]};
			st2 <= {st2[2:0], st1[3]};
			st3 <= {st3[2:0], st2[3]};
		end
		else begin
			if (st1_cmp == 1)
				st1 <= st1 + 3;
			if (st2_cmp == 1)
				st2 <= st2 + 3;
			if (st3_cmp == 1)
				st3 <= st3 + 3;
		end
	end
endmodule
		
		