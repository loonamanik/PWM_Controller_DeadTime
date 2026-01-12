`include "pwm_improved.v"
`include "dead_time_gen.v"

module pwm_top
    #(parameter R=8, TIMER_BITS=8, DT_WIDTH=8)(
    input clk,
    input reset_n,
    input [R:0] duty, // Control the Duty Cycle
    input [TIMER_BITS - 1:0] FINAL_VALUE, // Control the switching frequency
    input [DT_WIDTH - 1:0] dt_value, // Dead time control  
    output pwm_high,
    output pwm_low
);

wire pwm_in;
pwm_improved #(.R(R), .TIMER_BITS(TIMER_BITS)) pwm_inst (
    .clk(clk),
    .reset_n(reset_n),
    .duty(duty),
    .FINAL_VALUE(FINAL_VALUE),
    .pwm_out(pwm_in)
);

dead_time_gen #(.DT_WIDTH(DT_WIDTH)) dead_time_inst (
    .clk(clk),
    .reset_n(reset_n),
    .dt_value(dt_value),
    .pwm_in(pwm_in),
    .pwm_high(pwm_high),
    .pwm_low(pwm_low)
);

endmodule
