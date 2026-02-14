interface adder_if (input logic clk);
    logic rst;
    logic en;
    logic [7:0] a;
    logic [7:0] b;
    logic [8:0] sum;

    clocking cb @(posedge clk);
        output en, a, b;
        input  sum;
    endclocking

    property en_behavior;
        @(posedge clk)
        en |-> sum == a + b;
    endproperty

assert property (en_behavior);

endinterface
