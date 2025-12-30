;START OF THE PROGRAM
ORG 0000
    B RESET

MAIN_TABLE:
    function_table_pointer: DEFW FUNCTION_TABLE
    return: DEFW 0
    characters_table_pointer: DEFW CHARACTER_TABLE
    keypad_addr: DEFW 0xFF94
    key1_msk: DEFW 0x0002
    key3_msk: DEFW 0x0008
    key9_msk: DEFW 0x0200
    key7_msk: DEFW 0x0080


    a: DEFW 'A'
    bchar: DEFW 'B'
    c: DEFW 'C'
    d: DEFW 'D'
    e: DEFW 'E'
    f: DEFW 'F'
    g: DEFW 'G'
    h: DEFW 'H'
    i: DEFW 'I'
    j: DEFW 'J'
    k: DEFW 'K'
    l: DEFW 'L'
    m: DEFW 'M'
CHARACTER_TABLE:
    n: DEFW 'N'
    o: DEFW 'O'
    p: DEFW 'P'
    q: DEFW 'Q'
    r: DEFW 'R'
    s: DEFW 'S'
    t: DEFW 'T'
    u: DEFW 'U'
    v: DEFW 'V'
    w: DEFW 'W'
    x: DEFW 'X'
    y: DEFW 'Y'
    z: DEFW 'Z'
    schar: DEFW ' '
    exp: DEFW '!'
    

LEVEL_TABLE:
    one:    DEFW '1'
    two:    DEFW '2'
    three:  DEFW '3'
    four:   DEFW '4'
    five:   DEFW '5'



FUNCTION_TABLE:
    func_show_red: DEFW SHOW_RED
    func_show_green: DEFW SHOW_GREEN
    func_show_yellow: DEFW SHOW_YELLOW
    func_show_blue: DEFW SHOW_BLUE
    delay: DEFW DELAY
    reset: DEFW RESET


;actual addresses
FUNCTIONS EQU function_table_pointer
RETURN EQU return
CHARACTERS EQU characters_table_pointer
KEYPAD_ADDR EQU keypad_addr
KEY1_MSK EQU key1_msk
KEY3_MSK EQU key3_msk
KEY9_MSK EQU key9_msk
KEY7_MSK EQU key7_msk


;offsets
FUNC_SHOW_RED_OFFSET equ (func_show_red - FUNCTION_TABLE)
FUNC_SHOW_GREEN_OFFSET equ (func_show_green - FUNCTION_TABLE)
FUNC_SHOW_YELLOW_OFFSET equ (func_show_yellow - FUNCTION_TABLE)
FUNC_SHOW_BLUE_OFFSET equ (func_show_blue - FUNCTION_TABLE)
FUNC_DELAY_OFFSET equ (delay - FUNCTION_TABLE)
FUNC_RESET_OFFSET equ (reset - FUNCTION_TABLE)


CHAR_A_OFFSET equ (a - CHARACTER_TABLE)
CHAR_B_OFFSET equ (bchar - CHARACTER_TABLE)
CHAR_C_OFFSET equ (c - CHARACTER_TABLE)
CHAR_D_OFFSET equ (d - CHARACTER_TABLE)
CHAR_E_OFFSET equ (e - CHARACTER_TABLE)
CHAR_F_OFFSET equ (f - CHARACTER_TABLE)
CHAR_G_OFFSET equ (g - CHARACTER_TABLE)
CHAR_H_OFFSET equ (h - CHARACTER_TABLE)
CHAR_I_OFFSET equ (i - CHARACTER_TABLE)
CHAR_J_OFFSET equ (j - CHARACTER_TABLE)
CHAR_K_OFFSET equ (k - CHARACTER_TABLE)
CHAR_L_OFFSET equ (l - CHARACTER_TABLE)
CHAR_M_OFFSET equ (m - CHARACTER_TABLE)
CHAR_N_OFFSET equ (n - CHARACTER_TABLE)
CHAR_O_OFFSET equ (o - CHARACTER_TABLE)
CHAR_P_OFFSET equ (p - CHARACTER_TABLE)
CHAR_Q_OFFSET equ (q - CHARACTER_TABLE)
CHAR_R_OFFSET equ (r - CHARACTER_TABLE)
CHAR_S_OFFSET equ (s - CHARACTER_TABLE)
CHAR_T_OFFSET equ (t - CHARACTER_TABLE)
CHAR_U_OFFSET equ (u - CHARACTER_TABLE)
CHAR_V_OFFSET equ (v - CHARACTER_TABLE)
CHAR_W_OFFSET equ (w - CHARACTER_TABLE)
CHAR_X_OFFSET equ (x - CHARACTER_TABLE)
CHAR_Y_OFFSET equ (y - CHARACTER_TABLE)
CHAR_Z_OFFSET equ (z - CHARACTER_TABLE)
CHAR_SPACE_OFFSET equ (schar - CHARACTER_TABLE)
CHAR_EXP_OFFSET equ (exp - CHARACTER_TABLE)


;RESET THE GRID AND THE DISPLAY and vibrator
RESET:
    ; --- RESET GRID---
    B SKIP_RESET_DATA
D_ADDR: DEFW 0xFF00
D_CNT:  DEFW 64
D_BLK:  DEFW 0x00
SKIP_RESET_DATA:

    LD  R1, D_ADDR
    LD  R3, D_CNT
    LD  R2, D_BLK

RESET_LOOP:
    ST   R2, [R1]
    ADD  R1, R1, #1
    SUBS R3, R3, #1
    BNE  RESET_LOOP

    ; ---RESET DISPLAY EXT---;

    B   SKIP_LCD_DATA
LCD_BASE:   DEFW 0xFF40     ; start of LCD
LCD_OFF:    DEFW 0x00       ; value to write (blank)
LCD_COUNT:  DEFW 80         ; number of characters to clear
SKIP_LCD_DATA:

    LD  R1, LCD_BASE        ; R1 = base address
    LD  R2, LCD_OFF         ; R2 = blank value
    LD  R3, LCD_COUNT       ; R3 = counter

CLEAR_LCD_LOOP:
    ST R2, [R1]            ; write blank
    ADD R1, R1, #1          ; next LCD position
    SUBS R3, R3, #1
    BNE CLEAR_LCD_LOOP

    ; 5. TURN OFF VIBRATION
    B SKIP_OFF_VIB1
V_VIB_OFF:  DEFW 0

V_VIB_A2:   DEFW 0xFF96

SKIP_OFF_VIB1:
    ; Vib Off
    LD  R4, V_VIB_A2
    LD  R5, V_VIB_OFF
    ST  R5, [R4]


;Displaying simon says, Press any key, to start
    B   SKIP_LCD_BASE
