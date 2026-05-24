module display(
    input wire clk,
    input wire w_in,
    input wire y_out,
    input wire [1:0] state,
    output reg [6:0] seg,
    output reg [7:0] an
);
    reg [16:0] scan = 0;
    wire [2:0] sel = scan[16:14];

    always @(posedge clk) scan <= scan + 1;

    function [6:0] seg_bin;
        input bitval;
        begin
            case (bitval)
                1'b0: seg_bin = 7'b1000000; // 0
                1'b1: seg_bin = 7'b1111001; // 1
            endcase
        end
    endfunction

    always @(*) begin
        an = 8'b11111111;
        an[sel] = 1'b0;

        case (sel)
            3'd7: seg = 7'b1100011;       // w
            3'd6: seg = seg_bin(w_in);    // X
            3'd5: seg = 7'b0010001;       // y
            3'd4: seg = seg_bin(y_out);   // X
            3'd3: seg = 7'b0010010;       // S
            3'd2: seg = 7'b0000111;       // t
            3'd1: seg = seg_bin(state[1]); // state bit MSB
            3'd0: seg = seg_bin(state[0]); // state bit LSB
            default: seg = 7'b1111111;
        endcase
    end
endmodule
