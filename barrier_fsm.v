module barrier_fsm (
    input clk, reset, payment, exit_sensor, obstruction,
    output reg [1:0] gate_state // 00:Idle, 01:Opening, 10:Open, 11:Closing
);

    // Define states
    parameter IDLE = 2'b00, OPENING = 2'b01, OPEN = 2'b10, CLOSING = 2'b11;

    always @(posedge clk or posedge reset) begin
        if (reset) gate_state <= IDLE;
        else begin
            // EMERGENCY SAFETY RULE (The "Wow" Factor)
            if (obstruction) gate_state <= OPENING; 
            
            else case (gate_state)
                IDLE:    if (payment) gate_state <= OPENING;
                OPENING: gate_state <= OPEN; // Simplified for logic
                OPEN:    if (exit_sensor) gate_state <= CLOSING;
                CLOSING: if (gate_state == CLOSING && !obstruction) gate_state <= IDLE;
            endcase
        end
    end
endmodule