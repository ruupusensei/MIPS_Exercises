.data
  prompt: .asciiz "Please input an integer:\n"
  reply: .asciiz "The 2's compliment binary value of your input is: "
  .globl main

.text
  main:

  li $v0 4 #system call for print string
  la $a0 prompt
  syscall #prints prompt

  li $v0 5 #system call for int input
  syscall

  move $s0 $v0 #move input to register $s0

  addi $s1 $zero 32 #loop exit condition
  addi $s2 $zero 0 #amount to shift left each loop, is incremented each iteration

  li $v0 4 #system call for print string
  la $a0 reply
  syscall #prints reply

  Loop: #loop for printing each individual bit

        #check loop condition
        beq $s2 $s1 Exit #branch to exit if all 32 bits have been iterated over

        sllv $a0 $s0 $s2 # shift left by the value in $s2, grows from 0-31
        srl $a0 $a0 31 # puts the rightmost bit in the leftmost position
        # all other bits are masked by the shift.

        li $v0 1 #system call to print integer
        syscall #the input we want to print is already in $a0

        addi $s2 $s2 1 #increment amount to shift left by 1

        j Loop #return to the top of the loop

  Exit: #exits the program
        li $v0 10 # system call to exit
        syscall
