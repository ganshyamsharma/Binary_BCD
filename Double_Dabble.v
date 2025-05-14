
`timescale 1ns/1ns

module binary_to_bcd(
	input clk_1mhz, reset_ip,
	input [12:0] binary_data_ip,	//7:0
	output reg [15:0] bcd_data_op //11:0
);
	reg [12:0] ip_data;
	reg [3:0] st1, st2, st3, st4, conv_counter;
	reg conv_comp, st1_cmp, st2_cmp, st3_cmp, st4_cmp, st1_cmp_r, st2_cmp_r, st3_cmp_r, st4_cmp_r;
	
	always @(*) begin
		if(st1 > 4 & st1_cmp_r == 0)
			st1_cmp = 1;
		else
			st1_cmp = 0;
		if(st2 > 4 & st2_cmp_r == 0)
			st2_cmp = 1;
		else
			st2_cmp = 0;
		if(st3 > 4 & st3_cmp_r == 0)
			st3_cmp = 1;
		else
			st3_cmp = 0;
		if(st4 > 4 & st4_cmp_r == 0)
			st4_cmp = 1;
		else
			st4_cmp = 0;
	end
	
	always @(posedge clk_1mhz) begin
		if(reset_ip) begin
			ip_data <= 0;
			conv_comp <= 0;
			conv_counter <= 0;
			st1 <= 0;
			st2 <= 0;
			st3 <= 0;
			st4 <= 0;
		    {st1_cmp_r, st2_cmp_r, st3_cmp_r, st4_cmp_r} <= 4'd0;
		end
		else begin 		  
		  if(conv_comp == 1) begin
		      ip_data <= binary_data_ip;
			  bcd_data_op <= {st4, st3, st2, st1};
			  conv_comp <= 0;
			  {st4, st3, st2, st1} <= 16'd0;
		  end
		  else if(conv_comp == 0) begin
		      if(st1_cmp == 0 & st2_cmp == 0 & st3_cmp == 0 & st4_cmp == 0) begin
		          ip_data <= {ip_data[11:0], 1'b0};
			      st1 <= {st1[2:0], ip_data[12]};
			      st2 <= {st2[2:0], st1[3]};
			      st3 <= {st3[2:0], st2[3]};
				  st4 <= {st4[2:0], st3[3]};
			      {st1_cmp_r, st2_cmp_r, st3_cmp_r, st4_cmp_r} <= 4'd0;
			      if(conv_counter == 12) begin
			         conv_counter <= 0;
			         conv_comp <= 1;
		          end
		          else
		              conv_counter <= conv_counter + 1;		      
			  end
			  if (st1_cmp == 1) begin
				  st1 <= st1 + 3;
				  st1_cmp_r <= 1;
			  end
			  if (st2_cmp == 1) begin
				  st2 <= st2 + 3;
				  st2_cmp_r <= 1;
			  end
			  if (st3_cmp == 1) begin
				  st3 <= st3 + 3;
				  st3_cmp_r <= 1;
			  end
			  if (st4_cmp == 1) begin
				  st4 <= st4 + 3;
				  st4_cmp_r <= 1;
			  end
		  end
        end
       end
endmodule
		