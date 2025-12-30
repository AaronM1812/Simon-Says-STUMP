# Simon Says 🎵🟥🟩🟨🟦

Simon Says is a memory game written entirely in low-level **STUMP assembly**, running on a custom STUMP processor and peripheral board.

The game presents an ever-growing sequence of coloured quadrants (red, green, yellow, blue), each paired with a unique audio tone. The player must accurately reproduce the sequence using the keypad. With every successful round, the sequence length increases, placing greater demands on memory, timing, and precision.

This repository contains my **COMP22111 – Microprocessor Systems (Exercise 3)** submission and demonstrates low-level embedded programming, memory-mapped I/O, and state-machine-driven game logic.

---

## 🎮 Demo

**Gameplay demo (click to watch):**

![Simon Says Gameplay](media/simon-says-demo.gif)

> 📌 Place your gameplay GIF at `media/simon-says-demo.gif`.  
> You can generate this from a screen recording using tools like **ffmpeg**, **ScreenToGif**, or **Kap**.

---

## 🧠 How the Game Works

### High-Level Overview

- The game is implemented as a **finite-state machine** directly in STUMP assembly.
- Visual feedback is provided via the **LED matrix** and **LCD display**.
- User input is captured from the **keypad**, including software debouncing.
- **Audio tones** and a **vibration motor** reinforce correct and incorrect actions.
- Game difficulty increases by extending the colour sequence each round.

---

## 🎛 Controls

| Action | Key |
|------|-----|
| Red quadrant | Key 1 |
| Green quadrant | Key 3 |
| Yellow quadrant | Key 9 |
| Blue quadrant | Key 7 |
| Start / input | Any key |

---

## 📁 Project Structure

Exercise3/
└── SimonSays.s # Main STUMP assembly source file

markdown
Copy code

All game logic—including state transitions, input handling, output control, and animations—is implemented within a single assembly source file, following the structure provided for the exercise.

---

## 🔁 Main Game Logic

The core game loop follows a numbered execution cycle, matching labels and comments within `SimonSays.s`.

### Simon Says Execution Cycle

![Simon Says Execution Cycle](media/simon-says-execution-cycle.png)

> 📌 Create this diagram using **draw.io**, **diagrams.net**, **PowerPoint**, or similar tools,  
> then export it as `media/simon-says-execution-cycle.png`.

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
