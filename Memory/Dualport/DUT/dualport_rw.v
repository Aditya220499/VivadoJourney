`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2025 13:45:34
// Design Name: 
// Module Name: dualport_rw
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


module dualport_rw #(
    parameter ADDR_WIDTH = 2,    // Address width (2 bits = 4 locations)
    parameter DATA_WIDTH = 4,    // Data width (4 bits)
    parameter ARR_WIDTH = 4      // Array width
)(
    output reg [DATA_WIDTH-1 : 0]data_out,
    input [DATA_WIDTH-1 : 0]data_in,
    input read_en,
    input write_en,
    input rst,
    input clk,
    input [ADDR_WIDTH-1 : 0]read_address,
    input [ADDR_WIDTH-1 : 0]write_address
    );

    reg [DATA_WIDTH-1 : 0]Mem[0 : ARR_WIDTH-1];

    initial begin
      Mem[0] = 4'hA;
      Mem[1] = 4'hB;
      Mem[2] = 4'hC;
      Mem[3] = 4'hD;
    end

    always @(posedge clk or posedge rst) begin
      if(rst) begin
        data_out <= 0;
      end
      else begin
        if(write_en) begin
          Mem[write_address] <= data_in;
        end
        if(read_en) begin
          data_out <= (write_en && write_address==read_address) ? data_in : Mem[read_address];
        end
        else begin
                data_out <= data_out;  // Hold last value when read_en = 0 (synthesizable)
            end
      end

    end

endmodule
