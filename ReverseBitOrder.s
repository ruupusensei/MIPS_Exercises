
.data
  var1: .word 0x89abcdef #word to be reversed
  array1: .space 4  #space to place reversed word
  initially: .asciiz "Initially in memory: 0x89abcdef"
  reversed: .asciiz "\nWith reversed byte order: 0xefcdab89"

.text
  main:
  la $s0 var1 #load address in memory of var1
  la $s1 array1 #load address of array1

  # load and store bytes in reverse order
  lb $t0 0($s0)
  sb $t0 3($s1)

  lb $t1 1($s0)
  sb $t1 2($s1)

  lb $t2 2($s0)
  sb $t2 1($s1)

  lb $t3 3($s0)
  sb $t3 0($s1)

  lw $s2 array1 #load the reversed bytes into $s2

  li $v0 4 #system call for print string
  la $a0 initially
  syscall

  li $v0 4 #system call for print string
  la $a0 reversed
  syscall

  li $v0 10 # system call to exit
  syscall
