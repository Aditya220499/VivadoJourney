`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2025 13:01:27
// Design Name: 
// Module Name: fifo_sync
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo_sync #(
        parameter DATA_WIDTH = 4,
        parameter FIFO_DEPTH = 4,
        parameter ADDR_SIZE = 2
)(
        output reg [DATA_WIDTH-1 : 0]data_out,
        output reg isFull,
        output reg isEmpty,
        input [DATA_WIDTH-1 : 0]data_in,
        input write_en,
        input read_en,
        input rst,
        input clk
    );
    reg [DATA_WIDTH-1 : 0]FIFO[0 : FIFO_DEPTH-1];
    reg [ADDR_SIZE-1 : 0]rd_ptr;
    reg [ADDR_SIZE-1 : 0]wr_ptr;
    reg [ADDR_SIZE-1 : 0]count;

    always @(posedge clk or posedge rst) begin
      if(rst) begin
        wr_ptr <= 0;
        rd_ptr <= 0;
        count <= 0;
        data_out <= 0;
        isFull <= 0;
        isEmpty <= 1;
      end
      else begin
        if( read_en && !isEmpty) begin
          data_out <= FIFO[rd_ptr];
          rd_ptr <= rd_ptr + 1;
          count <= count - 1;
        end
        if( write_en && !isFull) begin
          FIFO[wr_ptr] <= data_in;
          wr_ptr <= wr_ptr + 1;
          count <= count + 1;
        end
        isEmpty <= (count == 0) ? 1 : 0 ;                     // Update empty flag
        isFull <= (count == FIFO_DEPTH) ? 1 : 0 ;             // Update full flag
      end
    end 


endmodule
