module pwm_improved
    #(parameter R = 8, TIMER_BITS = 8)(
    input clk,
    input reset_n,
    input [R:0] duty, 
    input [TIMER_BITS - 1:0] FINAL_VALUE, 
    output pwm_out
    );
    
    reg [R - 1:0] Q_reg;
    reg d_reg;
    wire tick;
    
    // Prescaler Timer Instance [cite: 59]
    timer_input #(.BITS(TIMER_BITS)) timer0 (
        .clk(clk),
        .reset_n(reset_n),
        .enable(1'b1),
        .FINAL_VALUE(FINAL_VALUE),
        .done(tick)
    );

    // Optimized synchronous block
    always @(posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            Q_reg <= {R{1'b0}}; // Use replication for cleaner reset
            d_reg <= 1'b0;
        end else if (tick) begin
            Q_reg <= Q_reg + 1'b1;
            d_reg <= (Q_reg < duty); // Correct comparison [cite: 58]
        end
    end
    
    assign pwm_out = d_reg;
endmodule