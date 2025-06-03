`timescale 1ns/1ps

module tb_fifo;

    parameter DATA_W = 10;
    parameter FIFO_SIZE = 6;

    reg clock;
    reg reset;
    reg write;
    reg read;
    reg [DATA_W-1:0] datain;
    wire [DATA_W-1:0] dataout;
    wire val;
    wire full;

    fifo #(
        .DATA_W(DATA_W),
        .FIFO_SIZE(FIFO_SIZE)
    ) dut (
        .clock(clock),
        .reset(reset),
        .write(write),
        .read(read),
        .datain(datain),
        .dataout(dataout),
        .val(val),
        .full(full)
    );

    initial clock = 0;
    always #5 clock = ~clock;

    initial begin
        $monitor("time=%0t | reset=%b | write=%b | read=%b | datain=%d | dataout=%d | val=%b | full=%b", 
            $time, reset, write, read, datain, dataout, val, full);
    end

    initial begin
        reset = 1; write = 0; read = 0; datain = 0;
        #10;
        reset = 0;
        #10;

        write = 1; datain = 1; #10;
        write = 1; datain = 2; #10;
        write = 1; datain = 3; #10;
        write = 0; datain = 0;   #10;

        read = 1; #10;
        read = 0; #10;

        read = 1; #10;
        read = 0; #10;

        read = 1; #10;
        read = 0; #10;

        read = 1; #10;
        read = 0; #10;

        write = 1; datain = 11; #10;
        write = 1; datain = 22; #10;
        write = 1; datain = 33; #10;
        write = 1; datain = 44; #10;
        write = 1; datain = 55; #10;
        write = 1; datain = 66; #10;
        write = 0; #10;

        write = 1; datain = 77; read = 1; #10;
        write = 0; read = 0; #10;

        read = 1; #10;
        read = 0; #10;

        #20;
        $stop;
    end

endmodule