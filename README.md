# Automated Vehicle Access Control System (FPGA-Based FSM Controller)

## Project Overview

The Automated Vehicle Access Control System is a hardware-level parking management solution that autonomously regulates vehicle entry and exit using a Finite State Machine (FSM) controller implemented on an FPGA. The system manages barrier gate operations in real-time with sub-millisecond response times, providing robust handling of edge cases such as vehicle stalling and simultaneous access attempts.

## Objectives

1. **FSM Design & Synthesis**: Design and synthesize a hazard-free, synchronous Finite State Machine in Verilog to manage real-time barrier operations (Idle → Authenticating → Raising → Opened → Lowering → Idle) with sub-millisecond state transitions.

2. **Comprehensive Testing**: Validate system functionality and edge-case behaviors (vehicle stalling under the gate, consecutive simultaneous entries) through a complete behavioral simulation testbench.

## System Architecture

### State Machine Flow

The control system operates as a synchronous FSM driven by a global clock (clk). State transitions are governed by two primary input vectors:
- **Vehicle approach signal** (`auth_valid`)
- **Gate position sensors** (`gate_fully_open`, `gate_fully_closed`, `sensor_back`)

```
                    +-------------------+
                    |       IDLE        |◄──────────────────────────┐
                    +-------------------+                           │
                          │                                         │
                 (auth_valid = 1)                                   │
                          ▼                                         │
                    +-------------------+                           │
                    |   AUTHENTICATING  |                           │
                    +-------------------+                           │
                          │                                         │
                  (auth_granted = 1)                                │
                          ▼                                         │
                    +-------------------+                           │
                    |     RAISING       |                           │
                    +-------------------+                           │
                          │                                         │
                 (gate_fully_open = 1)                              │
                          ▼                                         │
                    +-------------------+                           │
                    |      OPENED       |                           │
                    +-------------------+                           │
                          │                                         │
                   (sensor_back = 1)                                │
                          ▼                                         │
                    +-------------------+                           │
                    |     LOWERING      |                           │
                    +-------------------+                           │
                          │                                         │
                 (gate_fully_closed = 1)                            │
                          └──────────────────────────────────────────┘
```

## Hardware Components

### FPGA Development Board
- **Target Platforms**: Altera/Intel Cyclone IV (EP4CE6) or Xilinx Spartan-6
- **Key Features**: Stable internal clock generators, ample GPIO pins, sufficient logic resources for FSM and I/O control

### Actuators
- **Gate Control**: MG996R High-Torque Servo Motor or DC Stepper Motor
- **Driver**: H-Bridge motor driver module for bidirectional barrier actuation

### Vehicle Detection Sensors
- **Front Sensor**: E18-D80NK Infrared Proximity Sensor or HC-SR04 Ultrasonic Sensor
- **Rear Sensor**: Matching sensor unit for rear clearance detection
- **Mounting**: Entrance line and rear clearance line positions

### Signaling & Feedback
- **Status Indicators**: Red/Green LED arrays
- **Audio Feedback**: Active piezoelectric buzzer for authentication events

## Project Structure

```
.
├── hardware/
│   ├── barrier_fsm.v           # Core FSM module with sequential logic
│   ├── pin_assignment.qsf      # FPGA pin mappings and I/O constraints
│   └── constraint_file.ucf     # Additional timing and placement constraints
├── simulation/
│   ├── tb_barrier.v            # Testbench module with stimulus generation
│   ├── test_cases.v            # Edge-case test scenarios
│   └── waveforms/              # Simulation output waveforms
├── documentation/
│   ├── system_report.md        # Technical specifications and analysis
│   ├── design_doc.md           # Detailed design decisions
│   └── timing_analysis.txt     # Clock domain and timing constraints
└── README.md                   # This file
```

## Getting Started

### Prerequisites
- Quartus Prime (Intel/Altera) or Vivado (Xilinx)
- Modelsim or equivalent Verilog simulator
- Development board and associated drivers

### Building the Project

1. **Synthesis**: Open your FPGA IDE, import `barrier_fsm.v` and `pin_assignment.qsf`
2. **Simulation**: Run testbench `tb_barrier.v` to verify functionality
3. **Programming**: Generate bitstream and program your development board

## Key Features

✓ Sub-millisecond FSM state transitions  
✓ Robust edge-case handling  
✓ Hazard-free synchronous design  
✓ Full behavioral simulation coverage  
✓ Production-ready gate control logic  

## References

1. Brown, S., & Vranesic, Z. (2013). *Fundamentals of Digital Logic with Verilog Design*. McGraw-Hill Education.
2. Palnitkar, S. (2003). *Verilog HDL: A Guide to Digital Design and Synthesis*. Prentice Hall Professional.
3. Chu, P. P. (2008). *FPGA Prototyping by Verilog Examples: Xilinx Spartan-3 Version*. John Wiley & Sons.

## Author & License

**Author**: Ni-ear  
**Last Updated**: August 2026  

---
*For questions or contributions, please open an issue or submit a pull request.*
