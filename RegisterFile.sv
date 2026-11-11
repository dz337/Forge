// Storage
// Gets register addresses (ra1, ra2, wa) from 32-bit instruction
// outputs stored data (rd1, rd2) to the alu for calculations
// receives new data (wd) back from the ALU or Data Memory to save

// instruction tells which address ra1 and ra2 to look at
// puts number from address into rd1 and rd2
// rd1 and rd2 go into a and b
// answer goes into the result
// result goes into wd 
// stores wd data inside wa reg

module RegisterFile (
  input wire clk, // clock signal
  input wire we, // Write Enable (RegWrite from Main Control) 
  input wire [4:0] ra1, // Read Register 1 address (bits 19-15)
  input wire [4:0] ra2, // Read Register 2 address (bits 24-20)
  input wire [4:0] wa, // Write Register address (bits 11-7)
  input wire [31:0] wd, // Write Data

  output wire [31:0] rd1, // Read Data 1 output (a for alu)
  output wire [31:0] rd2 // Read Data 2 output (b for alu) 
);
  // 32 by 32
  reg [31:0] registers [31:0];
  
  // (Condition) ? Result_if_True : Result_if_False
  // if requested read address exactly Register 0, output 32-bit number 0. Otherwise, output whatever is stored inside requested register
  // combinational, when address change, values instantly change
  assign rd1 = (ra1 == 5'b00000) ? 32'b0 : registers[ra1];
  assign rd2 = (ra2 == 5'b00000) ? 32'b0 : registers[ra2];

  // synchronous, only allow changes when CPU clock ticks 
  always @(posedge clk) begin
    if (we && (wa != 5'b00000)) begin
      // stores the wd data inside the wa register
      registers[wa] <= wd;
    end
  end

endmodule
