module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    output [63:0] BusA;
    output [63:0] BusB;
    input [63:0] BusW;
    input [4:0] RA, RB, RW;
    input RegWr;
    input Clk;
    reg [63:0] registers [31:0];
	
	// initialize xzr
	initial
		registers[31] <= 64'b0;
	
	// output value of registers indicated by RA and RB to BusA and BusB
	assign #2 BusA = registers[RA];
	assign #2 BusB = registers[RB];
	
	// write the value of BusW to register indicated by RW on nededge of clk when RegWr is 1
    always @ (negedge Clk) begin
        if(RegWr) begin
            registers[RW] <= #3 BusW;
			end
    end
	
	// always keep xzr = 0
	always @(registers[31])
		registers[31] <= 64'b0;
		
endmodule
