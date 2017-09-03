	# PURPOSE:  This program finds the maximum number of a
	#          set of data items.
	#

	# VARIABLES: The registers have the following uses:
	#
	# %edi - Holds the index of the data item being examined 
	# %ebx - Largest data item found
	# %eax - Current data item
	#
	# The following memory locations are used:
	#
	# data_items - contains the item data.  A 0 is used
	#              to terminate the data
	#

	.section .data

data_items:                      # These are the data items
	.long 66,67,34,222,45,75,54,34,44,33,22,11,0

	.section .text

	.globl _start
_start:
    pushl $data_items           # push address of list as argument
    call get_maximum

    movl %eax, %ebx             # result in %ebx
    movl $1, %eax               # exit, %ebx is returned
    int $0x80

# PURPOSE: 
#
# INPUT: 
#
# OUTPUT: Will return the greatest value of the list
#
# NOTES:
#
# VARIABLES:
# %ecx - pointer to list
# %eax - holds greatest result
# %ebx

.type get_maximum, @function
get_maximum:
    pushl %ebp                # save old base pointer
    movl %esp, %ebp           # make stack pointer the base pointer

	movl 8(%ebp), %ecx        # pointer to list

    movl (%ecx), %eax         # points to first item,
                              # set as the greatest
    movl 4(%ecx), %ebx        # points to second item for comparison

start_loop:	                  # start loop
	addl $4, %ecx             # points to next item
    movl (%ecx), %ebx

	cmpl $0, %ebx             # check to see if we've hit the end
	je maximum_exit
    
	cmpl %ebx, %eax           # compare values
	jge start_loop            # jump to loop beginning if the new 
	                          # one isn't bigger
	movl %ebx, %eax           # move the value as the largest 
	jmp start_loop            # jump to loop beginning

maximum_exit:
    movl %ebp, %esp           # restore the stack pointer
    popl %ebp                 # restore the base pointer
    ret

