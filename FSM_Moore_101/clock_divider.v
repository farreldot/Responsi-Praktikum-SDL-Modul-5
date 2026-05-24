module clock_divider(
    input wire clk_100MHz,
    input wire reset,
    output reg led_hb
);
    localparam MAX = 100_000_000;
    reg [26:0] count = 0;

    always @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
            count <= 0;
            led_hb <= 0;
        end else begin
            if (count >= MAX - 1) begin
                count <= 0;
                led_hb <= ~led_hb;
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule
