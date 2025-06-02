`timescale 1ns/1ps

module tb_priority_coder_wire;

  reg  [15:0] data;
  wire [3:0]  position;
  reg  [3:0]  expected;

  priority_coder_wire dut (
    .data(data),
    .position(position)
  );

  initial begin
    $monitor("Time=%0t | data=%b | position=%0d | expected=%0d", $time, data, position, expected);
	 
    data = 16'b0000_0000_0000_0000; expected = 0; #1;

    data = 16'b0000_0000_0000_0001; expected = 0; #1;
    
	 data = 16'b1000_0000_0000_0000; expected = 15; #1;
    
	 data = 16'b0000_0000_0010_0000; expected = 5; #1;
    data = 16'b0000_1000_0000_0000; expected = 11; #1;
    data = 16'b0001_0000_0000_0000; expected = 12; #1;

    
	 data = 16'b0000_0000_0001_0000; expected = 4; #1;
    data = 16'b0000_1000_0000_0010; expected = 1; #1;
    data = 16'b0000_0000_0001_0010; expected = 1; #1;
    data = 16'b1100_0000_0000_1000; expected = 3; #1;
    data = 16'b0000_1111_0000_0000; expected = 8; #1;
    data = 16'b0000_0111_0000_0001; expected = 0; #1;
    data = 16'b0011_0000_0000_0011; expected = 0; #1;
    data = 16'b1000_0000_0000_1111; expected = 0; #1;

    
	 data = 16'b1111_1111_1111_1111; expected = 0; #1;
    data = 16'b1111_0000_0000_0000; expected = 12; #1;
    data = 16'b0000_0000_1111_1111; expected = 0; #1;
    data = 16'b0000_1111_1111_1111; expected = 0; #1;

    
	 data = 16'b0000_0000_0000_0011; expected = 0; #1;
    data = 16'b0000_0000_0000_0110; expected = 1; #1;
    data = 16'b0000_0000_0000_1100; expected = 2; #1;
    data = 16'b0000_0000_0001_1000; expected = 3; #1;
    data = 16'b0000_0000_0011_0000; expected = 4; #1;
    data = 16'b0000_0000_0110_0000; expected = 5; #1;

    
	 data = 16'b1010_0011_0000_0100; expected = 2; #1;
    data = 16'b0001_1000_0000_0010; expected = 1; #1;
    data = 16'b0000_0000_0101_0000; expected = 4; #1;
    data = 16'b0111_1001_0100_0100; expected = 2; #1;

    $stop;
  end

endmodule