module left_edge_light (
	input logic clk, Reset, rightLight, leftButton, rightButton,
	output logic light,
	output logic playerWin
);

	logic PS, NS;
	logic PS_Win, NS_Win;
		
	parameter off = 1'b0, on = 1'b1;
	
	//Keep track of player 2 win or not win
	parameter win = 1'b1, not_win = 1'b0;

	// while
	always_comb begin
		case(PS)
			off:	if (rightLight & leftButton) NS = on;           
					else NS = off;
			on:	if (rightButton | leftButton) NS = off;
					else NS = on;
			default: NS = 1'bx;	
		endcase
	end
	
	always_comb begin 
		case(PS_Win)
			not_win: if(light & leftButton) NS_Win = win;
						else NS_Win = not_win;
			win: 		NS_Win = win;
			default: NS_Win = not_win;
		endcase
	end

	// reset
	// Diff from center_light, should turn off
	always @(posedge clk)
		if (Reset) begin
			PS <= off; // reset should turn the light off
			PS_Win <= not_win;
		end
		else begin
			PS_Win <= NS_Win;
			PS <= NS;
		end
			
	assign light = PS;
	assign playerWin = PS_Win;

endmodule


module left_edge_light_testbench();
	logic clk, Reset, rightLight, leftButton, rightButton;
	logic light;
	logic [6:0] playerWin;
	
	left_edge_light test (clk, Reset, rightLight, leftButton, rightButton, light, playerWin);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
  
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		Reset <= 1;
		rightLight <=0;
		leftButton <=0;
		rightButton <= 0;
		light <= 0;
		@(posedge clk);
		@(posedge clk); // Always reset FSMs at start
		Reset <= 0;
		rightLight <= 1;
		@(posedge clk);
		@(posedge clk);
		leftButton <= 1;
		@(posedge clk);
		rightLight <= 0;
		@(posedge clk);
		@(posedge clk);
		leftButton <= 0;
		@(posedge clk);
		leftButton <= 0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		Reset <= 1;
		@(posedge clk);
		@(posedge clk);
		$stop; // End the simulation.
	end
endmodule

	
	