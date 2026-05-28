 # Automated Vehicle Access Control System - FPGA-Based FSM Controller

## Project Overview
The Automated Vehicle Access Control System is a high-performance hardware-level parking management system designed to regulate vehicle entry and exit points autonomously. Implemented entirely via a Finite State Machine (FSM) on a Field Programmable Gate Array (FPGA), the controller interfaces directly with vehicle classification sensors (ultrasonic/infrared) and electromechanical gates to manage vehicle flow.

## Objectives
-Objective 1: Design and synthesize a robust, hazard-free Finite State Machine in Verilog to handle real-time barrier operations (Idle, Authenticating, Raising, Opened, Lowering) with sub-millisecond propagation delays.

-Objective 2: Validate system functionality and edge-case behaviors (e.g., vehicle stalling underneath the gate or consecutive simultaneous entries) using a complete behavioral simulation testbench prior to physical synthesis.

## System Architecture
The core of the control hardware centers on a synchronous Finite State Machine running on a global clock cycle (clk). State transactions rely on two primary hardware status vectors: vehicle approach sensors (sensor\_front, sensor\_back) and authorization signal triggers (auth\_valid).
+-------------------+
                      |       IDLE        |<------------------------+
                      +-------------------+                         |
                                |                                   |
                        (auth_valid = 1)                            |
                                v                                   |
                      +-------------------+                         |
                      |      RAISING      |                         |
                      +-------------------+                         |
                                |                                   |
                       (gate_fully_open = 1)                        |
                                v                                   |
                      +-------------------+                         |
                      |      OPENED       |                         |
                      +-------------------+                         |
                                |                                   |
                       (sensor_back = 1)                            |
                                v                                   |
                      +-------------------+                         |
                      |     LOWERING      |                         |
                      +-------------------+                         |
                                |                                   |
                      (gate_fully_closed = 1)                       |
                                +-----------------------------------+

## Hardware Components
-FPGA Development Board
Target Board: Altera/Intel Cyclone IV (EP4CE6) or Xilinx Spartan-6 development board. These platforms provide highly stable internal hardware clock generators and ample General Purpose Input/Output (GPIO) pins for sensor attachment.

-Peripheral Components
Actuators: High-torque MG996R Servo Motor or DC Stepper Motor running via an H-Bridge driver module to manipulate the physical barrier lever arm.

-Vehicle Detection Sensors: E18-D80NK Infrared Proximity Obstacle Avoidance Sensors or HC-SR04 Ultrasonic Sensor units mounted at the front entrance line and rear clearance line.

-Signaling Units: High-brightness Red/Green LED status arrays and an active piezoceramic buzzer element for authentication feedback flags.

## Project Structure
├── hardware/
│   ├── barrier_fsm.v      # Core Verilog Module: Handles sequential & combinational FSM states
│   └── pin_assignment.qsf # Physical Pin Mapping configurations for the FPGA board
├── simulation/
│   └── tb_barrier.v       # Behavioral Testbench: Drives simulation waveforms 
└── documentation/
    └── system_report.md   # Final Technical Reference Specifications

## References
Brown, S., & Vranesic, Z. (2013). Fundamentals of Digital Logic with Verilog Design. McGraw-Hill Education.

Palnitkar, S. (2003). Verilog HDL: A Guide to Digital Design and Synthesis. Prentice Hall Professional.

Chu, P. P. (2008). FPGA Prototyping by Verilog Examples: Xilinx Spartan-3 Version. John Wiley & Sons.
