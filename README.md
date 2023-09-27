# Round-Robin-Arbiter
Verilog implementation of one of the commonly used arbitration mechanisms, Round Robin. (verified using SystemVerilog assertions) 
A round-robin arbitration policy is a token-passing scheme where fairness among the multiple requesting agents is ensured with no starvation.
In each cycle, one of the masters has the highest priority to get access to the shared resource. This is then rotated in a round-robin order. If any master does not need access to the resource in the cycle, then the next master in round-robin order gets the priority.
