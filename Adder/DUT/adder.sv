module adder (
    input  logic        clk,
    input  logic        rst,
    input  logic        en,
    input  logic [7:0]  a,
    input  logic [7:0]  b,
    output logic [8:0]  sum
);

always_ff @(posedge clk or posedge rst) begin
    if (rst)
        sum <= 0;
    else if (en)
        sum <= a + b;
end

endmodule
