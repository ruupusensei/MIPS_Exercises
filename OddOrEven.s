.data

  prompt: .asciiz "Enter an integer (0 to exit): "
  oddString: .asciiz "The number is odd.\n"
  evenString: .asciiz "The number is even.\n"
  closing: .asciiz "Exiting the application."
  .globl main

  #use and to determine whether or not last bit is 0 or 1
.text
  main:
    j Loop

  Loop: li $v0 4 #system call for print string
        la $a0 prompt
        syscall #prints prompt

        li $v0 5 #system call for integer input
        syscall

        move $t0 $v0 #move user input to temp register $t0
        beq $t0 $zero Exit

        andi $t1 $t0 0x01
        beq $t1 $zero Even # $t1 = 0 branch to Even
        j Odd # $t1 = 1 branch to Odd

  Even: li $v0 4 #system call for print string
        la $a0 evenString
        syscall #prints evenString
        j Loop

  Odd:  li $v0 4 #system call for print string
        la $a0 oddString
        syscall #prints oddString
        j Loop

  Exit: li $v0 4 #system call for print string
        la $a0 closing
        syscall #prints closing

        li $v0 10 # system call to exit
        syscall
