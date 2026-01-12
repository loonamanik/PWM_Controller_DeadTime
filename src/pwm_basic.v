
module pwm_basic
#(parameter R =8)(
    input clk,
    input reset,
    input [R-1:0] duty,
    output pwm_out
);

// UP Counter
reg [R-1:0] Q_reg,Q_next;

always@(posedge clk, negedge reset)
begin
    if(~reset)
        Q_reg <= 0;
    else
        Q_reg <= Q_next; 
end

// next state logic
always@(*)
begin
    Q_next = Q_reg +1;
end

// output logic

assign pwm_out = (Q_reg < duty);

endmodule