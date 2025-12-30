# Simon Says 🎵🟥🟩🟨🟦

Simon Says is a memory game written entirely in low-level *STUMP* assembly, running on a custom STUMP processor and peripheral board.

The game presents an ever-growing sequence of coloured quadrants (red, green, yellow, blue), each paired with a unique audio tone. The player must accurately reproduce the sequence using the keypad. With every successful round, the sequence length increases, placing greater demands on memory, timing, and precision.

This repository contains my *COMP22111 – Microprocessor Systems (Exercise 3)* submission and demonstrates low-level embedded programming, memory-mapped I/O, and state-machine-driven game logic.

---

## Demo

*Gameplay demo (click to watch):*

<a href="https://youtube.com/shorts/YOUR_VIDEO_LINK">
  <img src="media/simon-says-demo.gif" width="260" alt="Simon Says gameplay GIF">
</a>

---

## How the Game Works

- The game operates as a **finite-state machine** implemented directly in STUMP assembly.
- Visual feedback is provided via the LED matrix and LCD.
- User input is captured from the keypad with explicit **debouncing**.
- Audio and haptic feedback reinforce correct and incorrect interactions.
- Game difficulty scales by increasing the sequence length each round.

---

## Controls

All interaction uses the keypad:

- **1** – Red quadrant  
- **3** – Green quadrant  
- **9** – Yellow quadrant  
- **7** – Blue quadrant  
- **Any key** – Start / input  

---

## Project Structure

This repository follows the structure provided for the exercise:

- **Exercise3/SimonSays.s**  
  Main STUMP assembly source file containing all game logic, state transitions, I/O handling, and animations.

---

## Main Game Logic

The core loop follows a numbered execution cycle documented in the internal comments and labels in *SimonSays.s*.

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
  style BOTTOM fill:transparent,stroke:transparent
Stage Overview

---

## 🔍 Stage Overview

### [0] RESET / INIT SYSTEM
- Clears the LED matrix and resets all peripherals.
- Resets game variables including:
  - Level counter
  - Sequence index
  - Input tracking buffers
- Transfers control to attract mode.

### [1] INIT DISPLAY
- Displays **“SIMON SAYS – PRESS ANY KEY TO START”** on the LCD.
- Cycles coloured quadrants as an attract animation.
- Waits for a clean key press and release before starting.

### [2] DISPLAYING LEVEL
- Replays the current colour sequence:
  - Each colour lights a quadrant on the LED matrix.
  - A matching tone is played via the buzzer.
- The sequence is stored in memory and replayed deterministically.
- Control moves to user input after playback.

### [3] ASSESSING USER INPUT
- Polls the keypad with debouncing logic.
- Decodes key presses into colour selections.
- Each press:
  - Lights the corresponding quadrant
  - Plays the associated tone
- Inputs are checked incrementally against the stored sequence.

### [4] DRAW / FEEDBACK
- Provides immediate visual and audio feedback.
- Correct inputs advance the input index.
- Incorrect inputs immediately branch to failure handling.

### [5] VERIFY
- Checks whether the full sequence has been entered correctly.
- If correct:
  - Advances the level counter
  - Extends the sequence
  - Returns to **DISPLAYING LEVEL**

### [6] CHECK FOR WIN / FAIL
- **Win condition**:
  - Final level reached
  - Green flashing animation
  - Victory sound
  - LCD displays **“YOU WIN!!”**
- **Fail condition**:
  - Incorrect input detected
  - Red flashing animation
  - Buzzer and vibration motor feedback
  - LCD displays **“GAME OVER!!”**
- Game returns to attract mode after reset.

---

## 🛠 Implementation Highlights

- Pure **STUMP assembly** — no high-level language abstractions
- Extensive use of **memory-mapped I/O**:
  - LED matrix
  - LCD display
  - Keypad
  - Buzzer
  - Vibration motor
- Clearly structured **state-machine control flow**
- Table-driven routines for:
  - Colour → output mapping
  - Tone generation
  - Delay timing
- Modular subroutines for:
  - Input polling and debouncing
  - Sequence playback
  - Win / fail animations
- Clean separation between:
  - Game state
  - User input handling
  - Output rendering

---

## 🚀 Future Improvements

- Randomised sequence generation using a hardware counter
- Difficulty scaling via reduced playback timing
- Score or highest-level persistence
- Enhanced audio patterns
- Multi-round endurance mode

---

## 🧑‍💻 Author

**Aaron Malhi**  
Embedded Systems & Software Engineering Student
