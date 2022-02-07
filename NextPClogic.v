module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
    input [63:0] CurrentPC, SignExtImm64;
    input Branch, ALUZero, Uncondbranch;
    output [63:0] NextPC;
    reg [63:0] test;
    assign NextPC = test;
    always @(*) 
		begin
			if (Uncondbranch)
				#3 test = CurrentPC + SignExtImm64;  // general addition + multiplexer = 2 + 1 = 3 unit delay
			else if (Branch & ALUZero)
				#3 test = CurrentPC + SignExtImm64;  // general addition + multiplexer = 2 + 1 = 3 unit delay
			else
				#2 test = CurrentPC + 4;  // constant addition + multiplexer = 1 + 1 = 2 unit delay
		end
endmodule
