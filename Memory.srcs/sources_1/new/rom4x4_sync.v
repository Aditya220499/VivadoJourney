`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2025 21:46:13
// Design Name: 
// Module Name: rom4x4_sync
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


module rom4x4_sync #(
    parameter ADDR_WIDTH = 2,    // Address width (2 bits = 4 locations)
    parameter DATA_WIDTH = 4,    // Data width (4 bits)
    parameter ARR_WIDTH = 4      // Array width
)(
    output reg [DATA_WIDTH-1 : 0]rom_data_out,
    input en,
    input rst,
    input clk,
    input [ADDR_WIDTH-1 : 0]address
    );

    reg [DATA_WIDTH-1 : 0]ROM[0 : ADDR_WIDTH];
    initial begin
      ROM[0] = 4'hA;
      ROM[1] = 4'h8;
      ROM[2] = 4'hF;
      ROM[3] = 4'h2;
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
          rom_data_out <= 0;
        end
        else if(en) begin
          rom_data_out <= ROM[address];
        end
        else rom_data_out <= 4'bzzzz;
     end
     
endmodule
