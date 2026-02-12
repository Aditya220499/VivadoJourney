`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2025 18:54:39
// Design Name: 
// Module Name: rom4x4_async
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


module rom4x4_async#(
    parameter ADDR_WIDTH = 2,    // Address width (2 bits = 4 locations)
    parameter DATA_WIDTH = 4,    // Data width (4 bits)
    parameter ARR_WIDTH = 4      // Array width
)(
    output reg[DATA_WIDTH-1:0]rom_data_out,
    input [ADDR_WIDTH-1:0]address
    );
    reg [DATA_WIDTH-1:0]ROM[0:ARR_WIDTH-1];   // Array of vectors

    initial begin
      rom_data_out = 0;
      ROM[0] = 4'hA;
      ROM[1] = 4'h8;
      ROM[2] = 4'h2;
      ROM[3] = 4'hE;
    end

    always @(address) begin
      rom_data_out = ROM[address];     //Read from ROM
    end
endmodule
