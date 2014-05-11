module test (LEDR, LEDG, HEX_out, SW, other_displays, LEDG2, push_butt, state);
input [9:0] SW; // enter binary number in switches
output [9:0] LEDR; // will indicate binary input
output LEDG; // will represent whether number's prime or not
output [6:0] HEX_out;  // output to the 7 segment display
output other_displays; // output to disable other displays





	// state counter -- state 0 is receiving first prime
	//						state 1 is receiving second prime
	output [1:0] state;
	reg [1:0] state_counter;
	assign state = state_counter;


	// button to store primes, green light indicates when pressed
	input push_butt;
	output LEDG2;
	assign LEDG2 = ~push_butt;


	always @ (negedge push_butt) begin
		state_counter = state_counter + 1;
	end
	

	// storage for primes
	reg [9:0] prime0, prime1;
	always @ (negedge push_butt) begin
		if (state_counter == 0) begin
			prime0 <= SW;
		end
		else if (state_counter == 1) begin
			prime1 <= SW;
		end
	end


	// green led indicates whether prime or not
	wire rom_out;
	assign LEDG = rom_out;
	rom_file bob(rom_out, SW);


	// 7 segment display follows prime led
	// Y for prime, N for not prime
	wire [6:0] hex_dude;
	sevsegdriver john(hex_dude, rom_out);
	assign HEX_out = hex_dude;

	// turn off other displays
	assign other_displays = 1'b0; // for some reason, it's an active low

	
	// red switches show binary input
	reg [9:0] out_first_prime, out_second_prime;
	assign LEDR = (SW | out_first_prime | out_second_prime);
	
	// display states (show user what they entered) -- states 2 and 3
	always @ (negedge push_butt) begin
	if (state_counter == 2) begin
		out_first_prime <= prime0;
		end
	else if (state_counter == 3) begin
		out_first_prime <= 10'b0;
		out_second_prime <= prime1;
		end
	end
		
endmodule