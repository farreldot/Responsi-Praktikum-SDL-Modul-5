module fsm_moore_101(
    input wire clk,
    input wire reset,
    input wire ce,
    input wire w,
    output reg y,
    output wire [1:0] state_display
);
    parameter S0 = 2'b00; // belum ada pola cocok
    parameter S1 = 2'b01; // sudah menerima 1
    parameter S2 = 2'b10; // sudah menerima 10
    parameter S3 = 2'b11; // sudah menerima 101, output aktif

    reg [1:0] curr = S0;
    reg [1:0] next;

    assign state_display = curr;

    always @(posedge clk or posedge reset) begin
        if (reset) curr <= S0;
        else if (ce) curr <= next;
    end

    always @(*) begin
        y = (curr == S3); // Moore: output hanya bergantung pada current state
        case (curr)
            S0: next = (w) ? S1 : S0;
            S1: next = (w) ? S1 : S2;
            S2: next = (w) ? S3 : S0;
            S3: next = (w) ? S1 : S2; // overlap setelah pola 101
            default: next = S0;
        endcase
    end
endmodule
