module priority_coder_wire
#(
	parameter DATA_W = 16,
	parameter POS_W = 4
)
(
	input wire [DATA_W-1:0] data, 
	output wire [POS_W-1:0] position
);

wire [POS_W-1:0] pos [DATA_W-1:0];

genvar i;
generate
	for (i = 0; i < DATA_W; i = i + 1) begin : init_pos
		assign pos[i] = i[POS_W-1:0];
	end
endgenerate


wire [POS_W-1:0] priority [DATA_W-1:0];

assign priority[0] = data[0] ? pos[0] : {POS_W{1'b1}};

generate
	for (i = 1; i < DATA_W; i = i + 1) begin : build_priority
		assign priority[i] = data[i] ? pos[i] : priority[i-1];
	end
endgenerate

assign position = priority[DATA_W-1];

endmodule
