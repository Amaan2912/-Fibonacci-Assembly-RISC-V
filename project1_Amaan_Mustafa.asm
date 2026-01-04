.data
# Buffer is used to read the maximum amount of characters from a user's string input 
buffer: .space 64
# Prompt is used to tell the user to enter n
prompt: .asciz "Enter an integer value n:\n"
value: .asciz "user input value = "
result: .asciz "\nthe Fibonacci number is "
.text
main:
# This code prompts the user to enter a number string n by calling 4 into argument a7
la a0, prompt
li a7, 4
ecall

# This code stores the user's string input into an argument register by calling 8 into argument a7
la a0, buffer
addi a1, zero, 64
li a7, 8
ecall

# This code loads the user's inputted string value into a temporary register
la t0, buffer
li t1, 0
# This register stores the number that will be used to shift the empty register's byte to make room for the converted integer's ten's places
li t3, 10
# These two temporary registers hold ASCII values for the upper and lower limits of checking each string character
li t4, '0'
li t5, '9'

# This code is used to convert a string into a integer using ASCII conversion along with loading each converted value
convert:
lb t2, (t0)
# This line checks if the loaded byte character is a null value
beqz, t2, end
# This checks if the loaded character is a newline
beq t2, t3, end
# These two lines check if the loaded character is not a digit 0-9
blt, t2, t4, move
bgt t2, t5, move

# This converts a character string into an integer by subtracting the loaded character by the ASCII value of 0
# Next, it multiplies t1 by 10 to shift t1 register's bytes to the right to make room for one digit place
# Afterwards, the converted integer is added to t1
sub t2, t2, t4
mul t1, t1, t3
add t1, t1, t2
addi t0, t0, 1
j convert

# This procedure moves the inputted string's pointer to the next value after a non-digit is found
move:
addi t0, t0, 1
jal zero, convert
# after the inputted string is converted into an integer, the integer is added to a saved register s2
end:
addi s2, t1, 0


# This code is used to calculate a Fibonacci number from n using an iterative process
mv t5, s2	# The saved register is used as a loop counter to ensure the Pibonacci procedure calculates the number at (n-1)
addi s0, x0, 0
addi s1, x0, 1
# these two saved registers above use 0 and 1 as a starting point for the Fibonacci calculation procedure
li t0, 0	# This temporary register t0 is used as a summed result starting at 0
li t6, 1
# If the user's converted integer equals 0 or 1, then the code branches to a procedure where 0 or 1 is added to a saved register s4
beqz t5, fibo_zero
beq t5, t6, fibo_one
# This code is executed to ensure that the Fibonacci procedure loops (n-1) times
addi t5, t5, -1


fibo:
add t0, s0, s1
# Since the Fibonacci calcuation uses two positive integers, this line of code checks if the result is negative.
# This is the case for overflow because a positive number plus another one make a positive
bltz t0, over
mv s0, s1	# This line sets the first operand of the new iteration as the second operand of the previous iteration
mv s1, t0	# This line sets the second operand of the new iteration as the summed result of the previous iteration
addi t5, t5, -1
bnez t5, fibo
# This code stores the returning result (t0) into a saved register s4 if the loop counter (t5) equals zero
mv s4, t0
j final

# This code below stores the Fibonacci number as -1 if there is a signed overflow with a negative result and positive operands
over:
li s4, -1
j final
# This code below stores the Fibonacci number as 0 if the user's inputted integer is 0
fibo_zero:
li s4, 0
j final
# This code below stores the Fibonacci number as 1 if the user's inputted integer is 1
fibo_one:
li s4, 1
j final

# The following code prints the user's inputted number (n) and their resulting Fibonacci number by calling a7 with the number 1.
# Register a7 is called with 4 to print the program's clear instruction on what number will be printed at the terminal
final:
la a0, value
li a7, 4
ecall 
mv a0, s2 
li a7, 1
ecall
la a0, result
li a7, 4
ecall
mv a0, s4
li a7, 1
ecall
# This code exits the program
li a7, 10
ecall
