`timescale 1ns/1ps

module fifo_tb;

    parameter DATA_W = 10;
    parameter FIFO_SIZE = 6;

    reg clock;
    reg rst_n;
    reg push;
    reg pop;
    reg [DATA_W-1:0] data_in;
    wire [DATA_W-1:0] read_data;
    wire full;

    fifo #(
        .DATA_W(DATA_W),
        .FIFO_SIZE(FIFO_SIZE)
    ) dut (
        .clock(clock),
        .rst_n(rst_n),
        .push(push),
        .pop(pop),
        .full(full),
        .data_in(data_in),
        .read_data(read_data)
    );

    initial clock = 0;
    always #5 clock = ~clock;

    initial begin
        $monitor("time=%0t | rst_n=%b | push=%b | pop=%b | data_in=%d | read_data=%d | full=%b", 
            $time, rst_n, push, pop, data_in, read_data, full);
    end

    initial begin
        rst_n = 0; push = 0; pop = 0; data_in = 0;
        #12;
        rst_n = 1;
        #8;

        push = 1; data_in = 101; #10;
        push = 1; data_in = 202; #10;
        push = 1; data_in = 303; #10;
        push = 0; data_in = 0;   #10;

        pop = 1; #10;
        pop = 0; #10;

        pop = 1; #10;
        pop = 0; #10;

        pop = 1; #10;
        pop = 0; #10;

        pop = 1; #10;
        pop = 0; #10;

        push = 1; data_in = 11; #10;
        push = 1; data_in = 22; #10;
        push = 1; data_in = 33; #10;
        push = 1; data_in = 44; #10;
        push = 1; data_in = 55; #10;
        push = 0; #10;

        pop = 1; #10;
        pop = 0; #10;

        #20;
        $stop;
    end

endmodule