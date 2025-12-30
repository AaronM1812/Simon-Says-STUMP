# Simon Says 🎵🟥🟩🟨🟦

Simon Says is a memory game written entirely in low-level **STUMP** assembly, running on a custom STUMP processor and peripheral board.

The game presents an ever-growing sequence of coloured quadrants (red, green, yellow, blue), each paired with a unique audio tone. The player must accurately reproduce the sequence using the keypad. With every successful round, the sequence length increases, placing greater demands on memory, timing, and precision.

> This repository contains my **COMP22111 – Microprocessor Systems (Exercise 3)** submission and demonstrates low-level embedded programming, memory-mapped I/O, and state-machine-driven game logic.

---

## Demo

**Gameplay demo (click to watch):**

<a href="[https://youtube.com/shorts/YOUR_VIDEO_LINK](https://youtube.com/shorts/YOUR_VIDEO_LINK)">
  <img src="media/simon-says-demo.gif" width="260" alt="Simon Says gameplay GIF">
</a>

---

## How the Game Works

- The game operates as a **finite-state machine** implemented directly in STUMP assembly.
- **Visual feedback** is provided via the LED matrix and LCD.
- **User input** is captured from the keypad with explicit debouncing.
- **Audio and haptic feedback** reinforce correct and incorrect interactions.
- Game difficulty scales by increasing the sequence length each round.

---

## Controls

All interaction uses the keypad:

- `1` – Red quadrant
- `3` – Green quadrant
- `9` – Yellow quadrant
- `7` – Blue quadrant
- `Any key` – Start / input

---

## Project Structure

This repository follows the structure provided for the exercise:

- **`Exercise3/SimonSays.s`**
  Main STUMP assembly source file containing all game logic, state transitions, I/O handling, and animations.

---

## Main Game Logic

The core loop follows a numbered execution cycle documented in the internal comments and labels in `SimonSays.s`.

### Simon Says Execution Cycle

```mermaid
flowchart TB

  %% --- TOP ROW ---
  subgraph TOP[" "]
    direction LR
    S0["[0] RESET / INIT<br/>SYSTEM"] --> S1["[1] INIT<br/>DISPLAY"]
    S1 --> S2["[2] DISPLAYING<br/>SEQUENCE"]
    S2 --> S3["[3] ASSESSING<br/>USER INPUT"]
  end

  %% --- BOTTOM ROW ---
  subgraph BOTTOM[" "]
    direction RL
    S4["[4] INPUT<br/>FEEDBACK"] --> S5["[5] VERIFY"]
    S5 --> S6["[6] CHECK<br/>FOR WIN"]
    S6 --> F6["[6] OTHERWISE<br/>FAIL"]
  end

  %% --- FLOW ---
  S3 --> S4
  F6 --> S0

  style TOP fill:transparent,stroke:transparent
  style BOTTOM fill:transparent,stroke:transparent```

The game loop is split into numbered stages, matching the comments in ⁠ pixel_puzzel.s ⁠.

### Stage Overview

#### [0] RESET / INIT
•⁠  ⁠Clears the LED matrix to black.
•⁠  ⁠If ⁠ LEVEL_COUNTER > 1 ⁠, clears the user/level position tables before continuing.
•⁠  ⁠Sets up initial variables and jumps into the appropriate init display:
  - Level 1 → animated “PIXEL / PUZZLE” intro + “PRESS ANY KEY”.
  - Level > 1 → simple LCD showing the current level number.

