/////////////////////////////////////////////////////////////////////
// Design unit: 4-2 Compressor
//            :
// File name  : compressor.sv
//            :
// Author     : tjb2g11@ecs.soton.ac.uk
/////////////////////////////////////////////////////////////////////

module compressor (
  input logic VS_x, VC_x, VS_y, VC_y, cin, add_sub,
  output logic VC, VS, cout);
  
  wire VS_connector, XOR_1_connector, XOR_2_connector;
  assign XOR_1_connector = VS_y^add_sub;
  assign XOR_2_connector = VC_y^add_sub;
  
  fa fa_1 (VS_x, VC_x, XOR_1_connector, cout, VS_connector);
  fa fa_2 (XOR_2_connector, cin, VS_connector, VC, VS);

endmodule
