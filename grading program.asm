CODE        SEGMENT
        ASSUME  CS:CODE, DS:CODE                 

        ORG     0
START:
    MOV AX, CS                   ; Initialize data segment
    MOV DS, AX
    JMP MAIN
    ; Constants and variables
    N           DW  $               ; Number of students
    PROMPT1     DB  'Enter number of students: $'
    PROMPT2     DB  13, 10, 'Enter student numbers:$'
    PROMPT3     DB  13, 10, 'Enter student grades:$'
    RESULT_MSG  DB  13, 10, 'Students sorted by grades (descending):$'
    ID_MSG      DB  13, 10, 'Student Number: $'
    GRADE_MSG   DB  ', Grade: $'
    NEWLINE     DB  13, 10, '$'
    IR_WR       EQU 0FFC1H
    IR_RD       EQU 0FFC3H
    DR_WR       EQU 0FFC5H
    DATA79      EQU 0FFE8H
    CNTR79      EQU 0FFEAH
    
    ; Arrays to store student information
    STUDENT_NUMS DW  100 DUP(?)      ; Array for student numbers (max 100)
    GRADES      DW  100 DUP(?)      ; Array for grades (max 100)

MAIN PROC
    
    ; Display prompt for number of students
    LEA DX, PROMPT1
    MOV AH, 9
    INT 21H
    
    ; Display the same prompt on LCD
    MOV AH, 1    
    CALL IRWR
    MOV AH, 80H
    CALL IRWR
    MOV AH, 'E'
    CALL OUTL
    MOV AH, 'n'
    CALL OUTL
    MOV AH, 't'
    CALL OUTL
    MOV AH, 'e'
    CALL OUTL
    MOV AH, 'r'
    CALL OUTL    
    MOV AH, ' '
    CALL OUTL
    MOV AH, 'N'
    CALL OUTL
    MOV AH, 'O'
    CALL OUTL 
    MOV AH, '.'
    CALL OUTL
    MOV AH, 'O'
    CALL OUTL
    MOV AH, 'f'
    CALL OUTL
    MOV AH, 0C0H          ; Move to second line of LCD
    CALL IRWR        
    MOV AH, 'S'
    CALL OUTL
    MOV AH, 't'
    CALL OUTL    
    MOV AH, 'u'
    CALL OUTL
    MOV AH, 'd'
    CALL OUTL
    MOV AH, 'e'
    CALL OUTL        
    MOV AH, 'n'
    CALL OUTL
    MOV AH, 't'
    CALL OUTL
    MOV AH, 's'
    CALL OUTL
    MOV AH, ':'
    CALL OUTL    
    
    ; Read number of students
    CALL READ_NUMBER
    MOV N, AX                       ; Store number of students
    
    ; Display prompt for student numbers
    LEA DX, PROMPT2
    MOV AH, 9
    INT 21H
    
    ; Display the same prompt on LCD
    MOV AH, 1    
    CALL IRWR
    MOV AH, 80H          ; Clear display and move to first line
    CALL IRWR
    MOV AH, 'E'
    CALL OUTL
    MOV AH, 'n'
    CALL OUTL
    MOV AH, 't'
    CALL OUTL
    MOV AH, 'e'
    CALL OUTL
    MOV AH, 'r'
    CALL OUTL    
    MOV AH, ' '
    CALL OUTL
    MOV AH, 'S'
    CALL OUTL
    MOV AH, 't'
    CALL OUTL    
    MOV AH, 'u'
    CALL OUTL
    MOV AH, 'd'
    CALL OUTL
    MOV AH, 'e'
    CALL OUTL        
    MOV AH, 'n'
    CALL OUTL
    MOV AH, 't'
    CALL OUTL
    MOV AH, 0C0H          ; Move to second line of LCD
    CALL IRWR
    MOV AH, 'N'
    CALL OUTL
    MOV AH, 'u'
    CALL OUTL        
    MOV AH, 'm'
    CALL OUTL
    MOV AH, 'b'
    CALL OUTL
    MOV AH, 'e'
    CALL OUTL
    MOV AH, 'r'
    CALL OUTL
    MOV AH, 's'
    CALL OUTL
    MOV AH, ':'
    CALL OUTL    
    
    ; Read student numbers
    MOV CX, N                       ; Counter for loop
    LEA SI, STUDENT_NUMS            ; Point to STUDENT_NUMS array

