# Fibonacci Number Calculator Assembly Program (RISC-V)

This project utilizes a Fibonacci iterative sequence calculator in RISC-V assembly language. This program reads and parses ASCII input, converts it to an integer, and computes F(n) using an iterative procedure rather than recursion. I implemented overflow detection logic to return safe error values for out-of-range Fibonacci results. To accomplish the string to integer conversion, I utilized RARS system calls for string input and formatted output following calling-convention standards.

The project demonstrates my understanding of how low-level programming language interacts with the computer's inner workings, including memory registers. Additionally, I also learned that programming in assembly language requires attention to detail when it comes to executing instructions that affect whichever data is used for a specific program.

If you want to check out this program, please take a look at the "asm" file, and install RARS system to test the program.
