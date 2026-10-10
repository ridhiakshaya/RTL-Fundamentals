# Seven-Segment Decoder in Verilog

## Overview

This project implements and simulates a 4-bit hexadecimal to seven-segment display decoder using Verilog.

A seven-segment decoder converts a 4-bit binary input into a 7-bit output pattern that controls the individual segments of a seven-segment display. The decoder supports hexadecimal inputs from 0 to F.

The project demonstrates basic combinational logic design, Verilog case statements, testbench development, simulation, and waveform analysis.

The design was simulated using Icarus Verilog, with GTKWave used to analyze the resulting signal waveforms.

## Design

The Seven-Segment Decoder consists of:

- **bin[3:0]** - 4-bit binary input
- **seg[6:0]** - 7-bit output controlling the display segments

The seven output bits correspond to the following segments:

`seg[6:0] = {a, b, c, d, e, f, g}`

The decoder is designed for a common-cathode seven-segment display, where:

- `1` - Segment ON
- `0` - Segment OFF

Each 4-bit input corresponds to a predefined segment pattern that displays the appropriate hexadecimal character.

### Truth Table

| Binary Input | Hexadecimal Character | Segment Output (abcdefg) |
|---|---|---|
| 0000 | 0 | 1111110 |
| 0001 | 1 | 0110000 |
| 0010 | 2 | 1101101 |
| 0011 | 3 | 1111001 |
| 0100 | 4 | 0110011 |
| 0101 | 5 | 1011011 |
| 0110 | 6 | 1011111 |
| 0111 | 7 | 1110000 |
| 1000 | 8 | 1111111 |
| 1001 | 9 | 1111011 |
| 1010 | A | 1110111 |
| 1011 | b | 0011111 |
| 1100 | C | 1001110 |
| 1101 | d | 0111101 |
| 1110 | E | 1001111 |
| 1111 | F | 1000111 |

The characters B and D are represented as lowercase b and d because of the limitations of a seven-segment display.

## Verilog Implementation

The decoder is implemented using a Verilog `case` statement inside an `always @(*)` block.

Each possible 4-bit input is mapped to its corresponding seven-segment output pattern.

For example:

```verilog
4'h0: seg = 7'b1111110; // 0
4'h1: seg = 7'b0110000; // 1
4'h2: seg = 7'b1101101; // 2
4'h3: seg = 7'b1111001; // 3
```

When `bin = 4'b0000`, all segments except g are activated, displaying the digit 0.

When `bin = 4'b0001`, only segments b and c are activated, displaying the digit 1.

The `always @(*)` block ensures that the output is updated whenever the input changes.

Since the output depends only on the current binary input, the decoder is a combinational logic circuit.

## Simulation Environment

| Tool | Purpose |
|---|---|
| Verilog | Hardware Description Language |
| Icarus Verilog | Compilation and simulation |
| GTKWave | Simulation waveform visualization |
| VS Code | Source code development environment |

## Testbench Verification

The testbench verifies the seven-segment decoder by applying all 16 possible combinations of the 4-bit input.

A `for` loop is used to increment the input from hexadecimal 0 to F.

Each input combination is applied for 10 ns.

The testbench generates a VCD file containing the input and output signals for waveform analysis.

The simulation covers:

- Decimal digits 0 to 9
- Hexadecimal characters A to F
- All 16 possible input combinations

### Test Sequence

The input sequence is:

`0 → 1 → 2 → 3 → 4 → 5 → 6 → 7 → 8 → 9 → A → B → C → D → E → F`

The corresponding seven-segment output changes according to the predefined truth table.

The complete simulation duration is 160 ns.

## GTKWave Simulation

The generated VCD file was loaded into GTKWave to observe the behavior of the decoder over the complete 160 ns simulation.

The waveform includes:

- **bin[3:0]** - Binary input
- **seg[6:0]** - Seven-segment output

Each 10 ns interval represents one hexadecimal input.

### Simulation Results

| Simulation Time | Input (Hex) | Segment Output (Hex) |
|---|---|---|
| 0–10 ns | 0 | 7E |
| 10–20 ns | 1 | 30 |
| 20–30 ns | 2 | 6D |
| 30–40 ns | 3 | 79 |
| 40–50 ns | 4 | 33 |
| 50–60 ns | 5 | 5B |
| 60–70 ns | 6 | 5F |
| 70–80 ns | 7 | 70 |
| 80–90 ns | 8 | 7F |
| 90–100 ns | 9 | 7B |
| 100–110 ns | A | 77 |
| 110–120 ns | B | 1F |
| 120–130 ns | C | 4E |
| 130–140 ns | D | 3D |
| 140–150 ns | E | 4F |
| 150–160 ns | F | 47 |

The output values are displayed in hexadecimal format in GTKWave.

For example:

`bin = 0 → seg = 7E (1111110)`

`bin = 2 → seg = 6D (1101101)`

`bin = 8 → seg = 7F (1111111)`

The waveform confirms that the output changes correctly for every input combination.

No unknown (`X`) or high-impedance (`Z`) states were observed in the resulting waveform.

## Result

The Seven-Segment Decoder was successfully implemented and simulated using Verilog.

All 16 possible input combinations were tested, covering hexadecimal values from 0 to F.

The GTKWave waveform confirms that each binary input produces the expected seven-segment output pattern according to the decoder truth table.

The simulation demonstrates the correct operation of the combinational decoder using Verilog case statements.
