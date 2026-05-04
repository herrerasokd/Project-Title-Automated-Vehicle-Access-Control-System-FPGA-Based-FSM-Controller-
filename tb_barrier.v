`timescale 1ns / 1ps

module tb_barrier;
    reg clk, reset, payment, exit_sensor, obstruction;
    wire [1:0] gate_state;

    // Connect to the FSM
    barrier_fsm uut (
        .clk(clk), .reset(reset), .payment(payment), 
        .exit_sensor(exit_sensor), .obstruction(obstruction), 
        .gate_state(gate_state)
    );

    // Simple Clock
    initial clk = 0;
    always #5 clk = ~clk;

    // Direct driving - no complex timing yet
    initial begin
        reset = 1; payment = 0; exit_sensor = 0; obstruction = 0;
        #20 reset = 0;
        #20 payment = 1;
        #20 payment = 0;
    end
endmodule