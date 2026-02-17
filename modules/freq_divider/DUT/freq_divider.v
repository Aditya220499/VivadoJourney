module freq_divider #(
    parameter integer DIVISOR = 10,        // Divide factor
    parameter integer DUTY_CYCLE = 70      // Duty cycle in percentage (0-100)
)(
    input  wire clk,
    input  wire rst_n,
    output reg  clk_out
);

    // Counter width calculation
    localparam COUNTER_WIDTH = $clog2(DIVISOR);

    reg [COUNTER_WIDTH-1:0] counter;

    // Calculate high-time threshold
    localparam integer HIGH_COUNT = (DIVISOR * DUTY_CYCLE) / 100;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 0;
            clk_out <= 0;
        end
        else begin
            if (counter == DIVISOR - 1)
                counter <= 0;
            else
                counter <= counter + 1;

            // Duty cycle control
            if (counter < HIGH_COUNT)
                clk_out <= 1'b1;
            else
                clk_out <= 1'b0;
        end
    end

endmodule