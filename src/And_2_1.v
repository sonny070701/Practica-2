/******************************************************************
* Description
*	This is an AND gate
*	1.0

******************************************************************/

module And_2_1
(
	input A,
	input B,
	
	output reg C

);

	always@(*) begin
		C = A&B;
	end

endmodule