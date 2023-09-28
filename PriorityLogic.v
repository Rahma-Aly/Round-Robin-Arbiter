/*Description: A fixed priority encoder where In[0] has the highest */
module PriorityLogic ( 
    input wire       clk,
    input wire       rst_n,
    input wire       En,
	input wire [3:0] In,
	output reg [3:0] Out
);
   
   always @(posedge clk or negedge rst_n) begin
 	if (~rst_n) begin
            Out <= 'b0;
       end
       else if (En) begin
           if (In[0]) begin
               Out <= 'b1;
           end
           else if (In[1]) begin
               Out <= 'b10;
            end
           else if (In[2]) begin 
               Out <= 'b100;
           end  
           else if (In[3]) begin
               Out <= 'b1000;
             end
       end
       else begin
               Out <= 'b0;
        end   
   end
   

	
endmodule : PriorityLogic
