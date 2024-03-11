`timescale 1ns / 1ps


module clock_10Hz(
    input clk,
    output reg ten_hertz

    );


integer counter = 0;
localparam clk_div = 20_000_000;

always @ (posedge clk) begin
    counter <= counter + 1;
    if(counter >= (clk_div-1))
        counter <= 0;
    ten_hertz <= (counter < (clk_div/2)) ? 1 : 0;
end

endmodule
