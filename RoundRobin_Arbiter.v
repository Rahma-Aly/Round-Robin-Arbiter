module RoundRobin_Arbiter #(parameter INPUT_WIDTH = 4)(
	input wire                    clk,
	input wire                    rst_n,
	input wire [INPUT_WIDTH-1:0]  Req,
	output wire [INPUT_WIDTH-1:0] Grant
);
	
	wire [INPUT_WIDTH-1:0] Out0,Out1,Out2,Out3, Count_out;
	
	
	RingCounter #(
	    .COUNT_WIDTH(INPUT_WIDTH)
	) RingCounter_instance(
	    .clk(clk),
	    .rst_n(rst_n),
	    .Count_out(Count_out)  
	);
	
	PriorityLogic PriorityLogic_instance0(
	    .clk(clk),
        .rst_n(rst_n),
	    .En(Count_out[3]),
	    .In(Req),   //{Req[3],Req[2],Req[1],Req[0]}
	    .Out(Out0)
	);
	
	PriorityLogic PriorityLogic_instance1(
	    .clk(clk),
        .rst_n(rst_n),
	    .En(Count_out[2]),
	    .In({Req[0],Req[3],Req[2],Req[1]}),
	    .Out(Out1)
	);
	
	PriorityLogic PriorityLogic_instance2(
	    .clk(clk),
        .rst_n(rst_n),
        .En(Count_out[1]),
        .In({Req[1],Req[0],Req[3],Req[2]}), 
        .Out(Out2)
    );
    
    PriorityLogic PriorityLogic_instance3(
        .clk(clk),
        .rst_n(rst_n),
        .En(Count_out[0]),
        .In({Req[0],Req[1],Req[2],Req[3]}),
        .Out(Out3)
    );
    
    assign Grant[0] = Out0[0] | Out1[0] | Out2[0] | Out3[0];
    assign Grant[1] = Out0[1] | Out1[1] | Out2[1] | Out3[1];
    assign Grant[2] = Out0[2] | Out1[2] | Out2[2] | Out3[2];
    assign Grant[3] = Out0[3] | Out1[3] | Out2[3] | Out3[3];
    
    
endmodule : RoundRobin_Arbiter
