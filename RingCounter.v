module RingCounter #(parameter COUNT_WIDTH = 4)(
	input wire                   clk,
	input wire                   rst_n,
	output reg [COUNT_WIDTH-1:0] Count_out
);


	always @(posedge clk or negedge rst_n) begin
	    if (~rst_n) begin
	        Count_out <= {1'b1,{(COUNT_WIDTH-1){1'b0}}};
	    end
	    else begin
	          Count_out <= {Count_out[0],Count_out[(COUNT_WIDTH-1):1]};
	    end
	        
	end
	
endmodule : RingCounter
