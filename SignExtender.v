module SignExtender(BusImm, Imm26, Ctrl); 
  output reg [63:0] BusImm; 
  input [25:0] Imm26; 
  input [2:0] Ctrl; 
 
  always @(*) begin
	  case (Ctrl) 
		3'b000 : begin  // I-type
			BusImm = {52'b0, Imm26[21:10] }; 
		end
		3'b001 : begin  // D-type 
			BusImm = {{55{Imm26[20]}}, Imm26[20:12]}; 
		end
		3'b010 : begin  // B-type
			BusImm = {{36{Imm26[25]}}, Imm26[25:0], 2'b00};
		end
		3'b011 : begin  // CB-Type
			BusImm = {{43{Imm26[23]}}, Imm26[23:5], 2'b00};
		end
		3'b100 : begin // MOVZ
			if (Imm26[22:21] == 2'b00)
				BusImm = {48'b0, Imm26[20:5]};
			else if (Imm26[22:21] == 2'b01)
				BusImm = {32'b0, Imm26[20:5], 16'b0};
			else if (Imm26[22:21] == 2'b10)
				BusImm = {16'b0, Imm26[20:5], 32'b0};
			else if (Imm26[22:21] == 2'b11)
				BusImm = {Imm26[20:5], 48'b0};
			end
	endcase
  end
endmodule
