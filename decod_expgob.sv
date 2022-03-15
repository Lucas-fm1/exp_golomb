module decod_expgob
(
  input  logic       clk,
  input  logic       rst_n,
  input  logic       cod_i,
  input  logic [3:0] count,
  input  logic       prc_i,
  input  logic       busy_i,
  output logic [7:0] decod_o
);

// -------------------- INNER SIGNALS
logic [7:0] decod_aux;  

// -------------- COMBINATIONAL LOGIC
assign decod_o = (busy_i==0) ? (decod_aux-1) : '0;

// ----------------- SEQUENTIAL LOGIC
always_ff @(posedge clk or negedge rst_n) begin
  if(~rst_n) begin
    decod_aux <= '0;
  end else begin
    if(prc_i)
      decod_aux[count] = cod_i;
  end
end
  
endmodule