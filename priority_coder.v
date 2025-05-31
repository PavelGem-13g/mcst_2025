module priority_coder
#(
	parameter DATA_W = 16,
	parameter POS_W = 4
)
(
	input wire [DATA_W-1:0] data, 
	output reg [POS_W-1:0]	 position
);

integer i;

always @(position) begin
	i=0;
	while(i<DATA_W-1 && !data[i])
		i=i+1;
	position <= i;
end


endmodule
