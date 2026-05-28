# 8086 Classroom Grading System

This repository contains an 8086 Assembly project for a classroom grading task. The program reads student numbers and grades, stores them in two separate memory tables, then rearranges both tables in descending order according to the grades.

The implementation is designed for an 8086 microprocessor training-kit workflow. Numeric data is entered from the keypad, prompts and results are shown on the LCD, and the sorted output is also printed through DOS/EMU-style `INT 21H` console output routines when that environment is available.

## Project Requirement

A classroom has `N` students. Their student numbers and grades are stored in memory. The required output is two tables:

- Student numbers arranged according to the sorted grades.
- Grades sorted in descending order.

## What This Code Actually Implements

The repository documentation is based on the actual source code, not only on the project statement. The implemented behavior includes:

- Reading the number of students `N` from the kit keypad.
- Reading student numbers one by one and storing them in the `STUDENT_NUMS` word array.
- Reading grades one by one and storing them in the `GRADES` word array.
- Supporting up to 100 students using `DW 100 DUP(?)` arrays.
- Using the physical `F` key on the kit as the Enter/Confirm key during numeric input.
- Echoing the typed digits on the LCD while the user enters a number.
- Sorting grades in descending order using Bubble Sort.
- Swapping the corresponding student number whenever two grades are swapped, so each student remains linked to the correct grade.
- Keeping equal grades in their original relative order because the code skips swapping when the current grade is greater than or equal to the next grade.
- Displaying prompts on both the LCD and the console.
- Displaying the sorted results on the console.
- Displaying one sorted student/grade pair at a time on the LCD.
- Waiting for the physical `F` key after each LCD result before moving to the next sorted result.
- Using separate procedures for keypad input, LCD instruction writing, LCD data writing, LCD busy checking, number reading, number printing, and sorting.

## Important F-Key Behavior

The normal keyboard Enter key is not the main key in the kit interaction. In this code, the physical `F` key has two important roles:

1. **Input confirmation:** When entering any number, type its digits, then press `F` to finish that number. For example, `101F` means the number `101` was entered.
2. **Output navigation:** After sorting, the LCD displays one sorted record at a time. Press `F` to move from the current student/grade pair to the next one.

Internally, the keypad routine adds `30H` to the returned keypad value. Because of that, the physical `F` key is checked in the source code using:

```asm
CMP AL, 3FH
```

## User Flow on the Kit

```text
1. The program asks for the number of students.
2. The user enters N, then presses F.
3. The program asks for student numbers.
4. The user enters each student number, pressing F after each one.
5. The program asks for grades.
6. The user enters each grade, pressing F after each one.
7. The program sorts the grades in descending order.
8. The LCD displays the highest-grade student first.
9. The user presses F to display the next sorted student.
10. The process repeats until all sorted students are displayed.
```

## Algorithm

The project uses Bubble Sort because it is simple to implement using 8086 registers, indexed memory access, loops, and conditional jumps.

```text
For each pass:
    Compare the current grade with the next grade.
    If the next grade is higher:
        Swap the two grades.
        Swap the corresponding student numbers.
Repeat until the tables are sorted in descending order.
```

## Data Structures

| Name | Type | Purpose |
|---|---|---|
| `N` | `DW` | Stores the number of students. |
| `STUDENT_NUMS` | `DW 100 DUP(?)` | Stores student numbers. |
| `GRADES` | `DW 100 DUP(?)` | Stores grades corresponding to the same indexes in `STUDENT_NUMS`. |

## Main Procedures

| Procedure | Role |
|---|---|
| `MAIN` | Controls the complete program flow: input, sorting, and output. |
| `READ_NUMBER` | Reads a multi-digit unsigned number from the keypad until the `F` key is pressed. |
| `SORT_BY_GRADES` | Sorts grades in descending order and swaps the linked student numbers. |
| `PRINT_NUMBER` | Prints a number through DOS/console output. |
| `PRINT_LCD_NUMBER` | Prints a number on the LCD. |
| `KEYPAD` | Reads a key from the kit keypad. |
| `IRWR` | Writes an instruction/command to the LCD instruction register. |
| `OUTL` | Writes data/characters to the LCD data register. |
| `BUSY` | Polls the LCD busy flag before writing. |

## Hardware / I/O Notes

The code uses port-based I/O addresses for the LCD and keypad interface:

| Symbol | Address | Purpose |
|---|---:|---|
| `IR_WR` | `0FFC1H` | LCD instruction register write. |
| `IR_RD` | `0FFC3H` | LCD instruction register read / busy checking. |
| `DR_WR` | `0FFC5H` | LCD data register write. |
| `DATA79` | `0FFE8H` | Keypad data port. |
| `CNTR79` | `0FFEAH` | Keypad control/status port. |

## Example

Input using the kit keypad:

```text
Number of students: 5F
Student numbers: 101F, 102F, 103F, 104F, 105F
Grades: 75F, 90F, 60F, 85F, 95F
```

Sorted output:

```text
Student Number: 105, Grade: 95
Student Number: 102, Grade: 90
Student Number: 104, Grade: 85
Student Number: 101, Grade: 75
Student Number: 103, Grade: 60
```

LCD output sequence:

```text
LCD shows: Stud#: 105 / Grade: 95
Press F
LCD shows: Stud#: 102 / Grade: 90
Press F
LCD shows: Stud#: 104 / Grade: 85
Press F
LCD shows: Stud#: 101 / Grade: 75
Press F
LCD shows: Stud#: 103 / Grade: 60
```

## Repository Structure

```text
8086-Classroom-Grading-System/
├── src/
│   └── classroom_grading.asm
├── docs/
│   ├── project_statement.png
│   ├── Classroom_Grading_Report.docx
│   └── Classroom_Grading_Report.pdf
├── examples/
│   └── sample_input_output.txt
├── README.md
└── .gitignore
```

## Requirements

- 8086 Assembly environment.
- MTS-86C 8086 microprocessor training kit or a compatible 8086 kit.
- LCD and keypad interface support.
- EMU8086/DOS-style environment if the `INT 21H` console output parts are tested.

## Notes and Limitations

- The maximum array capacity in the current source code is 100 students.
- The keypad input routine is designed for unsigned numeric input.
- No grade-range validation is implemented, so the code does not automatically reject values above 100.
- The physical `F` key is required after every entered number.
- The physical `F` key is also required to move through sorted LCD results.
- The program combines kit I/O routines with DOS interrupt output, so the exact testing setup may affect which output path is visible.
- The LCD number-printing routine handles zero correctly. The console `PRINT_NUMBER` zero case should be corrected before using zero as a student number or grade in console-based testing.

## Complexity

Bubble Sort has a time complexity of `O(N^2)`. Memory usage is `O(N)` because two arrays store student numbers and grades.

## Author

Ahmed Negm
