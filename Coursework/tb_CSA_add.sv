/////////////////////////////////////////////////////////////////////
// Design unit: CSA_add testbench
//            :
// File name  : tb_CSA_add.sv
//            :
// Author     : tjb2g11@ecs.soton.ac.uk
/////////////////////////////////////////////////////////////////////

module tb_CSA_add;
  
  logic [15:0] VS_x, VC_x, VS_y, VC_y;
  logic add_sub, data_in, reset, clk;
  logic [15:0] VS, VC;
  logic data_out;

  // invoke an instance of CSA_add
  
  CSA_add csa1 (.*); 
  
  // Clock generator
  always
  begin
    #5 clk = 1;
    #5 clk = 0;
  end
  
  initial
  begin
    clk <= 0;
    VS_x <= 16'b0000000000000000;
 	  VC_x <= 16'b0000000000000000;
 	  VS_y <= 16'b0000000000000000;
 	  VC_y <= 16'b0000000000000000;
    add_sub <= 1'b1;
    data_in <= 0;
     	  
 	  #1ns reset <= 1'b1;
 	  #1ns reset <= 1'b0;
 	  
 	  #2ns VS_x <= 16'b0000111010011010;
 	  VC_x <= 16'b0001010001100101;
 	  VS_y <= 16'b0001000000001110;
 	  VC_y <= 16'b0001100011100101;
 	  
// 	  #2ns VS_x <= $random;
// 	  VC_x <= $random;
// 	  VS_y <= $random;
// 	  VC_y <= $random;

 	  #10ns data_in <= 1;
 	  
 	  #50ns if ((VS_x + VC_x - (VS_y + VC_y)) !== (VS + VC)) begin
		  $display ("Mismatch at time %d",$time);
		  	  
		  $display ("(VS_x + VC_x - (VS_y + VC_y)) %d", (VS_x + VC_x - (VS_y + VC_y)));
		  $display ("(VS + VC) %d", (VS + VC));	
		  $display ("VS %d", VS);	
		  $display ("VC %d", VC);	
	  end
 	  
  end
endmodule

