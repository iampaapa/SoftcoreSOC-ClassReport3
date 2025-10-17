`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2025 09:55:49 PM
// Design Name: 
// Module Name: blinking_led_core
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

module blinking_led_core #(
    parameter N_LEDS    = 4,
    parameter CNT_WIDTH = 16
)
(
    input  logic              clk,
    input  logic              rst,
    input  logic              cs,
    input  logic              write,
    input  logic [4:0]          addr,
    input  logic [31:0]         wr_data,
    output logic [31:0]         rd_data,
    output logic [N_LEDS-1:0]   led
);
    // 4 16-bit registers to hold the interval values from the CPU.
    logic [CNT_WIDTH-1:0] interval_regs [N_LEDS-1:0];

    //interval registers
    always_ff @(posedge clk)
    begin
        if (cs & write)
        begin
            interval_regs[addr[1:0]] <= wr_data[CNT_WIDTH-1:0];
        end
    end

    // Create N_LEDS instances of the blinker_unit.
    genvar i;
    generate
        for (i = 0; i < N_LEDS; i = i + 1)
        begin : gen_blinker
            blinker_unit #(.CNT_WIDTH(CNT_WIDTH))
            u_blinker
            (
                .clk(clk),
                .rst(rst),
                .interval_ms(interval_regs[i]),
                .led_o(led[i])
            );
        end
    endgenerate

    assign rd_data = 32'b0;

endmodule