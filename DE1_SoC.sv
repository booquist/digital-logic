module DE1_SoC (CLOCK_50, SW, LEDR, KEY, HEX0);
	input logic CLOCK_50; 
	input logic [9:0] SW;
	input logic [3:0] KEY;
	output logic [9:0] LEDR;
	output logic [6:0] HEX0;
	wire right, left;
	wire player1Win, player2Win;
	
	button player2 (.clk(CLOCK_50) , .Reset(SW[9]), .pressed(~KEY[3]), .set(left));
	button player1 (.clk(CLOCK_50) , .Reset(SW[9]), .pressed(~KEY[0]), .set(right));
	
	// Define our edge, normal, and center lights
	right_edge_light rightL(.clk(CLOCK_50), .Reset(SW[9]), .leftLight(LEDR[2]), .leftButton(left), .rightButton(right), .light(LEDR[1]), .playerWin(player1Win));
	
	normal_light norm1(.clk(CLOCK_50), .Reset(SW[9]), .leftLight(LEDR[3]), .rightLight(LEDR[1]), .leftButton(left), .rightButton(right), .light(LEDR[2]));
	normal_light norm2(.clk(CLOCK_50), .Reset(SW[9]), .leftLight(LEDR[4]), .rightLight(LEDR[2]), .leftButton(left), .rightButton(right), .light(LEDR[3]));
	normal_light norm3(.clk(CLOCK_50), .Reset(SW[9]), .leftLight(LEDR[5]), .rightLight(LEDR[3]), .leftButton(left), .rightButton(right), .light(LEDR[4]));
	
	center_light centL(.clk(CLOCK_50), .Reset(SW[9]), .leftLight(LEDR[6]), .rightLight(LEDR[4]), .leftButton(left), .rightButton(right), .light(LEDR[5]));
	
	normal_light norm4(.clk(CLOCK_50), .Reset(SW[9]), .leftLight(LEDR[7]), .rightLight(LEDR[5]), .leftButton(left), .rightButton(right), .light(LEDR[6]));
	normal_light norm5(.clk(CLOCK_50), .Reset(SW[9]), .leftLight(LEDR[8]), .rightLight(LEDR[6]), .leftButton(left), .rightButton(right), .light(LEDR[7]));
	normal_light norm6(.clk(CLOCK_50), .Reset(SW[9]), .leftLight(LEDR[9]), .rightLight(LEDR[7]), .leftButton(left), .rightButton(right), .light(LEDR[8]));
	
	left_edge_light leftL(.clk(CLOCK_50), .Reset(SW[9]), .rightLight(LEDR[8]), .leftButton(left), .rightButton(right), .light(LEDR[9]), .playerWin(player2Win));
	
	always_comb begin 
		if(player1Win & ~player2Win)
			HEX0 = 7'b0100100;
		else if(~player1Win & player2Win)
			HEX0 = 7'b1111001;
		else
			HEX0 = 7'b1111111;
	end
	
endmodule