module Arbiter_Assertions (
    input wire        clk,
    input wire        rst_n,
    input wire [3:0]  Req,
    input wire [3:0]  Grant
);
    property reset;
        @(posedge clk)
        ~rst_n |-> Grant == 'b0;
    endproperty
    
    CHECK_RST: assert property (reset) else $error("Reset signal not working properly");

    property grant_given;
        @(posedge clk) disable iff (~rst_n)
        (Req [0] |=> ##[1:4] Grant[0]) or (Req [1] |=> ##[1:4] Grant[1])
         or (Req [2] |=> ##[1:4] Grant[2]) or (Req [3] |=> ##[1:4] Grant[3]);
    endproperty
    
    CHECK_GRANT: assert property (grant_given) else $error("Grant not given to requester");
            
    
    property one_grant_at_a_time;
        $onehot(Grant);
    endproperty
    
    CHECK_ONE_GRANT : assert property (@(posedge clk) one_grant_at_a_time) else $error("more than 1 request was given a grant");
            
    property Req_Grant;
        @(posedge clk)
        ~Req |=> ~Grant;
    endproperty
    
    CHECK_REQ_GRANT: assert property (Req_Grant) else $error("A grant was given without a request");
            
    property No_hogging;
        @(posedge clk) disable iff(~rst_n)
        (Grant[0] ##1 ~Grant[0]) or (Grant[1] ##1 ~Grant[1]) or 
        (Grant[2] ##1 ~Grant[2]) or (Grant[3] ##1 ~Grant[3]);
    endproperty
    
    CHECK_NO_HOGGING: assert property (No_hogging) else $error("Grant is given twice in a row for a certain requestor");
    
    
	
endmodule : Arbiter_Assertions
