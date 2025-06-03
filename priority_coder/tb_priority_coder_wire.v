`timescale 1ns/1ps

module tb_priority_coder_wire;

  reg  [15:0] data;
  wire [3:0]  position;

  reg [15:0] test_data [0:19];

  reg [3:0] expected [0:19];

  integer i;

  priority_coder_wire dut (
    .data(data),
    .position(position)
  );

  initial begin
    
    test_data[0]  = 16'b0000_0000_0000_0000; expected[0]  = 15;
    test_data[1]  = 16'b0000_0000_0000_0001; expected[1]  = 0;
    test_data[2]  = 16'b1000_0000_0000_0000; expected[2]  = 15;
    test_data[3]  = 16'b0000_0000_0010_0000; expected[3]  = 5;
    test_data[4]  = 16'b0000_1000_0000_0000; expected[4]  = 11;
    test_data[5]  = 16'b0001_0000_0000_0000; expected[5]  = 12;
    test_data[6]  = 16'b0000_0000_0001_0000; expected[6]  = 4;
    test_data[7]  = 16'b0000_1000_0000_0010; expected[7]  = 11;
    test_data[8]  = 16'b0000_0000_0001_0010; expected[8]  = 4; 
    test_data[9]  = 16'b1100_0000_0000_1000; expected[9]  = 15;
    test_data[10] = 16'b0000_1111_0000_0000; expected[10] = 11;
    test_data[11] = 16'b0000_0111_0000_0001; expected[11] = 10;
    test_data[12] = 16'b0011_0000_0000_0011; expected[12] = 13;
    test_data[13] = 16'b1000_0000_0000_1111; expected[13] = 15;
    test_data[14] = 16'b1111_1111_1111_1111; expected[14] = 15;
    test_data[15] = 16'b1111_0000_0000_0000; expected[15] = 15;
    test_data[16] = 16'b0000_0000_1111_1111; expected[16] = 7; 
    test_data[17] = 16'b0000_1111_1111_1111; expected[17] = 11;
    test_data[18] = 16'b0000_0000_0000_0011; expected[18] = 1; 
    test_data[19] = 16'b0000_0000_0000_0110; expected[19] = 2; 

    for (i = 0; i < 20; i = i + 1) begin
      data = test_data[i];
      #1;
      $display("Test %0d: data=%b, position=%0d, expected=%0d -> %s",
               i, data, position, expected[i],
               (position == expected[i]) ? "Pass" : "FAIL");
    end

    $stop;
  end

endmodule