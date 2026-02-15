class adder_tx;

    rand bit [7:0] a;
    rand bit [7:0] b;

    constraint overflow_case {
       a > 200;
       b > 200;
    }

    bit [8:0] expected_sum;
    bit [8:0] actual_sum;

    function void compute();
      expected_sum = a + b;
    endfunction

  endclass