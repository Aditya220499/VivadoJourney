`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2025 22:01:39
// Design Name: 
// Module Name: tb_rom4x4_sync
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


module tb_rom4x4_sync;
    wire [3 : 0]rom_data_out;
    reg en;
    reg rst;
    reg clk;
    reg [1 : 0]address;

    rom4x4_sync dut(.rom_data_out(rom_data_out), .en(en), .rst(rst), .clk(clk), .address(address));
    initial begin
      clk = 0;
      address = 0;
      rst = 0;
      en = 0;
    end

    initial begin
      forever #5 clk = ~clk;
    end

    initial begin
      $strobe("----------------Start Simulation---------------");
      $monitor(" Enable :: %d || Reset :: %d || Address :: %d || Data Out :: %d", en, rst, address, rom_data_out);
      @(negedge clk) en = 1;
      @(negedge clk) address = 1;
      @(negedge clk) address = 3;
      @(negedge clk) address = 2;
      @(negedge clk) en = 0;
      @(negedge clk) address = 1;
      @(negedge clk) en = 1;
      @(negedge clk) address = 1;
      @(negedge clk) address = 0;
      @(negedge clk) address = 2;
      @(negedge clk) rst = 1;
      @(negedge clk) rst = 0;
      @(negedge clk) address = 1;
      repeat(10)@(posedge clk);
      $strobe("----------------End Simulation------------------");
//      #10 $finish
    end

endmodule