LCD_BASE1:   DEFW 0xFF40
SKIP_LCD_BASE:
    LD  R1, LCD_BASE1
    LD R2, [R0,#CHARACTERS]

    ; 'S'
    LD R3, [R2,#CHAR_S_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'I'
    LD R3, [R2,#CHAR_I_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'M'
    LD R3, [R2,#CHAR_M_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'O'
    LD R3, [R2,#CHAR_O_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'N'
    LD R3, [R2,#CHAR_N_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; ' '
    LD R3, [R2,#CHAR_SPACE_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'S'
    LD R3, [R2,#CHAR_S_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'A'
    LD R3, [R2,#CHAR_A_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'Y'
    LD R3, [R2,#CHAR_Y_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'S'
    LD R3, [R2,#CHAR_S_OFFSET]
    ST R3, [R1]
    ADD R1, R1, #11


;PRESS ANY KEY
    ; 'P'
    LD R3, [R2,#CHAR_P_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'R'
    LD R3, [R2,#CHAR_R_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'E'
    LD R3, [R2,#CHAR_E_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'S'
    LD R3, [R2,#CHAR_S_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'S'
    LD R3, [R2,#CHAR_S_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1


    ; ' ' (space)
    LD R3, [R2,#CHAR_SPACE_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1


    ; 'A'
    LD R3, [R2,#CHAR_A_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'N'
    LD R3, [R2,#CHAR_N_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'Y'
    LD R3, [R2,#CHAR_Y_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1


    ; ' ' (space)
    LD R3, [R2,#CHAR_SPACE_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1


    ; 'K'
    LD R3, [R2,#CHAR_K_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'E'
    LD R3, [R2,#CHAR_E_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'Y'
    LD R3, [R2,#CHAR_Y_OFFSET]
    ST R3, [R1]
    ADD R1, R1, #8

;TO START
; 'T'
    LD R3, [R2,#CHAR_T_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

; 'O'
    LD R3, [R2,#CHAR_O_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

; ' ' (space)
    LD R3, [R2,#CHAR_SPACE_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

; 'S'
    LD R3, [R2,#CHAR_S_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

; 'T'
    LD R3, [R2,#CHAR_T_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

; 'A'
    LD R3, [R2,#CHAR_A_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

; 'R'
    LD R3, [R2,#CHAR_R_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

; 'T'
    LD R3, [R2,#CHAR_T_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1
    
    


; ==========================================================
; ATTRACT LOOP
; ==========================================================
ATTRACT_LOOP:

    ;function call to show red
    ADD R1, R7,#4;we add some extra to the pc to get ahead
    ST R1, [R0,#RETURN];storing return
    LD R1, [R0,#FUNCTIONS] ;we load the address of the function table
    LD R1, [R1,#FUNC_SHOW_RED_OFFSET];r1 now contains the address of the function
    ADD R7, R1,R0 ;we manually move our PC to the adress we calculated

    ;waiting for input
    LD  R3, [R0, #KEYPAD_ADDR]
    LD  R3, [R3]
    CMP R3, #0
    BNE READY_SIGNAL

    ;function call to show green
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_GREEN_OFFSET]
    ADD R7, R1,R0


    ;waiting for input
    LD  R3, [R0, #KEYPAD_ADDR]
    LD  R3, [R3]
    CMP R3, #0
    BNE READY_SIGNAL

    ;function call to show yellow
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_YELLOW_OFFSET]
    ADD R7, R1,R0

    ;waits for input
    LD  R3, [R0, #KEYPAD_ADDR]
    LD  R3, [R3]
    CMP R3, #0
    BNE READY_SIGNAL

    ;function call to show blue
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_BLUE_OFFSET]
    ADD R7, R1, R0
    
    ;waits for input
    LD  R3, [R0, #KEYPAD_ADDR]
    LD  R3, [R3]
    CMP R3, #0
    BEQ ATTRACT_LOOP

; ==========================================================
; READY SIGNAL
; ==========================================================
READY_SIGNAL:

; ---RESET DISPLAY, removing press anu key and to start---;

    B   SKIP_LCD_DATA1
LCD_20:     DEFW 0xFF54
LCD_OFF1:   DEFW 0x00       ; value to write (blank)
LCD_COUNT1: DEFW 40         ; number of characters to clear
SKIP_LCD_DATA1:

    LD  R1, LCD_20          ; R1 = base address
    LD  R2, LCD_OFF1        ; R2 = blank value
    LD  R3, LCD_COUNT1      ; R3 = counter

CLEAR_LCD_LOOP1:
    ST R2, [R1]             ; write blank
    ADD R1, R1, #1          ; next LCD position
    SUBS R3, R3, #1
    BNE CLEAR_LCD_LOOP1

;Displaying Level
    B   SKIP_LCD_BASE1
LCD_BASE3:   DEFW 0xFF54
SKIP_LCD_BASE1:
    LD  R1, LCD_BASE3
    LD R2, [R0,#CHARACTERS]

    ; 'L'
    LD R3, [R2,#CHAR_L_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'E'
    LD R3, [R2,#CHAR_E_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'V'
    LD R3, [R2,#CHAR_V_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'E'
    LD R3, [R2,#CHAR_E_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'L'
    LD R3, [R2,#CHAR_L_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1



;COUNTER FOR THE READY GREEN LIGHTS
    B SKIP_LC1
D_LP1:   DEFW 2
SKIP_LC1:
    LD  R6, D_LP1

READY_SIGNAL_LOOP:

    ;function call to delay
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0

    
    ; --- LOAD GREEN COLOR ---
    B SKIP_RDY_COL
V_GRN_R:    DEFW 0x1C
SKIP_RDY_COL:
    LD  R2, V_GRN_R

    ; --- TOP LEFT ---
    B SKIP_TL_R
V_TL_R:     DEFW 0xFF00
SKIP_TL_R:
    LD  R1, V_TL_R
    ST  R2, [R1]

    ; --- TOP RIGHT ---
    B SKIP_TR_R
V_TR_R:     DEFW 0xFF07
SKIP_TR_R:
    LD  R1, V_TR_R
    ST  R2, [R1]

    ; --- BOTTOM LEFT ---
    B SKIP_BL_R
V_BL_R:     DEFW 0xFF38
SKIP_BL_R:
    LD  R1, V_BL_R
    ST  R2, [R1]

    ; --- BOTTOM RIGHT ---
    B SKIP_BR_R
V_BR_R:     DEFW 0xFF3F
SKIP_BR_R:
    LD  R1, V_BR_R
    ST  R2, [R1]

    ;function call to delay
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0

    ; --- TURN OFF ALL ---
    B SKIP_OFF_R
V_OFF_R: DEFW 0x00
SKIP_OFF_R:
    LD  R2, V_OFF_R

    ; Turn off TL
    B SKIP_OFF_TL
V_TL_OFF: DEFW 0xFF00
SKIP_OFF_TL:
    LD  R1, V_TL_OFF
    ST  R2, [R1]

    ; Turn off TR
    B SKIP_OFF_TR
V_TR_OFF: DEFW 0xFF07
SKIP_OFF_TR:
    LD  R1, V_TR_OFF
    ST  R2, [R1]

    ; Turn off BL
    B SKIP_OFF_BL
V_BL_OFF: DEFW 0xFF38
SKIP_OFF_BL:
    LD  R1, V_BL_OFF
    ST  R2, [R1]

    ; Turn off BR
    B SKIP_OFF_BR
V_BR_OFF: DEFW 0xFF3F
SKIP_OFF_BR:
    LD  R1, V_BR_OFF
    ST  R2, [R1]

    SUBS R6, R6, #1
    BEQ  START_GAME
    B    READY_SIGNAL_LOOP

; ==========================================================
; GAME INITIALISATION
; ==========================================================

; ==========================================================
; LEVEL 1 RED
; ==========================================================
START_GAME:

    ;showing level 1
    B SKIP_LEVEL_DISPLAY_DATA
LEVEL_DISPLAY_ADDR: DEFW 0xFF5A
LEVEL_1:    DEFW '1'
SKIP_LEVEL_DISPLAY_DATA:
    LD R1, LEVEL_DISPLAY_ADDR
    LD R2, LEVEL_1
    
    ST R2, [R1]


    ;function call to show red
    ADD R1, R7,#4;we add some extra to the pc to get ahead
    ST R1, [R0,#RETURN];storing return
    LD R1, [R0,#FUNCTIONS] ;we load the address of the function table
    LD R1, [R1,#FUNC_SHOW_RED_OFFSET];r1 now contains the address of the function
    ADD R7, R1,R0 ;we manually move our PC to the adress we calculated


    ;wait for input
WAIT_FOR_INPUT:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD  R3, [R3]
    CMP R3, #0
    BEQ WAIT_FOR_INPUT  ; Wait until key pressed

    ;check input red
    LD  R2, [R0, #KEY1_MSK]
    ANDS R5, R3, R2
    BEQ GAME_OVER_TRAMP     ; Check if Key 1 is pressed

        
    ; Wait Release
WAIT_REL_11:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD  R3, [R3]
    CMP R3, #0
    BNE WAIT_REL_11
    
    B SKIP_GAME_OVER_TRAMP

GAME_OVER_TRAMP:
    ; If Wrong -> Game Over
    B   GAME_OVER_TRAMP1

SKIP_GAME_OVER_TRAMP:


; ==========================================================
; LEVEL 2 (BLUE -> GREEN)
; ==========================================================
LEVEL_2_START:
    
    ;function call to delay
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0

    ;showing level 2
    B SKIP_LEVEL_DISPLAY_DATA1
LEVEL_DISPLAY_ADDR1: DEFW 0xFF5A
LEVEL_2:    DEFW '2'
BLACK:  DEFW 0
SKIP_LEVEL_DISPLAY_DATA1:
    LD R1, LEVEL_DISPLAY_ADDR1
    LD R2, BLACK
    ST R2, [R1]
    LD R2, LEVEL_2
    ST R2, [R1]

    ;function call to show blue
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_BLUE_OFFSET]
    ADD R7, R1, R0

    ;function call to show green
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_GREEN_OFFSET]
    ADD R7, R1,R0

    ;waiting for input 1
WAIT_FOR_INPUT21:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD  R3, [R3]
    CMP R3, #0
    BEQ WAIT_FOR_INPUT21

    ; Check blue key
    LD  R2, [R0, #KEY7_MSK]
    ANDS R5, R3, R2
    BEQ GAME_OVER_TRAMP1 ; Wrong key? Lose!

    ; Wait Release
WAIT_REL_21:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD  R3, [R3]
    CMP R3, #0
    BNE WAIT_REL_21

    ;function call to delay
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0


    ;waiting for input 2
WAIT_FOR_INPUT22:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BEQ WAIT_FOR_INPUT22

    ; Check green key
    LD  R2, [R0, #KEY3_MSK]
    ANDS R5, R3, R2
    BEQ GAME_OVER_TRAMP1 ; Wrong key? Lose!

    ; Wait Release
WAIT_REL_22:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD  R3, [R3]
    CMP R3, #0
    BNE WAIT_REL_22

    B SKIP_GAME_OVER_TRAMP1

GAME_OVER_TRAMP1:
    B GAME_OVER_TRAMP2

SKIP_GAME_OVER_TRAMP1:


; ==========================================================
; LEVEL 3 (YELLOW -> GREEN -> RED)
; ==========================================================
LEVEL_3_START:
    
    ;function call to delay
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0


    ;showing level 3
    B SKIP_LEVEL_DISPLAY_DATA2
LEVEL_DISPLAY_ADDR2: DEFW 0xFF5A
LEVEL_3:    DEFW '3'
BLACK1:  DEFW 0
SKIP_LEVEL_DISPLAY_DATA2:
    LD R1, LEVEL_DISPLAY_ADDR2
    LD R2, BLACK1
    ST R2, [R1]
    LD R2, LEVEL_3
    ST R2, [R1]


    ;function call to show yellow
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_YELLOW_OFFSET]
    ADD R7, R1, R0

    ;function call to show green
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_GREEN_OFFSET]
    ADD R7, R1,R0

    ;function call to show red
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_RED_OFFSET]
    ADD R7, R1,R0

    ;wait for input 1
WAIT_FOR_INPUT31:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BEQ WAIT_FOR_INPUT31

    ; Check yellow
    LD  R2, [R0, #KEY9_MSK]
    ANDS R5, R3, R2
    BEQ GAME_OVER_TRAMP2

    ; Wait Release
WAIT_REL_31:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD  R3, [R3]
    CMP R3, #0
    BNE WAIT_REL_31

    ;function call to delay
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0

    ;wait for input 2
WAIT_FOR_INPUT32:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BEQ WAIT_FOR_INPUT32

    ; Check green key
    LD  R2, [R0, #KEY3_MSK]
    ANDS R5, R3, R2
    BEQ GAME_OVER_TRAMP2

    ; Wait Release
WAIT_REL_32:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD  R3, [R3]
    CMP R3, #0
    BNE WAIT_REL_32

    ;function call to delay
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0

    ;wait for input 3
WAIT_FOR_INPUT33:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BEQ WAIT_FOR_INPUT33

    ; Check red key
    LD  R2, [R0, #KEY1_MSK]
    ANDS R5, R3, R2
    BEQ GAME_OVER_TRAMP2

    ; Wait Release
WAIT_REL_33:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD  R3, [R3]
    CMP R3, #0
    BNE WAIT_REL_33

    B SKIP_GAME_OVER_TRAMP2

GAME_OVER_TRAMP2:
    B GAME_OVER_TRAMP3

SKIP_GAME_OVER_TRAMP2:

; ==========================================================
; LEVEL 4 (YELLOW -> YELLOW -> BLUE -> GREEN)
; ==========================================================
LEVEL_4_START:
    
    ;function call to delay
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1, R0


    ;showing level 4
    B SKIP_LEVEL_DISPLAY_DATA3
LEVEL_DISPLAY_ADDR3: DEFW 0xFF5A
LEVEL_4:    DEFW '4'
BLACK2:  DEFW 0
SKIP_LEVEL_DISPLAY_DATA3:
    LD R1, LEVEL_DISPLAY_ADDR3
    LD R2, BLACK2
    ST R2, [R1]
    LD R2, LEVEL_4
    ST R2, [R1]

    ;function call to show yellow
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_YELLOW_OFFSET]
    ADD R7, R1, R0

    ;function call to show red
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_RED_OFFSET]
    ADD R7, R1, R0

    ;function call to show blue
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_BLUE_OFFSET]
    ADD R7, R1, R0

    ;function call to show green
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_GREEN_OFFSET]
    ADD R7, R1, R0

    ;wait for input 1
WAIT_FOR_INPUT41:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BEQ WAIT_FOR_INPUT41

    ; Check yellow
    LD  R2, [R0, #KEY9_MSK]
    ANDS R5, R3, R2
    BEQ GAME_OVER_TRAMP3

    ; Wait Release
WAIT_REL_41:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD  R3, [R3]
    CMP R3, #0
    BNE WAIT_REL_41

    ;function call to delay
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0


    ;wait for input 2
WAIT_FOR_INPUT42:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BEQ WAIT_FOR_INPUT42

    ; Check yellow
    LD  R2, [R0, #KEY1_MSK]
    ANDS R5, R3, R2
    BEQ GAME_OVER_TRAMP3

    ; Wait Release
WAIT_REL_42:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BNE WAIT_REL_42

    ;function call to delay
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0

    ;wait for input 3
WAIT_FOR_INPUT43:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BEQ WAIT_FOR_INPUT43

    ; Check blue key
    LD  R2, [R0, #KEY7_MSK]
    ANDS R5, R3, R2
    BEQ GAME_OVER_TRAMP3

    ; Wait Release
WAIT_REL_43:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BNE WAIT_REL_43

    ;function call to delay
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0


    ;wait for input 4
WAIT_FOR_INPUT44:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BEQ WAIT_FOR_INPUT44

    ; Check green key
    LD  R2, [R0, #KEY3_MSK]
    ANDS R5, R3, R2
    BEQ GAME_OVER_TRAMP3

    ; Wait Release
WAIT_REL_44:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BNE WAIT_REL_44

    B SKIP_GAME_OVER_TRAMP3

GAME_OVER_TRAMP3:
    B GAME_OVER_TRAMP4

SKIP_GAME_OVER_TRAMP3:


; ==========================================================
; LEVEL 5 (RED -> BLUE -> RED -> GREEN -> YELLOW)
; ==========================================================
LEVEL_5_START:
    
    ;function call to delay
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1, R0

    ;showing level 5
    B SKIP_LEVEL_DISPLAY_DATA4
LEVEL_DISPLAY_ADDR4: DEFW 0xFF5A
LEVEL_5:     DEFW '5'
BLACK3:      DEFW 0
SKIP_LEVEL_DISPLAY_DATA4:
    LD R1, LEVEL_DISPLAY_ADDR4
    LD R2, BLACK3
    ST R2, [R1]
    LD R2, LEVEL_5
    ST R2, [R1]

    ;function call to show red
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_RED_OFFSET]
    ADD R7, R1, R0

    ;function call to show blue
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_BLUE_OFFSET]
    ADD R7, R1, R0

    ;function call to show red
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_RED_OFFSET]
    ADD R7, R1, R0

    ;function call to show green
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_GREEN_OFFSET]
    ADD R7, R1, R0

    ;function call to show yellow
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_SHOW_YELLOW_OFFSET]
    ADD R7, R1, R0

    ;wait for input 1
WAIT_FOR_INPUT51:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BEQ WAIT_FOR_INPUT51

    ; Check red
    LD  R2, [R0, #KEY1_MSK]
    ANDS R5, R3, R2
    BEQ GAME_OVER_TRAMP4

    ; Wait Release
WAIT_REL_51:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BNE WAIT_REL_51

    ;function call to delay
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1, R0


    ;wait for input 2
WAIT_FOR_INPUT52:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BEQ WAIT_FOR_INPUT52

    ; Check blue
    LD  R2, [R0, #KEY7_MSK]
    ANDS R5, R3, R2
    BEQ GAME_OVER_TRAMP4

    ; Wait release
WAIT_REL_52:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BNE WAIT_REL_52

    ;function call to delay
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0


    ;wait for input 3
WAIT_FOR_INPUT53:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BEQ WAIT_FOR_INPUT53

    ; Check red
    LD  R2, [R0, #KEY1_MSK]
    ANDS R5, R3, R2
    BEQ GAME_OVER_TRAMP4

    ; Wait Release
WAIT_REL_53:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BNE WAIT_REL_53

    ;function call to delay
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0


    ;wait for input 4
WAIT_FOR_INPUT54:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BEQ WAIT_FOR_INPUT54

    ; Check green key
    LD  R2, [R0, #KEY3_MSK]
    ANDS R5, R3, R2
    BEQ GAME_OVER_TRAMP4

    ; Wait Release
WAIT_REL_54:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BNE WAIT_REL_54

    ;function call to delay
    ADD R1, R7,#4
    ST R1, [R0,#RETURN]
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0


    ;wait for input 5
WAIT_FOR_INPUT55:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BEQ WAIT_FOR_INPUT55

    ; Check yellow key
    LD  R2, [R0, #KEY9_MSK]
    ANDS R5, R3, R2
    BEQ GAME_OVER_TRAMP4

    ; Wait release
WAIT_REL_55:
    LD  R3, [R0, #KEYPAD_ADDR]
    LD R3, [R3]
    CMP R3, #0
    BNE WAIT_REL_55


    B SKIP_GAME_OVER_TRAMP4

GAME_OVER_TRAMP4:
    B GAME_OVER_TRAMP5

SKIP_GAME_OVER_TRAMP4:



; ==========================================================
; VICTORY ROUTINE
; ==========================================================
VICTORY_ROUTINE:

    ; COUNTER FOR GREEN FLASHES (3 times)
    B   SKIP_LC_V
D_LP_V:    DEFW 3
SKIP_LC_V:
    LD  R6, D_LP_V

    ; --- RESET GRID ---
    B   SKIP_RESET_DATAV
D_ADDRV:   DEFW 0xFF00
D_CNTV:    DEFW 64
D_BLKV:    DEFW 0x00
SKIP_RESET_DATAV:

    LD  R1, D_ADDRV
    LD  R3, D_CNTV
    LD  R2, D_BLKV

RESET_LOOP_V:
    ST   R2, [R1]
    ADD  R1, R1, #1
    SUBS R3, R3, #1
    BNE  RESET_LOOP_V

    ; --- RESET DISPLAY EXT ---
    B   SKIP_LCD_DATAV
LCD_BASEV:   DEFW 0xFF40     ; start of LCD
LCD_OFFV:    DEFW 0x00       ; value to write (blank)
LCD_COUNTV:  DEFW 80         ; number of characters to clear
SKIP_LCD_DATAV:

    LD  R1, LCD_BASEV        ; R1 = base address
    LD  R2, LCD_OFFV         ; R2 = blank value
    LD  R3, LCD_COUNTV       ; R3 = counter

CLEAR_LCD_LOOP_V:
    ST  R2, [R1]             ; write blank
    ADD R1, R1, #1           ; next LCD position
    SUBS R3, R3, #1
    BNE CLEAR_LCD_LOOP_V

    ; --- POINTER TO LCD START (FF40) ---
    B   SKIP_LCD_GO_V
V_LCD_GO_V:   DEFW 0xFF40
SKIP_LCD_GO_V:
    LD  R1, V_LCD_GO_V
    LD  R2, [R0,#CHARACTERS]   ; character table pointer

    ; "YOU WIN!!"

    ; 'Y'
    LD  R3, [R2,#CHAR_Y_OFFSET]
    ST  R3, [R1]
    ADD R1, R1,#1

    ; 'O'
    LD  R3, [R2,#CHAR_O_OFFSET]
    ST  R3, [R1]
    ADD R1, R1,#1

    ; 'U'
    LD  R3, [R2,#CHAR_U_OFFSET]
    ST  R3, [R1]
    ADD R1, R1,#1

    ; ' ' (space)
    LD  R3, [R2,#CHAR_SPACE_OFFSET]
    ST  R3, [R1]
    ADD R1, R1,#1

    ; 'W'
    LD  R3, [R2,#CHAR_W_OFFSET]
    ST  R3, [R1]
    ADD R1, R1,#1

    ; 'I'
    LD  R3, [R2,#CHAR_I_OFFSET]
    ST  R3, [R1]
    ADD R1, R1,#1

    ; 'N'
    LD  R3, [R2,#CHAR_N_OFFSET]
    ST  R3, [R1]
    ADD R1, R1,#1

    ; '!'
    LD  R3, [R2,#CHAR_EXP_OFFSET]
    ST  R3, [R1]
    ADD R1, R1,#1

    ; '!'
    LD  R3, [R2,#CHAR_EXP_OFFSET]
    ST  R3, [R1]
    ADD R1, R1,#1

    B SKIP_GAME_OVER_TRAMP5

GAME_OVER_TRAMP5:
    B GAME_OVER_TRAMP6

SKIP_GAME_OVER_TRAMP5:


    ; 1. VIBRATION MOTOR ON
    B SKIP_VIB_ON_V
V_VIB_ADDR_V: DEFW 0xFF96
V_VIB_VAL_V:  DEFW 1
SKIP_VIB_ON_V:
    LD  R4, V_VIB_ADDR_V
    LD  R5, V_VIB_VAL_V
    ST  R5, [R4]

GRN_FLASH_LOOP:

    ; 2. SOUND ON (HIGHER TONE)
    B SKIP_SND_V
V_BZ_V:     DEFW 0xFF92
V_NTC_HI:   DEFW 0x8540    ; Octave 5 Note C (higher than 0x8340)
SKIP_SND_V:
    LD  R4, V_BZ_V
    LD  R5, V_NTC_HI
    ST  R5, [R4]

    ; 3. ALL LIGHTS GREEN
    B SKIP_GRN_ALL_V
V_GRN_V:    DEFW 0x1C
V_TL_V:     DEFW 0xFF00
V_TR_V:     DEFW 0xFF07
V_BL_V:     DEFW 0xFF38
V_BR_V:     DEFW 0xFF3F
SKIP_GRN_ALL_V:
    LD  R2, V_GRN_V

    LD  R1, V_TL_V
    ST  R2, [R1]
    LD  R1, V_TR_V
    ST  R2, [R1]
    LD  R1, V_BL_V
    ST  R2, [R1]
    LD  R1, V_BR_V
    ST  R2, [R1]


     ; 3b. TURN ON SW LEDs A, C, D, E, G
    B   SKIP_SWLED_PAT_F1
SWLED_ADDR1:    DEFW 0xFF97
SWLED_PAT_F1:    DEFW 0x005D
SKIP_SWLED_PAT_F1:
    LD  R1, SWLED_ADDR1
    LD  R2, SWLED_PAT_F1
    ST  R2, [R1]

    ; 4. DELAY (using delay function)
    ADD R1, R7,#4
    ST  R1, [R0,#RETURN]
    LD  R1, [R0,#FUNCTIONS]
    LD  R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0


    ; 5. TURN OFF SOUND
    B SKIP_OFF_SND_V
V_SIL_V:    DEFW 0x0000
V_BZ_A2_V:  DEFW 0xFF92
SKIP_OFF_SND_V:
    LD  R4, V_BZ_A2_V
    LD  R5, V_SIL_V
    ST  R5, [R4]

    ; 6. TURN OFF ALL LIGHTS (BLACK)
    B SKIP_GRN_ALL_OFF_V
V_BLACK_V:    DEFW 0x00
V_TL_V1:      DEFW 0xFF00
V_TR_V1:      DEFW 0xFF07
V_BL_V1:      DEFW 0xFF38
V_BR_V1:      DEFW 0xFF3F
SWLED_ADDR2:  DEFW 0xFF97
SWLED_OFF1:   DEFW 0x0000
SKIP_GRN_ALL_OFF_V:
    LD  R2, V_BLACK_V

    LD  R1, V_TL_V1
    ST  R2, [R1]
    LD  R1, V_TR_V1
    ST  R2, [R1]
    LD  R1, V_BL_V1
    ST  R2, [R1]
    LD  R1, V_BR_V1
    ST  R2, [R1]


     ; 6b. TURN OFF SW LEDs
    LD  R1, SWLED_ADDR2
    LD  R2, SWLED_OFF1

    ST  R2, [R1]

    ; another delay between flashes
    ADD R1, R7,#4
    ST  R1, [R0,#RETURN]
    LD  R1, [R0,#FUNCTIONS]
    LD  R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0

    ; loop 3 times
    SUBS R6, R6, #1
    BEQ  RESTART_GAME
    B    GRN_FLASH_LOOP


RESTART_GAME:
    ;function call to go restart game
    LD R1, [R0,#FUNCTIONS] ;we load the address of the function table
    LD R1, [R1,#FUNC_RESET_OFFSET];r1 now contains the address of the function
    ADD R7, R1,R0 ;we manually move our PC to the adress we calculated


    B SKIP_GAME_OVER_TRAMP6

GAME_OVER_TRAMP6:
    B GAME_OVER_TRAMP7

SKIP_GAME_OVER_TRAMP6:


; ==========================================================
; GAME OVER ROUTINE (RED LIGHTS + VIBRATION + SOUND)
; ==========================================================
GAME_OVER_ROUTINE:

    ;COUNTER FOR GAME OVER FLASHES
    B   SKIP_LC2
D_LP2:   DEFW 3
SKIP_LC2:
    LD  R6, D_LP2

    ; --- RESET GRID---
    B   SKIP_RESET_DATA4
D_ADDR4: DEFW 0xFF00
D_CNT4:  DEFW 64
D_BLK4:  DEFW 0x00
SKIP_RESET_DATA4:

    LD  R1, D_ADDR4
    LD  R3, D_CNT4
    LD  R2, D_BLK4

RESET_LOOP4:
    ST   R2, [R1]
    ADD  R1, R1, #1
    SUBS R3, R3, #1
    BNE  RESET_LOOP4

    ; ---RESET DISPLAY EXT---
    B   SKIP_LCD_DATA2
LCD_BASE2:   DEFW 0xFF40     ; start of LCD
LCD_OFF2:    DEFW 0x00       ; value to write (blank)
LCD_COUNT2:  DEFW 80         ; number of characters to clear
SKIP_LCD_DATA2:

    LD  R1, LCD_BASE2        ; R1 = base address
    LD  R2, LCD_OFF2         ; R2 = blank value
    LD  R3, LCD_COUNT2       ; R3 = counter

CLEAR_LCD_LOOP2:
    ST R2, [R1]              ; write blank
    ADD R1, R1, #1           ; next LCD position
    SUBS R3, R3, #1
    BNE CLEAR_LCD_LOOP2

    ; --- POINTER TO LCD START (FF40) ---
    B   SKIP_LCD_GO
V_LCD_GO:   DEFW 0xFF40
SKIP_LCD_GO:
    LD  R1, V_LCD_GO
    LD  R2, [R0,#CHARACTERS]

    ; "GAME OVER!!"

    ; 'G'
    LD R3, [R2,#CHAR_G_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'A'
    LD R3, [R2,#CHAR_A_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'M'
    LD R3, [R2,#CHAR_M_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'E'
    LD R3, [R2,#CHAR_E_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; ' ' (SPACE)
    LD R3, [R2,#CHAR_SPACE_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'O'
    LD R3, [R2,#CHAR_O_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'V'
    LD R3, [R2,#CHAR_V_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'E'
    LD R3, [R2,#CHAR_E_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; 'R'
    LD R3, [R2,#CHAR_R_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; '!'
    LD R3, [R2,#CHAR_EXP_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1

    ; '!'
    LD R3, [R2,#CHAR_EXP_OFFSET]
    ST R3, [R1]
    ADD R1, R1,#1



    B SKIP_GAME_OVER_TRAMP7

GAME_OVER_TRAMP7:
    B GAME_OVER_ROUTINE

SKIP_GAME_OVER_TRAMP7:


    ; 1. VIBRATION MOTOR ON
    B   SKIP_VIB_ON
V_VIB_ADDR: DEFW 0xFF96
V_VIB_VAL:  DEFW 1
SKIP_VIB_ON:
    LD  R4, V_VIB_ADDR
    LD  R5, V_VIB_VAL
    ST  R5, [R4]

RED_FLASH_LOOP: 

    ; 2. SOUND ON (LOW TONE)
    B   SKIP_SND_F
V_BZ_F:     DEFW 0xFF92
V_NTC_LO:   DEFW 0x8340 ; Octave 3 Note C
SKIP_SND_F:
    LD  R4, V_BZ_F
    LD  R5, V_NTC_LO
    ST  R5, [R4]

    ; 3. ALL LIGHTS RED (grid)
    B   SKIP_RED_ALL
V_RED_F:    DEFW 0xE0
V_TL_F:     DEFW 0xFF00
V_TR_F:     DEFW 0xFF07
V_BL_F:     DEFW 0xFF38
V_BR_F:     DEFW 0xFF3F
SKIP_RED_ALL:
    LD  R2, V_RED_F
    
    LD  R1, V_TL_F
    ST  R2, [R1]
    LD  R1, V_TR_F
    ST  R2, [R1]
    LD  R1, V_BL_F
    ST  R2, [R1]
    LD  R1, V_BR_F
    ST  R2, [R1]

    ; 3b. TURN ON SW LEDs A, C, D, E, G
    B   SKIP_SWLED_PAT_F
SWLED_ADDR: DEFW 0xFF97
SWLED_PAT_F:  DEFW 0x005D
SKIP_SWLED_PAT_F:
    LD  R1, SWLED_ADDR
    LD  R2, SWLED_PAT_F
    ST  R2, [R1]

    ; 4. DELAY 1 (Longer Buzz) via delay function
    ADD R1, R7,#4
    ST  R1, [R0,#RETURN]
    LD  R1, [R0,#FUNCTIONS]
    LD  R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0

    ; 5. TURN OFF SOUND
    B   SKIP_OFF_VIB
V_SIL_F:    DEFW 0x0000
V_BZ_A2:    DEFW 0xFF92
SKIP_OFF_VIB:
    LD  R4, V_BZ_A2
    LD  R5, V_SIL_F
    ST  R5, [R4]

    ; 6. TURN OFF GRID LIGHTS
    B   SKIP_RED_ALL_OFF
V_BLACK_F:    DEFW 0x00
V_TL_F1:     DEFW 0xFF00
V_TR_F1:     DEFW 0xFF07
V_BL_F1:     DEFW 0xFF38
V_BR_F1:     DEFW 0xFF3F
SWLED_ADDR3: DEFW 0xFF97
SWLED_OFF:    DEFW 0x0000
SKIP_RED_ALL_OFF:
    LD  R2, V_BLACK_F
    
    LD  R1, V_TL_F1
    ST  R2, [R1]
    LD  R1, V_TR_F1
    ST  R2, [R1]
    LD  R1, V_BL_F1
    ST  R2, [R1]
    LD  R1, V_BR_F1
    ST  R2, [R1]

    ; 6b. TURN OFF SW LEDs
    LD  R1, SWLED_ADDR3
    LD  R2, SWLED_OFF

    ST  R2, [R1]

    ; another delay
    ADD R1, R7,#4
    ST  R1, [R0,#RETURN]
    LD  R1, [R0,#FUNCTIONS]
    LD  R1, [R1,#FUNC_DELAY_OFFSET]
    ADD R7, R1,R0

    SUBS R6, R6, #1
    BEQ  RESTART_GAME1
    B    RED_FLASH_LOOP


RESTART_GAME1:

    ;function call to go restart game
    LD R1, [R0,#FUNCTIONS]
    LD R1, [R1,#FUNC_RESET_OFFSET]
    ADD R7, R1,R0



; ==========================================================
; FUNCTIONS
; ==========================================================
SHOW_RED:

    ; --- load base address into R1 ---
    B   SKIP_TL_ADDR
D_TL_ADDR:      DEFW 0xFF00         ; TL quadrant base
SKIP_TL_ADDR:
    LD  R1, D_TL_ADDR               ; R1 = current row base

    ; --- load colour into R2 ---
    B   SKIP_TL_COL
D_TL_COL:       DEFW 0xE0           ; red
SKIP_TL_COL:
    LD  R2, D_TL_COL                ; R2 = colour

    ; --- row counter (4 rows) into R3 ---
    B   SKIP_RED_ROWS
RED_ROWS:       DEFW 4
SKIP_RED_ROWS:
    LD  R3, RED_ROWS                ; R3 = rows remaining

    ; --- stride between rows (bytes) into R5 ---
    B   SKIP_RED_STRIDE
RED_STRIDE:     DEFW 8              ; adjust if your map differs
SKIP_RED_STRIDE:
    LD  R5, RED_STRIDE              ; R5 = stride

; ========== OUTER LOOP: rows ==========
RED_ROW_LOOP:
    ; R4 = column pointer for this row (copy of row base R1)
    ADD R4, R1, #0

    ; column counter (4 cols) into R6
    B   SKIP_RED_COLS
RED_COLS:       DEFW 4
SKIP_RED_COLS:
    LD  R6, RED_COLS                ; R6 = cols remaining

; ---------- INNER LOOP: columns ----------
RED_COL_LOOP:
    ST  R2, [R4]                    ; write colour
    ADD R4, R4, #1                  ; next column
    SUBS R6, R6, #1
    BNE RED_COL_LOOP

    ; finished this row: move base to next row
    ADD R1, R1, R5                  ; R1 += STRIDE

    SUBS R3, R3, #1                 ; one row done
    BNE RED_ROW_LOOP

    ; done TL quadrant ON
    ; (fall through to delay / buzzer / etc)


    ; >>>> BUZZER (NOTE C) <<<<
    ; Mode=1(Prog), Dur=4, Oct=4, Note=0 -> 0x8440
    LD  R4, D_BZ_ADDR
    B   S_BZ1
D_BZ_ADDR:  DEFW 0xFF92
S_BZ1:

    LD  R5, D_NOTE_C
    B   S_BZ2
D_NOTE_C:   DEFW 0x8440
S_BZ2:

    ST  R5, [R4]        ; Play Note C

    ; >>>> DELAY <<<<
    LD  R5, D_DLY_1
    B   S_DL1
D_DLY_1:    DEFW 0xFF
S_DL1:
DELAY_1:
    LD  R4, D_DLY_IN1
    B   S_DL1B
D_DLY_IN1:  DEFW 0xFF
S_DL1B:
INNER_1:
    SUBS R4, R4, #1
    BNE  INNER_1
    SUBS R5, R5, #1
    BNE  DELAY_1

    ; >>>> TURN OFF WHOLE TL QUADRANT <<<<

    ; base address again
    B   SKIP_TL_ADDR_OFF
D_TL_ADDR_OFF:  DEFW 0xFF00
SKIP_TL_ADDR_OFF:
    LD  R1, D_TL_ADDR_OFF          ; R1 = row base

    ; colour = 0x00 (off)
    B   SKIP_TL_OFF_COL
D_TL_OFF_COL:   DEFW 0x00
SKIP_TL_OFF_COL:
    LD  R2, D_TL_OFF_COL           ; R2 = off colour

    ; rows = 4
    B   SKIP_RED_ROWS_OFF
RED_ROWS_OFF:   DEFW 4
SKIP_RED_ROWS_OFF:
    LD  R3, RED_ROWS_OFF

    ; stride = 8
    B   SKIP_RED_STRIDE_OFF
RED_STRIDE_OFF: DEFW 8
SKIP_RED_STRIDE_OFF:
    LD  R5, RED_STRIDE_OFF

RED_ROW_LOOP_OFF:
    ; R4 = column pointer for this row
    ADD R4, R1, #0

    ; cols = 4
    B   SKIP_RED_COLS_OFF
RED_COLS_OFF:   DEFW 4
SKIP_RED_COLS_OFF:
    LD  R6, RED_COLS_OFF

RED_COL_LOOP_OFF:
    ST  R2, [R4]                   ; write 0x00
    ADD R4, R4, #1
    SUBS R6, R6, #1
    BNE RED_COL_LOOP_OFF

    ADD R1, R1, R5                 ; next row
    SUBS R3, R3, #1
    BNE RED_ROW_LOOP_OFF

    LD R7, [R0,#RETURN]



SHOW_GREEN:

    ; >>>> TURN ON WHOLE TR QUADRANT <<<<

    ; base address into R1 (TR quadrant base)
    B   SKIP_TRQ_ADDR
D_TRQ_ADDR:     DEFW 0xFF04         ; TR quadrant base
SKIP_TRQ_ADDR:
    LD  R1, D_TRQ_ADDR

    ; colour = green
    B   SKIP_TRQ_COL
D_TRQ_COL:      DEFW 0x1C           ; green
SKIP_TRQ_COL:
    LD  R2, D_TRQ_COL

    ; rows = 4
    B   SKIP_TR_ROWS
TR_ROWS:        DEFW 4
SKIP_TR_ROWS:
    LD  R3, TR_ROWS

    ; stride = 8
    B   SKIP_TR_STRIDE
TR_STRIDE:      DEFW 8
SKIP_TR_STRIDE:
    LD  R5, TR_STRIDE

TR_ROW_LOOP:
    ADD R4, R1, #0

    B   SKIP_TR_COLS
TR_COLS:        DEFW 4
SKIP_TR_COLS:
    LD  R6, TR_COLS

TR_COL_LOOP:
    ST  R2, [R4]
    ADD R4, R4, #1
    SUBS R6, R6, #1
    BNE TR_COL_LOOP

    ADD R1, R1, R5
    SUBS R3, R3, #1
    BNE TR_ROW_LOOP

    ; >>>> BUZZER (NOTE E) <<<<
    ; Mode=1, Dur=4, Oct=4, Note=4 -> 0x8444
    LD  R4, D_BZ_ADDR2
    B   S_BZA2
D_BZ_ADDR2: DEFW 0xFF92
S_BZA2:
    LD  R5, D_NOTE_E
    B   S_BZB2
D_NOTE_E:   DEFW 0x8444
S_BZB2:
    ST  R5, [R4]

    ; >>>> DELAY <<<<
    LD  R5, D_DLY_2
    B   S_DL2
D_DLY_2:    DEFW 0xFF
S_DL2:
DELAY_2:
    LD  R4, D_DLY_IN2
    B   S_DL2B
D_DLY_IN2:  DEFW 0xFF
S_DL2B:
INNER_2:
    SUBS R4, R4, #1
    BNE  INNER_2
    SUBS R5, R5, #1
    BNE  DELAY_2

    ; >>>> TURN OFF WHOLE TR QUADRANT <<<<
    B   SKIP_TRQ_ADDR_OFF
D_TRQ_ADDR_OFF: DEFW 0xFF04
SKIP_TRQ_ADDR_OFF:
    LD  R1, D_TRQ_ADDR_OFF

    B   SKIP_TRQ_OFF_COL
D_TRQ_OFF_COL:  DEFW 0x00
SKIP_TRQ_OFF_COL:
    LD  R2, D_TRQ_OFF_COL

    B   SKIP_TR_ROWS_OFF
TR_ROWS_OFF:    DEFW 4
SKIP_TR_ROWS_OFF:
    LD  R3, TR_ROWS_OFF

    B   SKIP_TR_STRIDE_OFF
TR_STRIDE_OFF:  DEFW 8
SKIP_TR_STRIDE_OFF:
    LD  R5, TR_STRIDE_OFF

TR_ROW_LOOP_OFF:
    ADD R4, R1, #0

    B   SKIP_TR_COLS_OFF
TR_COLS_OFF:    DEFW 4
SKIP_TR_COLS_OFF:
    LD  R6, TR_COLS_OFF

TR_COL_LOOP_OFF:
    ST  R2, [R4]
    ADD R4, R4, #1
    SUBS R6, R6, #1
    BNE TR_COL_LOOP_OFF

    ADD R1, R1, R5
    SUBS R3, R3, #1
    BNE TR_ROW_LOOP_OFF

    LD R7, [R0,#RETURN]




SHOW_YELLOW:
    ; >>>> TURN ON WHOLE BR QUADRANT <<<<

    B   SKIP_BRQ_ADDR
D_BRQ_ADDR:     DEFW 0xFF24         ; BR quadrant base
SKIP_BRQ_ADDR:
    LD  R1, D_BRQ_ADDR

    B   SKIP_BRQ_COL
D_BRQ_COL:      DEFW 0xFC           ; yellow
SKIP_BRQ_COL:
    LD  R2, D_BRQ_COL

    B   SKIP_BR_ROWS
BR_ROWS:        DEFW 4
SKIP_BR_ROWS:
    LD  R3, BR_ROWS

    B   SKIP_BR_STRIDE
BR_STRIDE:      DEFW 8
SKIP_BR_STRIDE:
    LD  R5, BR_STRIDE

BR_ROW_LOOP:
    ADD R4, R1, #0

    B   SKIP_BR_COLS
BR_COLS:        DEFW 4
SKIP_BR_COLS:
    LD  R6, BR_COLS

BR_COL_LOOP:
    ST  R2, [R4]
    ADD R4, R4, #1
    SUBS R6, R6, #1
    BNE BR_COL_LOOP

    ADD R1, R1, R5
    SUBS R3, R3, #1
    BNE BR_ROW_LOOP

    ; >>>> BUZZER (NOTE G) <<<<
    ; Mode=1, Dur=4, Oct=4, Note=7 -> 0x8447
    LD  R4, D_BZ_ADDR3
    B   S_BZA3
D_BZ_ADDR3: DEFW 0xFF92
S_BZA3:
    LD  R5, D_NOTE_G
    B   S_BZB3
D_NOTE_G:   DEFW 0x8447
S_BZB3:
    ST  R5, [R4]

    ; >>>> DELAY <<<<
    LD  R5, D_DLY_3
    B   S_DL3
D_DLY_3:    DEFW 0xFF
S_DL3:
DELAY_3:
    LD  R4, D_DLY_IN3
    B   S_DL3B
D_DLY_IN3:  DEFW 0xFF
S_DL3B:
INNER_3:
    SUBS R4, R4, #1
    BNE  INNER_3
    SUBS R5, R5, #1
    BNE  DELAY_3

    ; >>>> TURN OFF WHOLE BR QUADRANT <<<<
    B   SKIP_BRQ_ADDR_OFF
D_BRQ_ADDR_OFF: DEFW 0xFF24
SKIP_BRQ_ADDR_OFF:
    LD  R1, D_BRQ_ADDR_OFF

    B   SKIP_BRQ_OFF_COL
D_BRQ_OFF_COL:  DEFW 0x00
SKIP_BRQ_OFF_COL:
    LD  R2, D_BRQ_OFF_COL

    B   SKIP_BR_ROWS_OFF
BR_ROWS_OFF:    DEFW 4
SKIP_BR_ROWS_OFF:
    LD  R3, BR_ROWS_OFF

    B   SKIP_BR_STRIDE_OFF
BR_STRIDE_OFF:  DEFW 8
SKIP_BR_STRIDE_OFF:
    LD  R5, BR_STRIDE_OFF

BR_ROW_LOOP_OFF:
    ADD R4, R1, #0

    B   SKIP_BR_COLS_OFF
BR_COLS_OFF:    DEFW 4
SKIP_BR_COLS_OFF:
    LD  R6, BR_COLS_OFF

BR_COL_LOOP_OFF:
    ST  R2, [R4]
    ADD R4, R4, #1
    SUBS R6, R6, #1
    BNE BR_COL_LOOP_OFF

    ADD R1, R1, R5
    SUBS R3, R3, #1
    BNE BR_ROW_LOOP_OFF

    LD R7, [R0,#RETURN]



SHOW_BLUE:
    ; >>>> TURN ON WHOLE BL QUADRANT <<<<

    B   SKIP_BLQ_ADDR
D_BLQ_ADDR:     DEFW 0xFF20         ; BL quadrant base
SKIP_BLQ_ADDR:
    LD  R1, D_BLQ_ADDR

    B   SKIP_BLQ_COL
D_BLQ_COL:      DEFW 0x03           ; blue
SKIP_BLQ_COL:
    LD  R2, D_BLQ_COL

    B   SKIP_BL_ROWS
BL_ROWS:        DEFW 4
SKIP_BL_ROWS:
    LD  R3, BL_ROWS

    B   SKIP_BL_STRIDE
BL_STRIDE:      DEFW 8
SKIP_BL_STRIDE:
    LD  R5, BL_STRIDE

BL_ROW_LOOP:
    ADD R4, R1, #0

    B   SKIP_BL_COLS
BL_COLS:        DEFW 4
SKIP_BL_COLS:
    LD  R6, BL_COLS

BL_COL_LOOP:
    ST  R2, [R4]
    ADD R4, R4, #1
    SUBS R6, R6, #1
    BNE BL_COL_LOOP

    ADD R1, R1, R5
    SUBS R3, R3, #1
    BNE BL_ROW_LOOP

    ; >>>> BUZZER (NOTE C High) <<<<
    ; Mode=1, Dur=4, Oct=5, Note=0 -> 0x8450
    LD  R4, D_BZ_ADDR4
    B   S_BZA4
D_BZ_ADDR4: DEFW 0xFF92
S_BZA4:
    LD  R5, D_NOTE_CH
    B   S_BZB4
D_NOTE_CH:  DEFW 0x8450
S_BZB4:
    ST  R5, [R4]

    ; >>>> DELAY <<<<
    LD  R5, D_DLY_4
    B   S_DL4
D_DLY_4:    DEFW 0xFF
S_DL4:
DELAY_4:
    LD  R4, D_DLY_IN4
    B   S_DL4B
D_DLY_IN4:  DEFW 0xFF
S_DL4B:
INNER_4:
    SUBS R4, R4, #1
    BNE  INNER_4
    SUBS R5, R5, #1
    BNE  DELAY_4

    ; >>>> TURN OFF WHOLE BL QUADRANT <<<<
    B   SKIP_BLQ_ADDR_OFF
D_BLQ_ADDR_OFF: DEFW 0xFF20
SKIP_BLQ_ADDR_OFF:
    LD  R1, D_BLQ_ADDR_OFF

    B   SKIP_BLQ_OFF_COL
D_BLQ_OFF_COL:  DEFW 0x00
SKIP_BLQ_OFF_COL:
    LD  R2, D_BLQ_OFF_COL

    B   SKIP_BL_ROWS_OFF
BL_ROWS_OFF:    DEFW 4
SKIP_BL_ROWS_OFF:
    LD  R3, BL_ROWS_OFF

    B   SKIP_BL_STRIDE_OFF
BL_STRIDE_OFF:  DEFW 8
SKIP_BL_STRIDE_OFF:
    LD  R5, BL_STRIDE_OFF

BL_ROW_LOOP_OFF:
    ADD R4, R1, #0

    B   SKIP_BL_COLS_OFF
BL_COLS_OFF:    DEFW 4
SKIP_BL_COLS_OFF:
    LD  R6, BL_COLS_OFF

BL_COL_LOOP_OFF:
    ST  R2, [R4]
    ADD R4, R4, #1
    SUBS R6, R6, #1
    BNE BL_COL_LOOP_OFF

    ADD R1, R1, R5
    SUBS R3, R3, #1
    BNE BL_ROW_LOOP_OFF

    LD R7, [R0,#RETURN]


DELAY:
    ; --- DELAY ---
    B SKIP_D
V_DEL_L: DEFW 0xFF
SKIP_D:
    LD  R5, V_DEL_L
DELAY_5_OUT:
    B SKIP_D5_IN
V_DEL_IN: DEFW 0xFF
SKIP_D5_IN:
    LD  R3, V_DEL_IN
DELAY_5_IN:
    SUBS R3, R3, #1
    BNE  DELAY_5_IN
    SUBS R5, R5, #1
    BNE  DELAY_5_OUT

    LD R7, [R0,#RETURN]

