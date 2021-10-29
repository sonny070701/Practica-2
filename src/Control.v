/******************************************************************
* Description
*	This is control unit for the RISC-V Microprocessor. The control unit is 
*	in charge of generation of the control signals. Its only input 
*	corresponds to opcode from the instruction bus.
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	16/08/2021
******************************************************************/
module Control
(
	input [6:0]OP_i,
	
	
	output Branch_o,
	output Mem_Read_o,
	output Mem_to_Reg_o,
	output Mem_Write_o,
	output ALU_Src_o,
	output Reg_Write_o,
	output [2:0]ALU_Op_o,
	output jal_o,
	output jalr_o
);
 
localparam R_Type			 = 7'h33;  //R
localparam I_Type_LOGIC  = 7'h13;  //I logicas
localparam U_Type        = 7'h37;  //LUI
localparam B_Type		    = 7'h63;  //BRANCHES
localparam S_Type		    = 7'h23;  // S types -> SW
localparam I_Type_L		 = 7'h03;  // LW
localparam J_Type		    = 7'h6F;  //JAL
localparam I_Type_J  	 = 7'h67;  //JALR


reg [10:0] control_values;

always@(OP_i) begin
	case(OP_i)//                          		  876_54_3_210
									
		
		R_Type:				control_values=11'b0_0_001_00_0_000;  // R
		
		I_Type_LOGIC:		control_values=11'b0_0_001_00_1_001;  // I logicas
		
		U_Type:				control_values=11'b0_0_001_00_1_010;  // LUI
		
		B_Type:				control_values=11'b0_0_100_00_0_011;  // BRANCHES
		
		S_Type:				control_values=11'b0_0_010_01_1_100;  // SW
		
		I_Type_L:			control_values=11'b0_0_011_10_1_101;  // LW
		
		J_Type:				control_values=11'b0_1_101_00_1_110;  // JAL	
		
		I_Type_J:			control_values=11'b1_1_001_00_1_111;  // JALR
		
		default:
			control_values= 10'b0_000_00_000;
		endcase
end	

assign jalr_o = control_values[10];

assign jal_o = control_values[9];

assign Branch_o = control_values[8];

assign Mem_to_Reg_o = control_values[7];

assign Reg_Write_o = control_values[6];

assign Mem_Read_o = control_values[5];

assign Mem_Write_o = control_values[4];

assign ALU_Src_o = control_values[3];

assign ALU_Op_o = control_values[2:0];	

endmodule


