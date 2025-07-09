module sync_ram #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    input clk,
    input en,                 // Enable
    input we,                 // Write Enable
    input [ADDR_WIDTH-1:0] addr,
    input [DATA_WIDTH-1:0] din,
    output reg [DATA_WIDTH-1:0] dout
);

    // Declare RAM memory
    reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

    always @(posedge clk) begin
        if (en) begin
            if (we)
                mem[addr] <= din;     // Write operation
            else
                dout <= mem[addr];    // Read operation
        end
    end

endmodule
