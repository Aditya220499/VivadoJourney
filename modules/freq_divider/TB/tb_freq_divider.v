`timescale 1ns/1ps

module tb_freq_divider;

    // Parameters
    parameter DIVISOR    = 7;
    parameter DUTY_CYCLE = 50;

    // Testbench signals
    reg  clk;
    reg  rst_n;
    wire clk_out;

    // Instantiate DUT
    freq_divider #(
        .DIVISOR(DIVISOR),
        .DUTY_CYCLE(DUTY_CYCLE)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .clk_out(clk_out)
    );

    // Clock generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset sequence
    initial begin
        rst_n = 0;
        #20;
        rst_n = 1;
    end

    // Monitor
    initial begin
        $display("Time\tclk\trst_n\tclk_out");
        $monitor("%0t\t%b\t%b\t%b",
                 $time, clk, rst_n, clk_out);
    end

    // Simulation stop
    initial begin
        #300;
        $finish;
    end

endmodule
