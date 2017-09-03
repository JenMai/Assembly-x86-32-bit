# PURPOSE: This program will compute the square of 2

.section .data

.section .text

.globl _start
_start:
    pushl $2                    # push argument
    call square
    addl  $4, %esp              # scrubs the parameter that was
	                            # pushed on the stack

    movl %eax, %ebx             # result in %ebx
    movl $1, %eax               # exit, %ebx is returned
    int $0x80

# PURPOSE: This function is used to compute
# the value of a number squared.
#
# INPUT: One parameter - The number to square
#
# OUTPUT: Will give the result as a return value
#
# VARIABLES:
# 8(%ebp) - holds the base number
# %eax - holds the base number as well, plus result
#

.type square, @function
square:
    pushl %ebp                  # save old base pointer
    movl %esp, %ebp             # make stack pointer the base pointer

    addl 8(%ebp), %eax          # add parameter into %eax

    imul 8(%ebp), %eax          # multiply the value by itself,
                                # result in %eax
    je end_square
end_square:
    movl %ebp, %esp             # restore the stack pointer
    popl %ebp                   # restore the base pointer
    ret
