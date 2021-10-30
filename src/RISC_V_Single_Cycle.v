/******************************************************************
* Description
*	This is the top-level of a RISC-V Microprocessor that can execute the next set of instructions:
*		add
*		addi
* This processor is written Verilog-HDL. It is synthesizabled into hardware.
* Parameter MEMORY_DEPTH configures the program memory to allocate the program to
* be executed. If the size of the program changes, thus, MEMORY_DEPTH must change.
* This processor was made for computer organization class at ITESO.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	16/08/2021
******************************************************************/

module RISC_V_Single_Cycle
#(
	parameter PROGRAM_MEMORY_DEPTH = 256, 
	parameter DATA_WIDTH = 32,
	parameter DATA_MEMORY_DEPTH = 256
)

(
	// Inputs
	input clk,
	input reset,
	
	output[31:0] alu_result

);
//******************************************************************/
//******************************************************************/

//******************************************************************/
//******************************************************************/
/* Signals to connect modules*/

/*AND*/
wire and_W;
wire Xor_w;

/**Control**/
wire alu_src_w;
wire reg_write_w;
wire mem_to_reg_w;
wire mem_write_w;
wire mem_read_w;
wire [2:0] alu_op_w;
wire jal_o_w;
wire jalr_o_w;

/** Program Counter**/

wire [31:0] pc_plus_4_w;
wire [31:0] pc_w;
//para adder branch
wire [31:0] pc_plus_i_w;
// wire mux pc
wire [31:0] pc_Mux_w;

/**Register File**/
wire [31:0] read_data_1_w;
wire [31:0] read_data_2_w;
wire branch_w;

/**Inmmediate Unit**/
wire [31:0] inmmediate_data_w;

/**ALU**/
wire [31:0] alu_result_w;

/**Multiplexer MUX_DATA_OR_IMM_FOR_ALU**/
wire [31:0] read_data_2_or_imm_w;

/**ALU Control**/
wire [3:0] alu_operation_w;
wire zero_w;

/**Instruction Bus**/	
wire [31:0] instruction_bus_w;

/*mem to mux*/
wire [31:0] mem_to_mux_w;

/*mux de mem a register file*/
wire [31:0] mux_to_reg_f_w;

/*MUX A ALU PC*/
wire [31:0] mux_to_ALU_w;

/* wire Mux a adder i*/
wire [31:0] pc_new_w;

//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Control
CONTROL_UNIT
(
	/****/
	.OP_i(instruction_bus_w[6:0]),
	/** outputus**/
	.ALU_Op_o(alu_op_w),
	.ALU_Src_o(alu_src_w),
	.Reg_Write_o(reg_write_w),
	.Mem_to_Reg_o(mem_to_reg_w),
	.Mem_Read_o(mem_read_w),
	.Mem_Write_o(mem_write_w),
	.Branch_o(branch_w),
	.jal_o(jal_o_w),
	.jalr_o(jalr_o_w)
);

PC_Register
PROGRAM_COUNTER
(
	.clk(clk),
	.reset(reset),
	.Next_PC(pc_Mux_w),
	.PC_Value(pc_w)
);

Program_Memory
#(
	.MEMORY_DEPTH(PROGRAM_MEMORY_DEPTH)
)

PROGRAM_MEMORY
(
	.Address_i(pc_w),
	.Instruction_o(instruction_bus_w)
);



Adder_32_Bits
PC_PLUS_4
(
	.Data0(pc_w),
	.Data1(4),
	
	.Result(pc_plus_4_w)
);

Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_Adder_PC_RS_Immediate
(
	.Selector_i(jalr_o_w),
	.Mux_Data_0_i(pc_w),
	.Mux_Data_1_i(read_data_1_w),
	
	.Mux_Output_o(pc_new_w)

);

Adder_32_Bits
PC_PLUS_I
(
	.Data0(pc_new_w),
	.Data1(inmmediate_data_w),
	
	.Result(pc_plus_i_w)
);


Multiplexer_2_to_1
#(
	.NBits(32)
)

MUX_DATA_PC
(
	.Selector_i(Xor_w),
	.Mux_Data_0_i(pc_plus_4_w),
	.Mux_Data_1_i(pc_plus_i_w),
	
	.Mux_Output_o(pc_Mux_w)

);

And_2_1
AND_B
(
	.A(zero_w),
	.B(branch_w),
	
	.C(and_W)	//output

);

Xor_2_1
XOR_chido
(
	.A(and_W),
	.B(jal_o_w),
	
	.C(Xor_w)

);
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/

Register_File
REGISTER_FILE_UNIT
(
	.clk(clk),
	.reset(reset),
	.Reg_Write_i(reg_write_w),
	.Write_Register_i(instruction_bus_w[11:7]),
	.Read_Register_1_i(instruction_bus_w[19:15]),
	.Read_Register_2_i(instruction_bus_w[24:20]),
	.Write_Data_i(mux_to_reg_f_w),
	.Read_Data_1_o(read_data_1_w),
	.Read_Data_2_o(read_data_2_w)

);


Immediate_Unit
IMM_UNIT
(  .op_i(instruction_bus_w[6:0]),
   .Instruction_bus_i(instruction_bus_w),
   .Immediate_o(inmmediate_data_w)
);


Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_DATA_OR_IMM_FOR_ALU
(
	.Selector_i(alu_src_w),
	.Mux_Data_0_i(read_data_2_w),
	.Mux_Data_1_i(inmmediate_data_w),
	
	.Mux_Output_o(read_data_2_or_imm_w)

);


ALU_Control
ALU_CONTROL_UNIT
(
	.funct7_i(instruction_bus_w[30]),
	.ALU_Op_i(alu_op_w),
	.funct3_i(instruction_bus_w[14:12]),
	.ALU_Operation_o(alu_operation_w)

);

Data_Memory
#(
	.DATA_WIDTH(DATA_WIDTH),
	.MEMORY_DEPTH(DATA_MEMORY_DEPTH)
)

Data_Memory
(
	.Write_Data_i(read_data_2_w),
	.Address_i(alu_result_w),
	.Mem_Write_i(mem_write_w),
	.Mem_Read_i(mem_read_w),
	.clk(clk),
	.Read_Data_o(mem_to_mux_w)	//output
);

Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_DATA_WB
(
	.Selector_i(mem_to_reg_w),
	.Mux_Data_0_i(alu_result_w),
	.Mux_Data_1_i(mem_to_mux_w),
	
	.Mux_Output_o(mux_to_reg_f_w)

);


ALU
ALU_UNIT
(
	.ALU_Operation_i(alu_operation_w),
	.A_i(mux_to_ALU_w),
	.B_i(read_data_2_or_imm_w),
	.ALU_Result_o(alu_result_w),
	.Zero_o(zero_w)
);


Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_PC_RD1
(
	.Selector_i(jal_o_w),
	.Mux_Data_0_i(read_data_1_w),
	.Mux_Data_1_i(pc_plus_4_w),
	
	.Mux_Output_o(mux_to_ALU_w)

);

assign alu_result = alu_result_w;
endmodule
