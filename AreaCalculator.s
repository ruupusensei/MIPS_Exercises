.data
  #strings to be printed during program operation
  welcome: .asciiz "Welcome to the area calculator.\n"
  enterWidth: .asciiz "Please enter a value for the width: \n"
  enterHeight: .asciiz "Please enter a value for the height: \n"
  result: .asciiz "The area is: "
  again: .asciiz "\nEnter 0 to Exit or any other integer to continue.\n"
  error: .asciiz "Negative or 0-length dimensions are not allowed.\nPlease try again.\n"
  goodbye: .asciiz "Exiting the program. Thank you!"

  .globl main

.text
  main:

  li $v0 4 #system call for print string
  la $a0 welcome #loads memory address for welcome into $a0
  syscall #prints welcome

  j Input #immediately jumps to ask for user input upon startup

  Input: #branch here upon startup or when the user elects to calculate again

         li $v0 4 #system call for print string
         la $a0 enterWidth #loads memory address for enterWidth into $a0
         syscall #prints enterWidth

         li $v0 5 #system call for int input
         syscall

         #check for invalid input
         slti $t0 $v0 1 # $t0 = 1 if $v0 < 1, else 0
         bne $t0 $zero Error # if $t0 is non-0, then input is invalid, branch to Error

         move $a1 $v0 #moves valid user input for width to $a1

         li $v0 4 #system call for print string
         la $a0 enterHeight #loads memory address for enterHeight into $a0
         syscall #prints enterHeight

         li $v0 5 #system call for int input
         syscall

         #check for invalid input
         slti $t0 $v0 1 # $t0 = 1 if $v0 < 1, else 0
         bne $t0 $zero Error # if $t0 is non-0, then input is invalid, branch to Error

         move $a2 $v0 #moves valid user input for height to $a2

         jal Area #jump and link to Area function

         #result of calculation is stored in $a3 after Area procedure

         li $v0 4 #system call for print string
         la $a0 result #loads memory address for result into $a0
         syscall #prints result

         li $v0 1 #system call to print int
         add $a0 $a3 $zero #result of $a1 * $a2 moved from $a3 to $a0
         syscall

         li $v0 4 #system call for print string
         la $a0 again #loads memory address for again into $a0
         syscall #prints again

         li $v0 5 #system call for int input
         syscall

         beq $v0 $zero Exit # branch to exit if user input is 0

         j Input #else jump back to input for another calculation

  Area: #function to calculate area based on user input (dimensions)

        mult $a1 $a2 # multiply $a1 * $a2
        mflo $a3 # lower 32 bits of product in $a3
        jr $ra #jumps to saved return address from jump and link in Input

  Error: #branch here when user input is invalid

         li $v0 4 #system call for print string
         la $a0 error #loads memory address for error message into $a0
         syscall #prints error message

         j Input # jumps back to input so user can start again

  Exit: #branch here when user decides to exit the program.
        li $v0 4 #system call for print string
        la $a0 goodbye #loads memory address for goodbye into $a0
        syscall #prints goodbye

        li $v0 10 # system call to exit
        syscall
