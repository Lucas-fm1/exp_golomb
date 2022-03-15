//==========================================================//
//	MODULE:   tb_expgob.sv                                  
//	PORPOUSE: testbench for exp_gob.sv 
//  AUTHOR: 	Lucas Farias Martins	
// 	DATE: 	  02/01/2019	
//==========================================================//

module tb_expgob;

logic       clk;
logic       rst_n;
logic [7:0]	dt_i;
logic [7:0] decod_o;
logic     	cod_o;
logic       busy_o;

// ========================================
//             INSTANTIATION
// ========================================
exp_gob exp
(
  .clk      ( clk     ),
  .rst_n    ( rst_n   ),
  .dt_i     ( dt_i    ),
  .decod_o  ( decod_o ),
  .cod_o    ( cod_o   ),
  .busy_o   ( busy_o  )
);

// ========================================
//                INITIAL
// ========================================
initial begin

  $dumpfile("dump.vcd"); $dumpvars; 
  $display("\t _______________________________________________ ");
  $display("\t|                                               |");
  $display("\t|             WELCOME TO THE TEST               |");
  $display("\t|_______________________________________________|");
  $display("\n\t * For the following module, it was considered the ");
  $display("\t   Exp-Golomb codification Exp-Golomb with k = 0");
  $display("\n\t   Consult: \n\t   https://en.wikipedia.org/wiki/Exponential-Golomb_coding\n");
  
  								 display;

  $display("\n\t _____________________________________________ ");
  $display("\t|                                             |");
  $display("\t|  ############## END OF TESTS #############  |");
  $display("\t|_____________________________________________|\n");
end

// ========================================
//            TASKS & FUNCTIONS
// ========================================

task rst_stimuli;
  #10ns clk = 1;
  #10ns rst_n = 0;
  #10ns rst_n = 1;
endtask : rst_stimuli

task clock(int i);
  repeat(i)
    #10ns clk = ~clk;
    #10ns clk = ~clk;
endtask : clock

task display;
  for(int i=0;i<256;i++) begin
    dt_i = i;
    rst_stimuli;
    $display("\n========== TESTE dt_i = %0d (%b) ========== ", dt_i, dt_i);
    
    while(busy_o) begin
        clock(1);
      if(busy_o) $display("> cod_o = %0d", cod_o);
    end

    $display("- DECODIFICAÇÃO: decod_o = %b (%0d)", decod_o, decod_o);
  end
endtask : display

endmodule