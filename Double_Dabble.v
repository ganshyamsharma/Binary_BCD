`timescale 1ns/1ns

module binary_to_bcd(
	input i_clk, i_reset,
	input [12:0] i_binary_data,	
	output reg [15:0] o_bcd_data 
);
	reg [12:0] r_binary_data;
	reg [3:0] r_bcd1_value, r_bcd2_value, r_bcd3_value, r_bcd4_value, r_conv_counter;
	reg r_conv_comp, r_bcd1_value_cmp, r_bcd2_value_cmp, r_bcd3_value_cmp, r_bcd4_value_cmp, r_bcd1_value_cmp_r, r_bcd2_value_cmp_r, r_bcd3_value_cmp_r, r_bcd4_value_cmp_r;
	
	always @(*) begin
		if(r_bcd1_value > 4 & r_bcd1_value_cmp_r == 0)
			r_bcd1_value_cmp = 1;
		else
			r_bcd1_value_cmp = 0;
		if(r_bcd2_value > 4 & r_bcd2_value_cmp_r == 0)
			r_bcd2_value_cmp = 1;
		else
			r_bcd2_value_cmp = 0;
		if(r_bcd3_value > 4 & r_bcd3_value_cmp_r == 0)
			r_bcd3_value_cmp = 1;
		else
			r_bcd3_value_cmp = 0;
		if(r_bcd4_value > 4 & r_bcd4_value_cmp_r == 0)
			r_bcd4_value_cmp = 1;
		else
			r_bcd4_value_cmp = 0;
	end
	
	always @(posedge i_clk) begin
		if(i_reset) begin
			r_binary_data <= 0;
			r_conv_comp <= 0;
			r_conv_counter <= 0;
			{r_bcd1_value,r_bcd2_value, r_bcd3_value, r_bcd4_value} <= 0;
		    {r_bcd1_value_cmp_r, r_bcd2_value_cmp_r, r_bcd3_value_cmp_r, r_bcd4_value_cmp_r} <= 4'd0;
		end
		else begin 		  
		  if(r_conv_comp == 1) begin
		      r_binary_data <= i_binary_data;
			  o_bcd_data <= {r_bcd4_value, r_bcd3_value, r_bcd2_value, r_bcd1_value};
			  r_conv_comp <= 0;
			  {r_bcd4_value, r_bcd3_value, r_bcd2_value, r_bcd1_value} <= 16'd0;
		  end
		  else if(r_conv_comp == 0) begin
		      if(r_bcd1_value_cmp == 0 & r_bcd2_value_cmp == 0 & r_bcd3_value_cmp == 0 & r_bcd4_value_cmp == 0) begin
		          r_binary_data <= {r_binary_data[11:0], 1'b0};
			      r_bcd1_value <= {r_bcd1_value[2:0], r_binary_data[12]};
			      r_bcd2_value <= {r_bcd2_value[2:0], r_bcd1_value[3]};
			      r_bcd3_value <= {r_bcd3_value[2:0], r_bcd2_value[3]};
				  r_bcd4_value <= {r_bcd4_value[2:0], r_bcd3_value[3]};
			      {r_bcd1_value_cmp_r, r_bcd2_value_cmp_r, r_bcd3_value_cmp_r, r_bcd4_value_cmp_r} <= 4'd0;
			      if(r_conv_counter == 12) begin
			         r_conv_counter <= 0;
			         r_conv_comp <= 1;
		          end
		          else
		              r_conv_counter <= r_conv_counter + 1;		      
			  end
			  if (r_bcd1_value_cmp == 1) begin
				  r_bcd1_value <= r_bcd1_value + 3;
				  r_bcd1_value_cmp_r <= 1;
			  end
			  if (r_bcd2_value_cmp == 1) begin
				  r_bcd2_value <= r_bcd2_value + 3;
				  r_bcd2_value_cmp_r <= 1;
			  end
			  if (r_bcd3_value_cmp == 1) begin
				  r_bcd3_value <= r_bcd3_value + 3;
				  r_bcd3_value_cmp_r <= 1;
			  end
			  if (r_bcd4_value_cmp == 1) begin
				  r_bcd4_value <= r_bcd4_value + 3;
				  r_bcd4_value_cmp_r <= 1;
			  end
		  end
        end
       end
endmodule
		