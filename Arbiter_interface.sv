`ifndef ARBITER_INTERFACE_SV
`define ARBITER_INTERFACE_SV



interface Arbiter_Interface #(parameter INPUT_WIDTH = 4);
    logic                    clk;
    logic                    rst_n;
    logic [INPUT_WIDTH-1:0]  Req;
    logic [INPUT_WIDTH-1:0]  Grant;
    
endinterface

`endif
