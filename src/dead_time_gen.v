module dead_time_gen #(parameter DT_WIDTH = 8)(
    input clk, reset_n, pwm_in,
    input [DT_WIDTH-1:0] dt_value,
    output reg pwm_high, pwm_low
);
    reg [DT_WIDTH-1:0] count;
    reg pwm_reg; // This acts as our "stable" reference

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            pwm_reg <= 0;
            count   <= 0;
            pwm_high <= 0;
            pwm_low  <= 0;
        end else begin
            // 1. Buffer the input to ensure we aren't racing the PWM module
            pwm_reg <= pwm_in;

            // 2. Detect edge on the buffered signal
            if (pwm_in != pwm_reg) begin
                count <= 0;
            end else if (count < dt_value) begin
                count <= count + 1'b1;
            end

            // 3. Output Logic using the buffered pwm_reg
            // This ensures count has already been reset by the time we check it
            pwm_high <= (pwm_reg && (count >= dt_value));
            pwm_low  <= (!pwm_reg && (count >= dt_value));
        end
    end
endmodule