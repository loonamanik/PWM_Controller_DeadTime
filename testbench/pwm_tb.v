
module pwm_tb(

);

localparam R =8;
reg clk,reset;
reg [R-1:0] duty;
wire pwm_out;

// Instantiate the PWM module
pwm_basic #(.R(R)) pwm_inst(
    .clk(clk),
    .reset(reset),
    .duty(duty),
    .pwm_out(pwm_out)
);

// timer
initial 
    #(7*2**R*T) $finish;

// clock generation
localparam T=10;
always
    begin
        clk=1'b0;
        #(T/2);
        clk=1'b1;
        #(T/2);
    end

initial
    begin
        reset = 1'b0;
        #2
        reset = 1'b1;
        duty = 0.25*(2**R);

        repeat (2 * 2**R) @(negedge clk);
        duty = 0.5*(2**R);

        repeat (2 * 2**R) @(negedge clk);
        duty = 0.75*(2**R);
    end

endmodule

