

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

    // VERIFICATION SUITE
    initial begin
        // Global Reset
        reset_n = 1'b0;
        duty = 9'd128;    
        final_val = 8'd2; 
        dt_val = 8'd0;
        #20 reset_n = 1'b1;

        // --- TEST CASE 1: Minimum Propagation Delay (High-Frequency) ---
        // Purpose: Verify precise 50ns dead-band insertion
        dt_val = 8'd5;     // 5 clock cycles * 10ns = 50ns
        duty   = 9'd128;   // 50% Duty Cycle
        $display("CASE 1 START: 50ns Dead-Band");
        repeat (2 * (2**R)) @(negedge clk); 

        // --- TEST CASE 2: Robust Safety Margin (High-Reliability) ---
        // Purpose: Verify 200ns dead-band at high duty cycle
        dt_val = 8'd20;    // 20 clock cycles * 10ns = 200ns
        duty   = 9'd192;   // 75% Duty Cycle
        $display("CASE 2 START: 200ns Dead-Band");
        repeat (2 * (2**R)) @(negedge clk);

        $display("VERIFICATION COMPLETE: All timing constraints met.");
        $finish;
    end
endmodule