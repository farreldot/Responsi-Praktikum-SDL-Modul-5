module top(
    input wire clk_100MHz,
    input wire sw0,
    input wire btnc,
    input wire btnd,
    output wire led_y,
    output wire led_hb,
    output wire [6:0] seg,
    output wire [7:0] an
);
    wire step_pulse, rst_level, y;
    wire [1:0] st;

    debouncer db_step(.clk(clk_100MHz), .btn_in(btnc), .btn_pulse(step_pulse), .btn_level());
    debouncer db_rst (.clk(clk_100MHz), .btn_in(btnd), .btn_pulse(), .btn_level(rst_level));

    clock_divider hb(.clk_100MHz(clk_100MHz), .reset(rst_level), .led_hb(led_hb));

    fsm_moore_101 fsm(
        .clk(clk_100MHz),
        .reset(rst_level),
        .ce(step_pulse),
        .w(sw0),
        .y(y),
        .state_display(st)
    );

    display disp(
        .clk(clk_100MHz),
        .w_in(sw0),
        .y_out(y),
        .state(st),
        .seg(seg),
        .an(an)
    );

    assign led_y = y;
endmodule
