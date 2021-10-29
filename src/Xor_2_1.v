module Xor_2_1
(
	input A,
	input B,
	
	output reg C

);

	always@(*) begin
		C = A^B;
	end

endmodule