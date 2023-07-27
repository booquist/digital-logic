module button (
	input logic clk, Reset, pressed,
	output logic set
);
		logic [1:0] PS, NS;
		parameter [1:0] on = 2'b00, hold = 2'b01, off = 2'b10;
		
		always_comb begin
			case(PS)
				on:	if(pressed) NS = hold;
						else NS = off;
				hold: if(pressed) NS = hold;
						else NS = off;
				off:	if(pressed) NS = on;
						else NS = off;
				default: 	NS = off;
			endcase
		end
		
		always_comb begin
			case(PS)
				on: set = 1;
				hold: set = 0;
				off: set = 0;
				default: set = 0;
			endcase
		end
		
		always_ff @(posedge clk) begin
		  if (Reset) 
			PS <= off;
		  else
			PS <= NS;
		end
				
		
endmodule

module button_testbench();
	logic clk, Reset, pressed;
	logic set;
	
	button test(clk, Reset, pressed, set);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
  
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		Reset <= 1;
		@(posedge clk);
		Reset <= 0;
		pressed <= 1;
		@(posedge clk); // Always reset FSMs at start
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		pressed <= 0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		pressed <= 1;
		@(posedge clk);
		pressed <= 0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		$stop; // End the simulation.
	end
endmodule
