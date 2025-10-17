`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2025 09:50:56 PM
// Design Name: 
// Module Name: blinker_unit
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

module blinker_unit #(parameter CNT_WIDTH = 16)(
    input  logic              clk,
    input  logic              rst,
    input  logic [CNT_WIDTH-1:0] interval_ms,
    output logic              led_o
);

    localparam MS_TICK_MAX = 100000;
    logic [$clog2(MS_TICK_MAX)-1:0] ms_tick_reg;
    logic [CNT_WIDTH-1:0]           main_cnt_reg;
    logic                           led_reg;
    logic [$clog2(MS_TICK_MAX)-1:0] ms_tick_next;
    logic [CNT_WIDTH-1:0]           main_cnt_next;
    logic                           led_next;
    logic                           ms_tick;

    assign ms_tick = (ms_tick_reg == MS_TICK_MAX - 1);

    always_comb
    begin
        ms_tick_next  = ms_tick_reg;
        main_cnt_next = main_cnt_reg;
        led_next      = led_reg;

        if (ms_tick_reg == MS_TICK_MAX - 1)
            ms_tick_next = 0;
        else
            ms_tick_next = ms_tick_reg + 1;

        if (ms_tick)
        begin
            if (main_cnt_reg == interval_ms)
            begin
                main_cnt_next = 0;
                led_next      = ~led_reg;
            end
            else
            begin
                main_cnt_next = main_cnt_reg + 1;
            end
        end
    end

    always_ff @(posedge clk, posedge rst)
    begin
        if (rst)
        begin
            ms_tick_reg  <= 0;
            main_cnt_reg <= 0;
            led_reg      <= 1'b0;
        end
        else
        begin
            ms_tick_reg  <= ms_tick_next;
            main_cnt_reg <= main_cnt_next;
            led_reg      <= led_next;
        end
    end

    assign led_o = led_reg;

endmodule