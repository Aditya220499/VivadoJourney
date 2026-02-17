`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"

module tb_top;

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

  initial begin
    uvm_config_db#(virtual adder_if)::set(null, "*", "vif", intf);
    run_test("adder_test");
  end

endmodule
