# Simon Says 🎵🟥🟩🟨🟦

Simon Says is a memory game implemented entirely in low-level **STUMP assembly**, running on a custom STUMP processor and peripheral board.

The game displays a sequence of coloured quadrants (red, green, yellow, blue) accompanied by audio tones. The player must reproduce the sequence using the keypad. Each level increases the sequence length, testing memory, timing, and precision.

This project was developed as part of **COMP22111 – Microprocessor Systems** and demonstrates low-level embedded programming, memory-mapped I/O, and state-machine-driven game logic.

---

## 🎮 Demo

**Gameplay demo (click to watch):**

![Simon Says Gameplay](media/simon-says-demo.gif)

---

## 🧠 How the Game Works

### Game Flow

1. **Attract Mode**
   - Cycles through coloured quadrants until a key is pressed.
   - Displays *“SIMON SAYS – PRESS ANY KEY TO START”* on the LCD.

2. **Ready Signal**
   - Green corner flashes indicate the game is about to begin.
   - Level counter is initialised.

3. **Gameplay**
   - The game shows a sequence of coloured quadrants.
   - Each colour is paired with a distinct buzzer tone.
   - The player must reproduce the sequence using the keypad.

4. **Progression**
   - Each level adds an additional colour to the sequence.
   - Correct input advances the level.
   - Incorrect input triggers a game-over routine.

5. **Win / Lose States**
   - **Victory**: Green flashing lights, sound effects, and *“YOU WIN!!”* on the LCD.
   - **Game Over**: Red flashing lights, vibration motor, sound, and *“GAME OVER!!”*.

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

## 🛠 Implementation Highlights

- **Pure STUMP assembly** — no high-level languages used
- Memory-mapped I/O for:
  - LED matrix
  - LCD display
  - Keypad
  - Buzzer
  - Vibration motor
- Function jump tables for:
  - Colour display routines
  - Delay routines
  - Reset logic
- Modular routines for:
  - Input polling and debouncing
  - Audio feedback
  - Win / loss animations
- Clear state-machine structure for level progression

---

## 📁 Project Structure

Exercise3/
└── SimonSays.s # Main assembly source file

---

## 📚 Context

This project builds on the same STUMP hardware and toolchain as my  
[Pixel Puzzle](https://github.com/malhitaran/Pixel-Puzzle) project, further demonstrating low-level embedded game development and system-level programming.

---

## 🚀 Future Improvements

- Randomised sequence generation
- Higher difficulty levels
- Score persistence
- Improved timing accuracy

---

## 🧑‍💻 Author

**Aaron Malhi**  
