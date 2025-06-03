module fifo #(
    parameter DATA_W = 10,
    parameter FIFO_SIZE = 6
)(
    input  wire                  clock,
    input  wire                  reset,
    input  wire                  write,
    input  wire                  read,
    input  wire [DATA_W-1:0]     datain,
    output reg  [DATA_W-1:0]     dataout,
    output wire                  val,
    output wire                  full
);

    reg [DATA_W-1:0] mem [0:FIFO_SIZE-1];

    reg [$clog2(FIFO_SIZE):0] rd_ptr;
    reg [$clog2(FIFO_SIZE):0] wr_ptr;
    reg [$clog2(FIFO_SIZE):0] count;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            rd_ptr   <= 0;
            wr_ptr   <= 0;
            count    <= 0;
            dataout  <= 0;
        end else begin
            if (write && !full && read && (count != 0)) begin
                mem[wr_ptr] <= datain;
                wr_ptr <= (wr_ptr + 1) % FIFO_SIZE;
                dataout <= mem[rd_ptr];
                rd_ptr <= (rd_ptr + 1) % FIFO_SIZE;
            end 

            else if (write && !full) begin
                mem[wr_ptr] <= datain;
                wr_ptr <= (wr_ptr + 1) % FIFO_SIZE;
                count <= count + 1;
            end

            else if (read && (count != 0)) begin
                dataout <= mem[rd_ptr];
                rd_ptr <= (rd_ptr + 1) % FIFO_SIZE;
                count <= count - 1;
            end
        end
    end

    assign full = (count == FIFO_SIZE);
    assign val  = (count != 0);

endmodule