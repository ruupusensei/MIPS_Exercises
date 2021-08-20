#MIPS program to calculate polynomial ax^2 - bx + c

.data
  enterA: .asciiz "Enter data for a: \n"
  enterB: .asciiz "Enter data for b: \n"
  enterC: .asciiz "Enter data for c: \n"
  enterX: .asciiz "Enter data for x: \n"
  result: .asciiz "The result is: \n"

  .globl main

.text
  main:
  li $v0 4 #system call for print string
  la $a0 enterA
  syscall #prints enterA

  li $v0 5 #system call for int input
  syscall

  move $t0 $v0 #move input (a) to temp register $t0

  li $v0 4 #system call for print string
  la $a0 enterB
  syscall #prints enterB

  li $v0 5 #system call for int input
  syscall

  move $t1 $v0 #move input (b) to temp register $t1

  li $v0 4 #system call for print string
  la $a0 enterC
  syscall #prints enterC

  li $v0 5 #system call for int input
  syscall

  move $t2 $v0 #move input (c) to temp register $t2

  li $v0 4 #system call for print string
  la $a0 enterX
  syscall #prints enterX

  li $v0 5 #system call for int input
  syscall

  move $t3 $v0 #move input (x) to temp register $t3

  #a in $t0, b in $t1, c in $t2, x in $t3

  mult $t3 $t3 # calculate x^2

  mflo $t4 # x^2 in $t4

  mult $t4 $t0 # calculate ax^2

  mflo $t4 # ax^2 in $t4

  mult $t3 $t1 # calculate bx

  mflo $t5 # bx in $t5

  sub $t4 $t4 $t5 # ax^2 - bx in $t4

  add $t4 $t4 $t2 # add c to ax^2 - bx, in $t4

  #now  ax^2 - bx + c is now in $t4

  li $v0 4 #system call for print string
  la $a0 result
  syscall #prints result

  li $v0 1 #system call to print int
  move $a0 $t4 #move result to $a0
  syscall

  li $v0 10 # system call to exit
  syscall
