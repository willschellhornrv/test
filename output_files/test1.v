module register_file(out_data, in_data, address, enable, clk, reset);

	// 2^10 inputs, so 1024 indices
	input in_data;
	input [9:0] address;
	output out_data;
	input enable, clk, reset;
	
	
	

endmodule


module mux(out_data, in_data, address);
	output out_data;
	reg out_data;
	
	input in_data[0:1023];
	
	input [9:0] address;
	
	always out_data <= in_data[address];

endmodule
