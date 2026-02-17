class adder_tx extends uvm_sequence_item;

  rand bit [7:0] a;
  rand bit [7:0] b;

  bit [8:0] expected_sum;
  bit [8:0] actual_sum;

  constraint overflow_case {
    a > 200;
    b > 200;
  }

  function new(string name = "adder_tx");
    super.new(name);
  endfunction

  function void compute();
    expected_sum = a + b;
  endfunction

  `uvm_object_utils(adder_tx)

endclass
