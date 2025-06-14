module termProject(
   input clearEntry, 
	input clock,
   input [3:0] row,
   input  clearAll,
   output HEX3_g, 
   output [0:6] HEX0, HEX1, HEX2,
   output [3:0] col,
   output [9:0] LEDR
	//output [4:0] test
); 


//Z = output, S=select, A=IU, B=AU

// Wires for interconnecting modules
wire loadA, loadB, loadR, AddSubtract;
wire [3:0] value;
wire reset_signal;
wire [7:0] TC;
wire IUAU;
//wire [7:0] rout;
wire [7:0] finalout;
wire [3:0] fout;
wire [7:0] Rout;  // Result from ArithmeticUnit
wire [3:0] Flags_sig; // Flags from ArithmeticUnit
wire [7:0] TC_Final;
wire clearout;
wire trig;

// LEDR assignments
assign LEDR[9] = fout[2]; //overflow
assign LEDR[8] = fout[0]; //zero

// Control Unit
ControlUnit ControlUnit_inst 
(
   .ClearAll(clearAll),         // input ClearAll_sig
   .Clock(clock),               // input Clock_sig
   .value(value),               // input [N-1:0] value_sig
   .reset(reset_signal),               // output reset_sig
   .LoadA(loadA),               // output LoadA_sig
   .LoadB(loadB),               // output LoadB_sig
   .LoadR(loadR),               // output LoadR_sig
   .AddSub(AddSubtract),        // output AddSub_sig
   .IUAU(IUAU),                 // output IUAU_sig
	.trig(trig),
	//.ClearEntry(clearEntry)
);

//assign test = {reset_signal, loadA, loadB, loadR, IUAU};


//New Control Unit 
//ControlUnit ControlUnit_inst
//(
	//.ClearEntry_signal(clearEntry) ,	// input  ClearEntry_sig
	//.ClearAll(clearAll) ,	// input  ClearAll_sig
	//.Clock(clock) ,	// input  Clock_sig
	//.value(value) ,	// input [N-1:0] value_sig
	//.trig(trig_sig) ,	// input  trig_sig
	//.reset(reset_signal) ,	// output  reset_sig
	//.LoadA(LoadA) ,	// output  LoadA_sig
	//.LoadB(LoadB) ,	// output  LoadB_sig
	//.LoadR(LoadR) ,	// output  LoadR_sig
	//.AddSub(AddSubtract) ,	// output  AddSub_sig
	//.IUAU(IUAU) 	// output  IUAU_sig
//);


// Input Unit
inputUnit inputUnit_inst (
   .row(row),                   // input [3:0] row_sig
   .clock(clock),               // input clock_sig
   .clear(reset_signal & clearEntry),  // input clear_sig
   .col(col),                   // output [3:0] col_sig
   .value(value),               // output [3:0] value_sig
   .LEDR(TC) ,                     // output [7:0] TC_sig
	//.valid (LEDR[0])           //output 
	.trig(trig)
);

// Arithmetic Unit
ArithmeticUnit ArithmeticUnit_inst (
   .X(TC),                      // input [7:0] X_sig
   .InA(loadA),                 // input InA_sig
   .InB(loadB),                 // input InB_sig
   .Out( loadR),                 // input Out_sig
   .Clear(clearAll),            // input Clear_sig
   .Add_Subtract(AddSubtract),  // input Add_Subtract_sig
   .Result(Rout),             // output [7:0] Result_sig
   .Flags(fout[3:0])            // output [3:0] Flags_sig
	//.hex
	
);

// Output Unit
OutputUnit OutputUnit_inst (
   .A(TC_Final),                  // input [N-1:0] A_sig
   .HEX3_g(HEX3_g),             // output HEX3_g_sig
   .HEX0(HEX0),                 // output [0:6] HEX0_sig
   .HEX1(HEX1),                 // output [0:6] HEX1_sig
   .HEX2(HEX2)                  // output [0:6] HEX2_sig
);
defparam OutputUnit_inst.N = 8;

mux mux_inst
(
	.A(TC) ,	// input  A_sig
	.B(Rout) ,	// input  B_sig
	.S(IUAU) ,	// input  S_sig
	.Z(TC_Final) 	// output  Z_sig
);

endmodule
