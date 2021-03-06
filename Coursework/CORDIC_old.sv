
/////////////////////////////////////////////////////////////////////
// Design unit: CORDIC ALU
//            :
// File name  : CORDIC.sv
//            :
// Author     : tjb2g11@ecs.soton.ac.uk
/////////////////////////////////////////////////////////////////////

module CORDIC(input logic [15:0] VS_x, VC_x, VS_y, VC_y,
               input logic data_valid_in, reset, clk,
               output logic [15:0] VS_root, VC_root, atan_VS, atan_VC,
               output logic data_valid_out);

//------------------------------------------------------------------------------
//                              Registers
//------------------------------------------------------------------------------
logic [15:0] VS_x_temp [0:15];
logic [15:0] VC_x_temp [0:15];

logic [15:0] VS_y_temp [0:15];
logic [15:0] VC_y_temp [0:15];

logic [15:0] VS_Z_temp [0:15];
logic [15:0] VC_Z_temp [0:15];

logic data_in, reset, clk, sgn, data_out;

// invoke an instance of sgn_detect  
sgn_detect sgn_det1 (VS, VC, data_in, reset, clk, sgn, data_out);

logic [15:0] VS_x, VC_x, VS_y, VC_y;
logic add_sub, data_in, reset, clk;
logic [15:0] VS, VC;
logic data_out;

//CSA_add csa1 (VS_x, VC_x, VS_y, VC_y, add_sub, data_in, reset, clk, VS, VC, data_out); 

always_ff @(posedge clk or posedge reset) begin 
  if (reset) begin
      data_valid_out <= 0;
  end
  else if (data_valid_in) begin
     
  end
end

//------------------------------------------------------------------------------
//                           Pipelining stage
//------------------------------------------------------------------------------
genvar i;
generate
  for (i=0; i < 15; i=i+1)
  begin: XYZ
    logic sgn;
    logic [15:0] VS_x_temp_shifted, VC_x_temp_shifted;
    logic [15:0] VS_y_temp_shifted, VC_y_temp_shifted; 

    //TODO: Check direction of shift
    assign VS_x_temp_shifted = VS_x_temp[i] >>> i;
    assign VC_x_temp_shifted = VC_x_temp[i] >>> i; 
    assign VS_y_temp_shifted = VS_y_temp[i] >>> i;
    assign VC_y_temp_shifted = VC_y_temp[i] >>> i;

    // TODO: Set up the sign of the current VS_z and VC_z number
    
    always @(posedge clk)
    begin
      //TODO: Sort out shifting for CSA and vectoring mode
      // add/subtract shifted data
      X[i+1] <= sgn ? X[i] + Y_shr         : X[i] - Y_shr;
      Y[i+1] <= sgn ? Y[i] - X_shr         : Y[i] + X_shr;
      Z[i+1] <= sgn ? Z[i] + atan_table[i] : Z[i] - atan_table[i];
    end
  end
endgenerate

//------------------------------------------------------------------------------
//                                 Output
//------------------------------------------------------------------------------
assign VS_root = VS_x_temp[15];
assign VC_root = VC_x_temp[15];
assign atan_VS = VS_z_temp[15];
assign atan_VC = VC_z_temp[15];

endmodule

