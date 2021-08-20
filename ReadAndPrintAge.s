.data
  prompt: .asciiz "Please input your age."
  reply: .asciiz "Your age is: "
  .globl main

.text
  main:
  li $v0 4 #system call for print string
  la $a0 prompt
  syscall #prints prompt

  li $v0 5 #system call forint input
  syscall

  move $t0 $v0 #move input to temp register $t0

  li $v0 4 #system call for print string
  la $a0 reply
  syscall #prints reply

  li $v0 1 #system call to print int
  move $a0 $t0 #move int to $a0
  syscall

  li $v0 10 # system call to exit
  syscall
