`timescale 1ns/1ps

module sync_fifo_tb;

    reg clk;
    reg rst_n;
    reg wr_en;
    reg rd_en;
    reg [7:0] data_in;

    wire [7:0] data_out;
    wire empty;
    wire full;

    // Instantiate the Synchronous FIFO
    sync_fifo uut (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .empty(empty),
        .full(full)
    );

    // Generate 100MHz Clock (10ns period)
    always #5 clk = ~clk;

    integer i;

    initial begin
        $dumpfile("sync_fifo.vcd");
        $dumpvars(0, sync_fifo_tb);

        $display("Time\t rst_n\t wr_en\t rd_en\t data_in\t data_out\t count\t empty\t full");
        $monitor("%0t\t %b\t %b\t %b\t %h\t\t %h\t\t %0d\t %b\t %b", 
                 $time, rst_n, wr_en, rd_en, data_in, data_out, uut.count, empty, full);

        // 1. Initialize & Reset
        clk = 0; rst_n = 0; wr_en = 0; rd_en = 0; data_in = 8'h00;
        #15 rst_n = 1;

        // 2. Write 16 bytes into the FIFO (count goes 0 -> 16, full becomes 1)
        for (i = 1; i <= 16; i = i + 1) begin
            @(negedge clk);
            wr_en = 1;
            data_in = i;
        end
        @(negedge clk);
        wr_en = 0;

        // 3. Read all 16 bytes back out (count goes 16 -> 0, empty becomes 1)
        for (i = 1; i <= 16; i = i + 1) begin
            @(negedge clk);
            rd_en = 1;
        end
        @(negedge clk);
        rd_en = 0;

        #20 $finish;
    end

endmodule