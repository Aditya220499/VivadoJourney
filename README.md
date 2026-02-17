# RTL Design and SoC Lab

This repository contains structured RTL implementations and verification experiments 
focused on strengthening digital design fundamentals and SoC integration readiness.

It is a continuously evolving design lab — not a single monolithic project.

---

## Scope

This repository includes:

- Combinational logic designs (e.g., adder)
- Sequential logic designs (e.g., FIFO, RAM, ROM)
- Memory architectures (synchronous and asynchronous)
- Basic SystemVerilog testbenches
- UVM-based verification experiments
- Structural design practice

Each design is implemented independently and may include:
- RTL implementation
- Basic testbench
- Optional UVM environment

Not all modules have full verification coverage — the focus is on 
clean RTL design and architectural understanding.

---

## Design Focus Areas

### RTL Design Fundamentals
- Synthesizable coding style
- Blocking vs non-blocking discipline
- Reset strategies
- Parameterization
- Sequential state control

### Memory Architecture
- Dual-port RAM
- Synchronous vs asynchronous ROM
- FIFO pointer logic

### Verification Practice
- Basic SV testbench structure
- Driver / Monitor / Scoreboard architecture
- UVM component hierarchy (for selected designs)

---

## Objective

This lab supports preparation for:

- RTL Design Engineer roles
- SoC Integration Engineer roles

Primary focus is on:
- Strong digital fundamentals
- Clean RTL architecture
- Structural reasoning
- Scalable design discipline

---

## Future Additions

- Asynchronous FIFO (Gray-coded pointer)
- CDC synchronizer modules
- APB-lite slave implementation
- Top-level SoC integration demo
