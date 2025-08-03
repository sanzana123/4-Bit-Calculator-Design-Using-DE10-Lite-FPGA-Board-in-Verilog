# Features
- User input through 4x4 keypad (rows and columns scanning)
- Arithmetic operations managed by an FSM-based Control Unit
- Arithmetic Unit handles addition and subtraction with flag outputs (overflow, zero)
- Output shown on three 7-segment HEX displays and status LEDs
- Supports clear entry and clear all functionality
- Multiplexed display outputs for efficient hardware use

# Module Overview
- ControlUnit: FSM managing load signals, reset, operation selection, and triggers
- InputUnit: Scans keypad, debounces input, outputs key value
- ArithmeticUnit: Performs arithmetic calculations and sets flags
- OutputUnit: Drives HEX displays based on calculation result
- Mux: Selects between immediate input or arithmetic output for display

# Building and Running
### Requirements
- Intel Quartus Prime software
- DE10-Lite FPGA development board

# Steps
- Open Intel Quartus Prime and create a new project targeting the DE10-Lite board.
- Add your Verilog source files including termProject.v and submodules.
- Assign the correct pin mappings for the DE10-Lite board (keypad rows/columns, HEX displays, LEDs).
- Compile the project.

Program the FPGA using a USB-Blaster cable.

Use the keypad to enter values and perform calculations; results will show on HEX displays and LEDs.
