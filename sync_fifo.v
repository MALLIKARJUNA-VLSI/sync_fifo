module sync_fifo(
    input wire clk,
    input wire rst_n,
    input wire rd_en,
    input wire wr_en,
    input wire [7:0]data_in,
    output reg [7:0]data_out,
    output wire empty,
    output wire full
);
    reg [7:0] fifo_mem [0:15];
    reg [3:0] wr_ptr,rd_ptr;
    reg [4:0] count;

    always @(posedge clk or negedge rst_n)begin
        if (!rst_n)begin
            wr_ptr<=0;
            rd_ptr<=0;
            count<=0;
            data_out<=0;
        end else begin
            if (wr_en && !full)begin
                fifo_mem[wr_ptr]<=data_in;
                wr_ptr<=wr_ptr+1;
            end
            if (rd_en && !empty)begin
                data_out<=fifo_mem[rd_ptr];
                rd_ptr<=rd_ptr+1;
            end
            if ((wr_en && !full) && !(rd_en && !empty))begin
                count<=count+1;
            end else if ((rd_en && !empty) && !(wr_en && !full))begin
                count<=count-1;
            end
        end
    end
     

    assign full =(count==5'd16);
    assign empty=(count==5'd0);
endmodule