`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2025 13:43:42
// Design Name: 
// Module Name: tb_fifo_sync
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


module tb_fifo_sync;
      wire [3 : 0]data_out;
      wire isFull;
      wire isEmpty;
      reg [3 : 0]data_in;
      reg write_en;
      reg read_en;
      reg rst;
      reg clk;
      reg simulation_done = 0;

      fifo_sync dut( .data_out(data_out), .isFull(isFull), .isEmpty(isEmpty), .data_in(data_in), .write_en(write_en), .read_en(read_en), .rst(rst), .clk(clk));

      always #5 clk = ~clk;

      initial begin
        data_in = 0;
        write_en = 0;
        data_in = 0;
        read_en = 0;
        rst = 1;
        clk = 0;

        #15 rst = 0;  // Release reset after 1.5 cycles
        $strobe("----------------Start Simulation---------------");
        @(negedge clk) read_en = 1;
        @(negedge clk) read_en = 0;
        @(negedge clk) write_en = 1; data_in = 4'hA;
        @(negedge clk) write_en = 1; data_in = 4'hC;
        @(negedge clk) write_en = 0; data_in = 4'hA;
        @(negedge clk) read_en = 1; 
        @(negedge clk) write_en = 1; data_in = 4'h4;
        @(negedge clk) read_en = 1;
        @(negedge clk) write_en = 1; data_in = 4'h1;
        @(negedge clk) write_en = 1; data_in = 4'h9;
        @(negedge clk) write_en = 1; data_in = 4'h8;
        @(negedge clk) write_en = 1; data_in = 4'h5;
        @(negedge clk) write_en = 0; data_in = 4'hB;
        @(negedge clk) read_en = 1;
        @(negedge clk) read_en = 1;
        @(negedge clk) read_en = 1;
        @(negedge clk) read_en = 1;
        @(negedge clk) write_en = 1; data_in = 4'h5;
        @(negedge clk) rst = 1;
        @(negedge clk) read_en = 1;
        repeat(10)@(posedge clk);
        simulation_done = 1;
        $strobe("----------------End Simulation------------------");
        #10 $finish;
      end

      always @(posedge clk) begin
        if (!simulation_done)  // Only print when enabled and not resetting
            $strobe("Time=%t: Read Enable=%d, Data Out=%h, Write Enable=%d, Data In=%h, isFull=%d, isEmpty=%d", $time, read_en, data_out, write_en, data_in, isFull, isEmpty );
    end
    
endmodule
