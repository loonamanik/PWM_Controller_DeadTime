

module pwm_top_sweep_tb();
    localparam R = 8, TIMER_BITS = 8, DT_WIDTH = 8, T = 10;
    reg clk, reset_n;
    reg [R:0] duty;
    reg [TIMER_BITS-1:0] final_val;
    reg [DT_WIDTH-1:0] dt_val;
    wire pwm_h, pwm_l;

    pwm_top #(.R(R), .TIMER_BITS(TIMER_BITS), .DT_WIDTH(DT_WIDTH)) uut (
        .clk(clk), .reset_n(reset_n), .duty(duty),
        .FINAL_VALUE(final_val), .dt_value(dt_val),
        .pwm_high(pwm_h), .pwm_low(pwm_l)
    );

    initial clk = 1'b0;
    always #(T/2) clk = ~clk;

    initial begin
        reset_n = 0; duty = 192; final_val = 4; dt_val = 20;
        #100 reset_n = 1; // Short reset
        #15000;            // Simulate only 2 microseconds
        $display("Done");
        $finish;
    end
endmodule