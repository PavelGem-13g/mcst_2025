module fifo

#(
    parameter DATA_W = 10,
    parameter FIFO_SIZE = 6
)
(
    input  clock,
    input  rst_n,
    input  push,             
    input  pop,
	 output full,	 

    input  [DATA_W-1:0] data_in,
    output reg [DATA_W-1:0] read_data
);

    reg [DATA_W-1:0] fifo_mem [0:FIFO_SIZE-1];
    reg [$clog2(FIFO_SIZE)-1:0] read_ptr;
    reg [$clog2(FIFO_SIZE)-1:0] write_ptr;
    reg [$clog2(FIFO_SIZE):0]   fifo_count; 
	 
    always @(posedge clock or negedge rst_n) begin
        if (!rst_n) begin
            read_ptr   <= 0;
            write_ptr  <= 0;
            fifo_count <= 0;
            read_data  <= 0;
        end
        else begin
            if (push && fifo_count < (1<<FIFO_SIZE)) begin
                fifo_mem[write_ptr] <= data_in;
                write_ptr <= write_ptr + 1;
                fifo_count <= fifo_count + 1;
            end

            if (pop && fifo_count > 0) begin
                read_data <= fifo_mem[read_ptr];
                read_ptr <= read_ptr + 1;
                fifo_count <= fifo_count - 1;
            end
        end
    end
	 
	 assign full = fifo_count == FIFO_SIZE-1;

endmodule