ID_INPUT_LOOP:
    LEA DX, NEWLINE                 ; New line
    MOV AH, 9
    INT 21H
    
    ; Clear LCD for next input
    MOV AH, 1
    CALL IRWR
    MOV AH, 80H          ; Clear display and move to first line
    CALL IRWR
    MOV AH, 'S'
    CALL OUTL
    MOV AH, 't'
    CALL OUTL
    MOV AH, 'u'
    CALL OUTL
    MOV AH, 'd'
    CALL OUTL
    MOV AH, 'e'
    CALL OUTL
    MOV AH, 'n'
    CALL OUTL
    MOV AH, 't'
    CALL OUTL
    MOV AH, ' '
    CALL OUTL
    MOV AH, '#'
    CALL OUTL
    MOV AH, ':'
    CALL OUTL
    
    CALL READ_NUMBER                ; Read a student number
    MOV [SI], AX                    ; Store in array
    ADD SI, 2                       ; Move to next element (2 bytes for word)
    LOOP ID_INPUT_LOOP
    
    ; Display prompt for grades
    LEA DX, PROMPT3
    MOV AH, 9
    INT 21H
    
    ; Display the same prompt on LCD
    MOV AH, 1    
    CALL IRWR
    MOV AH, 80H          ; Clear display and move to first line
    CALL IRWR
    MOV AH, 'E'
    CALL OUTL
    MOV AH, 'n'
    CALL OUTL
    MOV AH, 't'
    CALL OUTL
    MOV AH, 'e'
    CALL OUTL
    MOV AH, 'r'
    CALL OUTL    
    MOV AH, ' '
    CALL OUTL
    MOV AH, 'S'
    CALL OUTL
    MOV AH, 't'
    CALL OUTL    
    MOV AH, 'u'
    CALL OUTL
    MOV AH, 'd'
    CALL OUTL
    MOV AH, 'e'
    CALL OUTL        
    MOV AH, 'n'
    CALL OUTL
    MOV AH, 't'
    CALL OUTL    
    MOV AH, 0C0H          ; Move to second line of LCD
    CALL IRWR
    MOV AH, 'G'
    CALL OUTL
    MOV AH, 'r'
    CALL OUTL        
    MOV AH, 'a'
    CALL OUTL
    MOV AH, 'd'
    CALL OUTL
    MOV AH, 'e'
    CALL OUTL
    MOV AH, 's'
    CALL OUTL
    MOV AH, ':'
    CALL OUTL        
    
    ; Read grades
    MOV CX, N                       ; Counter for loop
    LEA SI, GRADES                  ; Point to GRADES array

GRADE_INPUT_LOOP:
    LEA DX, NEWLINE                 ; New line
    MOV AH, 9
    INT 21H
    
    ; Clear LCD for next input
    MOV AH, 1
    CALL IRWR
    MOV AH, 80H          ; Clear display and move to first line
    CALL IRWR
    MOV AH, 'G'
    CALL OUTL
    MOV AH, 'r'
    CALL OUTL
    MOV AH, 'a'
    CALL OUTL
    MOV AH, 'd'
    CALL OUTL
    MOV AH, 'e'
    CALL OUTL
    MOV AH, ' '
    CALL OUTL
    MOV AH, '#'
    CALL OUTL
    MOV AH, ':'
    CALL OUTL
    
    CALL READ_NUMBER                ; Read a grade
    MOV [SI], AX                    ; Store in array
    ADD SI, 2                       ; Move to next element
    LOOP GRADE_INPUT_LOOP
    
    ; Sort students by grades (bubble sort)
    CALL SORT_BY_GRADES
    
    ; Display results
    LEA DX, RESULT_MSG
    MOV AH, 9
    INT 21H
    
    ; Print sorted student information
    MOV CX, N                       ; Counter for loop
    LEA SI, STUDENT_NUMS            ; Point to sorted student numbers
    LEA DI, GRADES                  ; Point to sorted grades

