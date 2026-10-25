# 3:8 Decoder in Verilog

## Overview

This project implements and simulates a 3:8 binary decoder with an active-HIGH enable input using Verilog.

A 3:8 decoder converts a 3-bit binary input into an 8-bit output, where exactly one output line is activated based on the input combination when the decoder is enabled.

The project demonstrates basic combinational logic design, Verilog case statements, enable signal implementation, testbench development, simulation, and waveform analysis.

The design was simulated using Icarus Verilog, with GTKWave used to analyze the resulting signal waveforms.

## Design

The 3:8 Decoder consists of:

- **in[2:0]** - 3-bit binary input
- **en** - Active-HIGH enable input
- **out[7:0]** - 8-bit decoded output

The decoder operates based on the enable signal:

- `en = 0` - Decoder disabled, all outputs LOW
- `en = 1` - Decoder enabled, one output HIGH based on the binary input

When enabled, each 3-bit input activates its corresponding output line.

For example:

`in = 3'b000 → out = 8'b00000001`

`in = 3'b011 → out = 8'b00001000`

`in = 3'b111 → out = 8'b10000000`

The decoder follows a one-hot output representation, where only one output bit is HIGH at a time when enabled.

### Truth Table

| **Enable (en)** | **Binary Input (in[2:0])** | **Output (out[7:0])** |
| --------------- | -------------------------- | --------------------- |
| 0 | 000 | 00000000 |
| 0 | 001 | 00000000 |
| 0 | 010 | 00000000 |
| 0 | 011 | 00000000 |
| 0 | 100 | 00000000 |
| 0 | 101 | 00000000 |
| 0 | 110 | 00000000 |
| 0 | 111 | 00000000 |
| 1 | 000 | 00000001 |
| 1 | 001 | 00000010 |
| 1 | 010 | 00000100 |
| 1 | 011 | 00001000 |
| 1 | 100 | 00010000 |
| 1 | 101 | 00100000 |
| 1 | 110 | 01000000 |
| 1 | 111 | 10000000 |

When `en = 0`, all output lines remain LOW regardless of the binary input.

When `en = 1`, the decoder activates the output line corresponding to the decimal value of the input.

## Verilog Implementation

The decoder is implemented using a Verilog `case` statement inside an `always @(*)` block.

The enable signal determines whether the decoder operates or keeps all outputs LOW.

Each possible 3-bit input is mapped to its corresponding output bit.

For example:

```verilog
3'b000: out[0] = 1'b1;
3'b001: out[1] = 1'b1;
3'b010: out[2] = 1'b1;
3'b011: out[3] = 1'b1;
```

When `in = 3'b000` and `en = 1`, output bit `out[0]` becomes HIGH.

When `in = 3'b011` and `en = 1`, output bit `out[3]` becomes HIGH.

When `en = 0`, the output is assigned `8'b00000000`, disabling all output lines.

The `always @(*)` block ensures that the output is updated whenever an input signal used by the combinational logic changes.

Since the output depends only on the current input and enable signals, the decoder is a combinational logic circuit.

## Simulation Environment

| **Tool** | **Purpose** |
| -------- | ----------- |
| Verilog | Hardware Description Language |
| Icarus Verilog | Compilation and simulation |
| GTKWave | Simulation waveform visualization |
| VS Code | Source code development environment |

## Testbench Verification

The testbench verifies the 3:8 decoder by applying all 16 possible combinations of the enable signal and 3-bit binary input.

A `for` loop is used to increment a 4-bit concatenation of the enable and input signals from decimal 0 to 15.

Each input combination is applied for 10 simulation time units.

The testbench generates a VCD file containing the enable, input, and output signals for waveform analysis.

The simulation covers:

- All eight input combinations with the decoder disabled
- All eight input combinations with the decoder enabled
- Correct one-hot output generation
- All 16 possible binary combinations of the enable and input signals

### Test Sequence

The testbench applies the following sequence:

**Decoder Disabled (`en = 0`):**

`000 → 001 → 010 → 011 → 100 → 101 → 110 → 111`

For all eight combinations, the output remains `00000000`.

**Decoder Enabled (`en = 1`):**

`000 → 001 → 010 → 011 → 100 → 101 → 110 → 111`

The corresponding output changes according to the decoder truth table.

The complete simulation duration is 160 time units, equivalent to 160 ns when the testbench uses a `1ns` time unit.

## GTKWave Simulation

The generated VCD file was loaded into GTKWave to observe the behavior of the decoder over the complete simulation.

The waveform includes:

- **en** - Enable signal
- **in[2:0]** - 3-bit binary input
- **out[7:0]** - 8-bit decoded output

Each 10-time-unit interval represents one combination of the enable and input signals.

During the first 80 time units, the decoder remains disabled.

During the next 80 time units, the decoder is enabled, and the output changes according to the binary input.

### Simulation Results

| **Simulation Time** | **Enable** | **Input (Binary)** | **Output (Hex)** |
| ------------------- | ---------- | ------------------ | ---------------- |
| 0–10 | 0 | 000 | 00 |
| 10–20 | 0 | 001 | 00 |
| 20–30 | 0 | 010 | 00 |
| 30–40 | 0 | 011 | 00 |
| 40–50 | 0 | 100 | 00 |
| 50–60 | 0 | 101 | 00 |
| 60–70 | 0 | 110 | 00 |
| 70–80 | 0 | 111 | 00 |
| 80–90 | 1 | 000 | 01 |
| 90–100 | 1 | 001 | 02 |
| 100–110 | 1 | 010 | 04 |
| 110–120 | 1 | 011 | 08 |
| 120–130 | 1 | 100 | 10 |
| 130–140 | 1 | 101 | 20 |
| 140–150 | 1 | 110 | 40 |
| 150–160 | 1 | 111 | 80 |

The output values are displayed in hexadecimal format in GTKWave.

For example:

`en = 0, in = 000 → out = 00 (00000000)`

`en = 1, in = 000 → out = 01 (00000001)`

`en = 1, in = 010 → out = 04 (00000100)`

`en = 1, in = 101 → out = 20 (00100000)`

`en = 1, in = 111 → out = 80 (10000000)`

The waveform confirms that the output remains LOW when the decoder is disabled and produces the correct one-hot output pattern when enabled.

No unknown (`X`) or high-impedance (`Z`) states were observed in the resulting waveform.

## Result

The 3:8 Decoder was successfully implemented and simulated using Verilog.

All 16 possible binary combinations of the enable and input signals were tested.

The GTKWave waveform confirms that the decoder produces the expected output for every input combination.

When the enable signal is LOW, all eight outputs remain LOW. When the enable signal is HIGH, exactly one output bit is activated according to the binary input.

The simulation demonstrates the correct operation of a combinational 3:8 decoder using Verilog case statements and an active-HIGH enable signal.
