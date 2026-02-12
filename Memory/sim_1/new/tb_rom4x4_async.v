`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2025 19:34:33
// Design Name: 
// Module Name: tb_rom4x4_async
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


module tb_rom4x4_async;
    reg [1:0]address;
    wire [3:0]rom_data_out;

    rom4x4_async dut(.rom_data_out(rom_data_out) , .address(address));
       
    initial begin
        address = 0;
        $strobe("---------------Start Simulation----------------");
        $monitor("Address :: %d || Data out :: %h",address,rom_data_out);
        for(integer i = 0; i < 4 ; i = i + 1)  begin
             address = i; #5;
        end
        $strobe("---------------End Simulation-----------------");
    end

endmodule
