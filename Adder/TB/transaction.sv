class adder_tx;
    rand bit [7:0] a;
    rand bit [7:0] b;

    bit [8:0] expected_sum;

    function void compute();
        expected_sum = a + b;
    endfunction
endclass
