`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2025 18:00:00
// Design Name: 
// Module Name: tb_dualport_rw
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


module tb_dualport_rw;
    wire [3 : 0]data_out;
    reg [3 : 0]data_in;
    reg read_en;
    reg write_en;
    reg rst;
    reg clk;
    reg [1 : 0]read_address;
    reg [1 : 0]write_address; 
    reg simulation_done = 0;  // Flag to stop printing

    dualport_rw dut(.data_out(data_out), .data_in(data_in), .read_en(read_en), .write_en(write_en), .rst(rst), .clk(clk), .read_address(read_address), .write_address(write_address));

    initial begin
      forever #5 clk = ~clk;
    end

    initial begin
      clk = 0;
      rst = 1;
      write_en = 0;
      read_en = 0;
      read_address = 0;
      write_address = 0;
      data_in = 0;
      #15 rst = 0;  // Release reset after 1.5 cycles
      $strobe("----------------Start Simulation---------------");
      @(negedge clk) read_en = 1; read_address = 1;
      @(negedge clk) read_address = 0;
      @(negedge clk) read_address = 3;
      @(negedge clk) read_address = 2;
      @(negedge clk) read_en = 0; read_address = 1;
      @(negedge clk) write_en = 1; write_address = 2; data_in = 4'h4; 
      @(negedge clk) read_address = 2; read_en = 1;
      @(negedge clk) write_address = 0; data_in = 4'h8; read_address = 0;
      @(negedge clk) write_en = 0; write_address = 3; data_in = 4'hF; read_address = 2;
      @(negedge clk) read_address = 1; write_en = 1; write_address = 0; data_in = 4'hE;
      @(negedge clk) read_address = 0;
      @(negedge clk) read_address = 2; write_en = 0;
      @(negedge clk) write_en = 1; write_address = 1; data_in = 4'h0;
      @(negedge clk) write_address = 2; data_in = 4'h0;
      @(negedge clk) read_address = 2;
      @(negedge clk) read_address = 1;
      simulation_done = 1;
      $strobe("----------------End Simulation------------------");
      #10 $finish;
    end
    
    always @(posedge clk) begin
        if ( !rst && !simulation_done)  // Only print when enabled and not resetting
            $strobe("Time=%t: Read Enable=%d, Read Address=%d, Data Out=%h, Write Enable=%d, Write Address=%d, Data In=%h", $time, read_en, read_address, data_out, write_en, write_address, data_in );
    end

endmodule
