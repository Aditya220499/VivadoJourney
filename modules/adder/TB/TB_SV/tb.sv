`timescale 1ns/1ps

import adder_pkg::*;

module tb;

  logic clk = 0;
  always #5 clk = ~clk;

  adder_if intf(clk);

  adder dut (
    .clk(clk),
    .rst(intf.rst),
    .en(intf.en),
    .a(intf.a),
    .b(intf.b),
    .sum(intf.sum)
  );

  environment env;

  initial begin
    intf.rst = 1;
    repeat (2) @(posedge clk);
    intf.rst = 0;

    env = new(intf);
    env.run();

    #200 $finish;
  end

endmodule