PRINT_RESULTS_LOOP:
    ; Print student number to PC
    LEA DX, ID_MSG
    MOV AH, 9
    INT 21H
    
    MOV AX, [SI]                    ; Get student number
    CALL PRINT_NUMBER               ; Print on PC
    
    ; Print grade to PC
    LEA DX, GRADE_MSG
    MOV AH, 9
    INT 21H
    
    MOV AX, [DI]                    ; Get grade
    CALL PRINT_NUMBER               ; Print on PC
    
    ; Also display this student's info on LCD
    MOV AH, 1
    CALL IRWR
    MOV AH, 80H          ; Clear display and move to first line
    CALL IRWR
    MOV AH, 'S'
    CALL OUTL
    MOV AH, 't'
    CALL OUTL
    MOV AH, 'u'
    CALL OUTL
    MOV AH, 'd'
    CALL OUTL
    MOV AH, '#'
    CALL OUTL
    MOV AH, ':'
    CALL OUTL
    MOV AH, ' '
    CALL OUTL
    
    ; Print student number on LCD
    MOV AX, [SI]
    CALL PRINT_LCD_NUMBER
    
    ; Move to second line
    MOV AH, 0C0H
    CALL IRWR
    MOV AH, 'G'
    CALL OUTL
    MOV AH, 'r'
    CALL OUTL
    MOV AH, 'a'
    CALL OUTL
    MOV AH, 'd'
    CALL OUTL
    MOV AH, 'e'
    CALL OUTL
    MOV AH, ':'
    CALL OUTL
    MOV AH, ' '
    CALL OUTL
    
    ; Print grade on LCD
    MOV AX, [DI]
    CALL PRINT_LCD_NUMBER
    
    ADD SI, 2                       ; Move to next student number
    ADD DI, 2                       ; Move to next grade
    
    ; If we have more students to display, wait for 'F' key before continuing
    DEC CX                          ; Decrement counter
    JZ EXIT1                        ; If zero, exit
    
    ; Wait for keypress (specifically 'F') before showing next result
WAIT_F_KEY:
    CALL KEYPAD
    CMP AL, 3FH                     ; Check if 'F' was pressed (3FH is the value for 'F')
    JNE WAIT_F_KEY                  ; If not 'F', keep waiting
    
    JMP PRINT_RESULTS_LOOP          ; Continue with next student
    
    ; Exit program
EXIT1:  MOV AX, 4C00H
        INT 21H
MAIN ENDP

; Procedure to print a number on LCD
PRINT_LCD_NUMBER PROC
    MOV BX, 10                      ; Divisor
    XOR CX, CX                      ; Initialize digit counter

    TEST AX, AX                     ; Check if number is zero
    JNZ LCD_DIVIDE_LOOP             ; If not zero, proceed to division

    MOV AH, '0'                     ; If zero, print '0'
    CALL OUTL
    JMP LCD_PRINT_DONE              ; Done printing

LCD_DIVIDE_LOOP:
    XOR DX, DX                      ; Clear DX for division
    DIV BX                          ; Divide AX by 10, remainder in DX
    PUSH DX                         ; Save remainder (digit)
    INC CX                          ; Increment digit counter
    TEST AX, AX                     ; Check if quotient is zero
    JNZ LCD_DIVIDE_LOOP             ; If not zero, continue division

LCD_PRINT_DIGITS:
    CMP CX, 0                       ; Check if all digits printed
    JZ LCD_PRINT_DONE               ; If yes, done printing
    POP DX                          ; Get digit
    ADD DL, '0'                     ; Convert to ASCII
    MOV AH, DL                      ; Move digit to AH for LCD output
    CALL OUTL                       ; Print the digit on LCD
    DEC CX                          ; Decrement digit counter
    JMP LCD_PRINT_DIGITS            ; Continue printing digits

LCD_PRINT_DONE:
    RET
PRINT_LCD_NUMBER ENDP

; Procedure to sort students by grades in descending order (bubble sort)
SORT_BY_GRADES PROC
    MOV CX, N
    DEC CX                          ; (N-1) passes
OUTER_LOOP:
    PUSH CX
    
    LEA SI, GRADES
    LEA DI, STUDENT_NUMS
    MOV BX, CX                      ; Inner loop counter

INNER_LOOP:
    MOV AX, [SI]                    ; Load current grade
    MOV DX, [SI+2]                  ; Load next grade
    CMP AX, DX                      ; Compare grades
    JGE CONTINUE                    ; Skip swap if already in descending order
    
    ; Swap grades
    MOV [SI], DX                    ; Store higher grade at current position
    MOV [SI+2], AX                  ; Store lower grade at next position
    
    ; Swap corresponding student numbers
    MOV AX, [DI]                    ; Load current student number
    MOV DX, [DI+2]                  ; Load next student number
    MOV [DI], DX                    ; Store student number with higher grade
    MOV [DI+2], AX                  ; Store student number with lower grade

