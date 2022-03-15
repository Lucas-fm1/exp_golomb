//==========================================================//
//	MODULE:   exp_gob.sv 			 		 
//	PORPOUSE: serial encode/decode of exponentional-golomb
//  AUTHOR:   Lucas Farias Martins	 	 
// 	DATE:     01-02-2019				 	 
//==========================================================//

`include "cod_expgob"
`include "decod_expgob"

module exp_gob
(
  input  logic       clk,
  input  logic       rst_n,
  input  logic [7:0] dt_i,
  output logic       cod_o,
  output logic [7:0] decod_o,
  output logic       busy_o
);

// -------------------- CONNECTING WIRES
logic [3:0] count;
logic [3:0] count_inc;
logic [3:0] count_dec;
logic       prc;
  
// ---------------------- INSTANTIATIONS
  
cod_expgob cod
(
	.clk     ( clk     ),
	.rst_n   ( rst_n   ),
	.dt_i    ( dt_i    ),
	.count   ( count   ),
	.cod_o   ( cod_o   ),
	.prc_o   ( prc     )
);

decod_expgob decod
(
	.clk     ( clk     ),
  .rst_n   ( rst_n   ),
  .cod_i   ( cod_o   ),
  .count   ( count   ),
  .prc_i   ( prc     ),
  .busy_i  ( busy_o  ),
  .decod_o ( decod_o )
);

// ----------- SOME COMBINATIONAL LOGIC
always_comb begin
  count_inc = count + 1;		// incremento do contador
  count_dec = count - 1;		// decremento do contador
  busy_o 	= (count!=4'hf);	// flag de término do programa
end

// ------------------------ THE COUNTER
always_ff @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		count <= '0;
	end else begin
      	if(!prc) count <= count_inc;	
    	else       count <= count_dec;
	end
end

endmodule