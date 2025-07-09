`timescale 1ns/1ps

module sync_ram_tb;

    // Signal declarations
    reg clk;
    reg en;
    reg we;
    reg [3:0] addr;
    reg [7:0] din;
    wire [7:0] dout;

    // Instantiate the DUT (Device Under Test)
    sync_ram uut (
        .clk(clk),
        .en(en),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // Clock generator: toggle every 5ns => 10ns period
    always #5 clk = ~clk;

    // VCD Dump for GTKWave
    initial begin
        $dumpfile("sync_ram_wave.vcd");
        $dumpvars(0, sync_ram_tb);
    end

    // Test sequence
    initial begin
        $display("Time\tclk\ten\twe\taddr\tdin\tdout");
        $monitor("%0t\t%b\t%b\t%b\t%h\t%h\t%h", $time, clk, en, we, addr, din, dout);

        // Initialization
        clk = 0; en = 0; we = 0; addr = 0; din = 0;

        #10 en = 1;

        // Write operations
        we = 1;
        addr = 4'h1; din = 8'hA5; #10;
        addr = 4'h2; din = 8'h3C; #10;
        addr = 4'h3; din = 8'h7F; #10;

        // Read operations
        we = 0;
        addr = 4'h1; #10;
        addr = 4'h2; #10;
        addr = 4'h3; #10;

        #20 $finish;
    end

endmodule
