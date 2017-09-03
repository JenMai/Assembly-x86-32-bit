    # PURPOSE: Similar as power.s (2 arguments and stack for calling convention), 
    # using registers only as calling convention
    # This program will compute the value of
    # 2^3 + 5^2 + 3^0
    #
    # Everything in the main program is stored in registers,
    # so the data section doesn’t have anything.
    .section .data

    .section .text

    .globl _start
_start:
    movl $2, %ecx                # move first argument
    movl $3, %edx                # move second argument
    call power                   # call the function

    addl %eax, %ebx

    movl $5, %ecx                # move first argument
    movl $2, %edx                # move second argument
    call power                   # call the function

    addl %eax, %ebx

    movl $3, %ecx                # move first argument
    movl $0, %edx                # move second argument
    call power

    addl %eax, %ebx

    movl $1, %eax                # exit (%ebx is returned)
    int $0x80

# PURPOSE: This function is used to compute
# the value of a number raised to
# a power.
#
# INPUT: First argument - the base number
# Second argument - the power to
# raise it to
#
# OUTPUT: Will give the result as a return value
#
# NOTES: The power must be 0 or greater
#
# VARIABLES:
# %ecx - holds the base number
# %edx - holds the power
#
# %eax - holds the current result
#
.type power, @function
power:

    movl %ecx, %eax              # store current result

    power_loop_start:

        cmpl $0, %edx            # if the power is 0, return 1 as result
        je end_power_0

        cmpl $1, %edx            # if the power is 1, we are done
        je end_power

        imul %ecx, %eax          # multiply the current result by
                                 # the base number

        decl %edx                # decrease the power
        jmp power_loop_start     # run for the next power

        end_power:
            ret

        end_power_0:
            movl $1, %eax        # return 1 in %eax
            ret


