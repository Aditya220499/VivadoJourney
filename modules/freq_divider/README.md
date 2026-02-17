# Parameterized Frequency Divider (Verilog)

## Overview

This module implements a parameterized frequency divider with configurable duty cycle.

It divides the input clock by a programmable integer divisor and generates an output signal with a programmable duty cycle percentage.

---

## Features

- Parameterized divide factor
- Adjustable duty cycle (0–100%)
- Fully synthesizable
- Reset-controlled
- Clean synchronous implementation

---

## Module Parameters

- `DIVISOR`  
  Number of input clock cycles per output period.

- `DUTY_CYCLE`  
  Output high time percentage (integer 0–100).

---

## Design Logic

For a given `DIVISOR`:

- One output period = `DIVISOR` input clock cycles
- High time = `(DIVISOR × DUTY_CYCLE) / 100`
- Low time = remaining cycles

The design uses:

- A counter from `0` to `DIVISOR-1`
- A comparator to determine high vs low phase

---

## Important Limitation (Odd Division Factors)

Exact 50% duty cycle is not possible for odd `DIVISOR` values.

Example:

```
DIVISOR = 7
DUTY_CYCLE = 50
```

Mathematically:

- Required high time = 3.5 cycles (impossible)
- Implemented high time = 3 cycles
- Actual duty ≈ 42.8%

This is a fundamental limitation of integer clock division.

---

## Why Logic-Based Clock Division Is Not Used in Real Designs

Although this module is synthesizable, generating clocks using logic is generally discouraged in real ASIC and FPGA designs.

Reasons:

- Generated clocks create new clock domains
- Clock tree synthesis does not treat logic-generated clocks properly
- Risk of clock skew
- Increased hold violations
- Timing closure complexity

---

## What Is Used in Real FPGA/ASIC Designs

### In FPGA:

- PLL (Phase Locked Loop)
- MMCM (Mixed-Mode Clock Manager)
- Dedicated clock divider hardware
- Clock enable signals instead of new clocks

### In ASIC:

- PLL-based clock generation
- Dedicated clock divider cells
- Clock gating cells
- Clock enable techniques

Instead of generating new clocks, designers typically generate a **clock enable** signal and use it within a single clock domain.

Example:

```verilog
if (clk_enable)
    data <= next_data;
```

This avoids multiple clock domains and simplifies timing closure.

---

## When This Design Is Appropriate

- Educational purposes
- Interview problems
- Generating clock enable pulses
- Simple low-speed logic

Not recommended for production clock-tree generation.

---

## Testbench

The provided testbench:

- Generates a 10ns clock
- Applies active-low reset
- Displays waveform behavior
- Demonstrates odd division duty asymmetry

---

## Learning Outcomes

- Counter-based clock division
- Integer duty cycle computation
- Limitations of odd division
- Clock-domain discipline awareness
- Practical design tradeoffs
