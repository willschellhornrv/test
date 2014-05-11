module sevsegdriver(hex_out, prime);
	
	input prime;
	output [6:0] hex_out;
	reg 	[6:0] hex_out;

always @ (prime or ~prime) begin 
		if (prime) begin
			hex_out = ~7'b1101110;
			end
		else begin
			hex_out = ~7'b0110111;
			end
		end 
endmodule
