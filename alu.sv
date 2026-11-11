// Is the calculator for the cpu
// Gets a and b from register file or Immediate Generator
// alu control comes from the alu control unit
// result should go to register file or data memory

module alu (
  input logic [31:0] a,b, // defines 32 input signals 
  input logic [3:0] alu_control, // tells what operation to do
    
  output logic [31:0] result, 
  output logic zero 
);

  always_comb begin
    case (alu_control)
      4'b0000: result = a & b; // And                               
      4'b0001: result = a | b; // Or                              
      4'b0010: result = a + b; // Plus                               
      4'b0110: result = a - b; // Subtraction                               
      4'b0100: result = a ^ b; // Xor                               
      4'b0101: result = a << b[4:0]; // shift left                        
      4'b0111: result = a >> b[4:0]; // shift right                         
      4'b1001: result = $signed(a) >>> b[4:0]; // arithmetic right shift                 
      4'b1000: result = {31'b0, ($signed(a) < $signed(b))}; // set less then signed  
      4'b1011: result = {31'b0, (a < b)}; // set less then unsigned                     
      
      default: result = 32'b0;
    endcase
  end
  
  assign zero = (result == 32'b0);
  
endmodule
