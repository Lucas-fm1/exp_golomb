module cod_expgob
(
	input  logic 	   	clk,
	input  logic 	   	rst_n,
	input  logic [7:0] 	dt_i,
	input  logic [3:0] 	count,
	output logic 		cod_o,
	output logic 		prc_o
);

// -------------------- INNER SIGNALS
logic [7:0] dt_inc;
logic [7:0]	aux_cod;

// -------------- COMBINATIONAL LOGIC
always_comb begin
	prc_o  = (aux_cod==dt_inc);           // stop sending zeros
	dt_inc = dt_i + 1;                    // valid data to encode
	cod_o  = (prc_o)?(dt_inc[count]):(0)  // encode logic (output)
end

// ----------------- SEQUENTIAL LOGIC
always_ff @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		if(dt_inc[0]==0)
			aux_cod <= 8'b0000_0000;
		else
			aux_cod <= 8'b0000_0001;
	end else begin
		if(!prc_o)	aux_cod[count+1] <= dt_inc[count+1];
	end
end
  
endmodule