CONTINUE:
    ADD SI, 2                       ; Move to next grade
    ADD DI, 2                       ; Move to next student number
    DEC BX                          ; Decrement inner loop counter
    JNZ INNER_LOOP                  ; If not zero, continue inner loop
    
    POP CX                          ; Restore outer loop counter
    LOOP OUTER_LOOP                 ; Continue outer loop
    RET
SORT_BY_GRADES ENDP
; Procedure to read a number from keyboard
READ_NUMBER PROC
    XOR BX, BX                      ; Initialize result to 0
READ_DIGIT:
    CALL KEYPAD                     ; Read a digit
    CMP AL, 3FH                     ; Check if input is complete (F key)
    JE READ_DONE                    ; If yes, finish reading
    PUSH AX                         ; Save the digit
    MOV AH, AL                      ; Move digit to AH for display
    CALL OUTL                       ; Display the digit on LCD
    POP AX                          ; Restore the digit
    SUB AL, '0'                     ; Convert ASCII to numeric value
    XOR AH, AH                      ; Clear high byte
    PUSH AX                         ; Save numeric value
    MOV AX, 10                      ; Multiply current result by 10
    MUL BX
    MOV BX, AX                      ; Store back in BX
    POP AX                          ; Restore digit value
    ADD BX, AX                      ; Add digit to result
    JMP READ_DIGIT                  ; Read next digit
READ_DONE:
    MOV AX, BX                      ; Move result to AX for return
    RET
READ_NUMBER ENDP

; Procedure to print a number
PRINT_NUMBER PROC
    MOV BX, 10                      ; Divisor
    XOR CX, CX                      ; Initialize digit counter

    TEST AX, AX                     ; Check if number is zero
    JNZ DIVIDE_LOOP                 ; If not zero, proceed to division

    JMP EXIT                    ; If zero, print '0'
    MOV AH, 2
    INT 21H
    JMP PRINT_DONE                  ; Done printing

DIVIDE_LOOP:
    XOR DX, DX                      ; Clear DX for division
    DIV BX                          ; Divide AX by 10, remainder in DX
    PUSH DX                         ; Save remainder (digit)
    INC CX                          ; Increment digit counter
    TEST AX, AX                     ; Check if quotient is zero
    JNZ DIVIDE_LOOP                 ; If not zero, continue division

PRINT_DIGITS:
    CMP CX, 0                       ; Check if all digits printed
    JZ PRINT_DONE                   ; If yes, done printing
    POP DX                          ; Get digit
    ADD DL, '0'                     ; Convert to ASCII
    MOV AH, 2                       ; Print character function
    INT 21H                         ; Print the digit
    DEC CX                          ; Decrement digit counter
    JMP PRINT_DIGITS                ; Continue printing digits

PRINT_DONE:
    RET
PRINT_NUMBER ENDP 

; Exit program
EXIT: MOV AH, 4CH
      INT 21H

; Function to write to IR register
IRWR:   CALL BUSY
        MOV DX, IR_WR
        MOV AL, AH
        OUT DX, AL
        RET

; Function to write to DR register
OUTL:   CALL BUSY
        MOV AL, AH
        MOV DX, DR_WR
        OUT DX, AL
        RET

; Function to read from keypad
KEYPAD:       
    PUSH AX
    PUSH DX
    
    MOV DX, CNTR79
    MOV AL, 0
    OUT DX, AL
    MOV AL, 39H
    OUT DX, AL
    
LOOP_MAIN:  
    MOV DX, CNTR79
LOOP1:      
    IN  AL, DX
    TEST AL, 7
    JZ  LOOP1
    MOV DX, DATA79
    IN  AL, DX
    ADD AL, 30H
    POP DX
    MOV AH, 0                 ; Clear AH
    POP DX                    ; Restore DX (overwrite saved AX)
    RET

; Function to check if device is busy
BUSY:   MOV DX, IR_RD
BUSY1:  IN  AL, DX
        AND AL, 80H
        JNZ BUSY1
        RET

CODE ENDS        
END START