	# PURPOSE: Given a number, this program computes the
	#          factorial.  For example, the factorial of
	#          3 is 3 * 2 * 1, or 6.  The factorial of
	#          4 is 4 * 3 * 2 * 1, or 24, and so on.
	#
    # NOTE: first version is a recursive function,
    #       exercise required to make it non-recursive

	.section .data

	#This program has no global data

	.section .text

	.globl _start
	.globl factorial     # this is unneeded unless we want to share
	                     # this function among other programs
_start:
	pushl $4             # The factorial takes one argument - the 
	                     # number we want a factorial of.  So, it
	                     # gets pushed
	call  factorial      # run the factorial function
	addl  $4, %esp       # scrubs the parameter that was pushed on 
	                     # the stack
	movl  %eax, %ebx     # factorial returns the answer in %eax, but 
	                     # we want it in %ebx to send it as our exit 
	                     # status
	movl  $1, %eax       # call the kernel's exit function
	int   $0x80


# PURPOSE: This function is used to compute
# the factorial of a number
#
# INPUT: First argument - the base number
#
# OUTPUT: Will give the result as a return value
#
# NOTES: The base number must be 1 or greater
#
# VARIABLES:
# 8(%ebp) - holds the first parameter, then decreased
#
# %eax - holds the current result
#
	.type factorial,@function
factorial:
	pushl %ebp          # standard function stuff - we have to 
	                    # restore %ebp to its prior state before 
	                    # returning, so we have to push it
	movl  %esp, %ebp    # This is because we don't want to modify
	                    # the stack pointer, so we use %ebp.

	movl  8(%ebp), %eax # This moves the first argument to %eax
	                    # 4(%ebp) holds the return address, and
	                    # 8(%ebp) holds the first parameter
    
    decl  8(%ebp)       # decrease the value for the first imul
                        # with parameter              

    factorial_loop_start:
	cmpl  $1, 8(%ebp)   # If the number is 1, end of loop
	je end_factorial    

	imull 8(%ebp), %eax # multiply that by the result of the
	                    # last loop.
    decl  8(%ebp)       # otherwise, decrease the value
    jmp factorial_loop_start

    end_factorial:
        movl  %ebp, %esp # standard function return stuff - we
        popl  %ebp       # have to restore %ebp and %esp to where
                         # they were before the function started
        ret              # return from the function (this pops the 
                         # return value, too)
        
