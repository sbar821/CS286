########              WHILE             ########
########          PROJECT1 PT2          ########
########         SYDNEY BARNETT         ########

.data

STR_PROMPT1: .asciiz "Enter the origin of your number sequence: "
STR_PROMPT2: .asciiz "\nEnter your multiple factor: "
STR_PROMPT3: .asciiz "\nEnter the total number of the numbers: "
STR_RESULT1: .asciiz "\n\nCheck-sum: "
STR_FILLER:  .asciiz ", "
STR_NEWLINE: .asciiz "\n"

.text
.globl main

main:
	li $t0, 0 		   # origin variable
	li $t1, 0		   # multiple variable
	li $t2, 0		   # total num variable
	li $t3, 0		   # total sum variable
	li $t4, 0		   # loop variable

Q1:
        # print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, STR_PROMPT1    # point to the message
        syscall                    # push

        # wait for user response #####################
        li     $v0, 5              # read the int
        syscall                    # push
	move   $t0, $v0		   # store variable
        
	# branch #####################################
	ble    $t0, 5, Q1_PT2      # tests if $t0 <= 5; if pass- jump to PT2 !!!!!MAY NEED CHANGED TO BE NONINCLUSIVE
	j Q1		           # if fail- jump to Q1

Q1_PT2:
	# branch #####################################
	bge    $t0, 1, Q2          # tests if $t0 >= 1; if pass- jump to Q2 !!!!!MAY NEED CHANGED TO BE NONINCLUSIVE
	j Q1	        	   # if fail- jump to Q1

Q2:
        # print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, STR_PROMPT2    # point to the message
        syscall                    # push

        # wait for user response #####################
        li     $v0, 5              # read the int
        syscall                    # push
	move   $t1, $v0		   # store variable
        
	# branch #####################################
	ble    $t1, 7, Q2_PT2      # tests if $t1 <= 7; if pass- jump to PT2 !!!!!MAY NEED CHANGED TO BE NONINCLUSIVE
	j Q2	  	           # if fail- jump to Q2

Q2_PT2:
	# branch #####################################
	bge    $t1, 2, Q3          # tests if $t1 >= 2; if pass- jump to PT2 !!!!!MAY NEED CHANGED TO BE NONINCLUSIVE
	j Q2		           # if fail- jump to Q2

Q3:
        # print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, STR_PROMPT3    # point to the message
        syscall                    # push

        # wait for user response #####################
        li     $v0, 5              # read the int
        syscall                    # push
	move   $t2, $v0		   # store variable

        # print newline ##############################
        li     $v0, 4              # output to screen
        la     $a0, STR_NEWLINE    # point to the message
        syscall                    # push
        
	# branch #####################################
	ble    $t2, 30, Q3_PT2     # tests if $t2 <= 30; if pass- jump to PT2 !!!!!MAY NEED CHANGED TO BE NONINCLUSIVE
	j Q3	  	           # if fail- jump to Q3

Q3_PT2:
	# branch #####################################
	bge    $t2, 3, NUM         # tests if $t2 >= 3; if pass- jump to NUM !!!!!MAY NEED CHANGED TO BE NONINCLUSIVE
	j Q3		           # if fail- jump to Q3

NUM:

	# print num #################################
	move   $a0, $t0		   # move to be usable
        li     $v0, 1              # output num to screen
        syscall                    # push

	# math ######################################
	add    $t3, $t3, $t0	   # adds to find total sum
	add    $t0, $t0, $t1	   # adds multiple to initial
	add    $t4, $t4, 1	   # loop counter
	beq    $t4, $t2, SUM       # if loop var != total iter, start loop again (so it will skip comma)

COMMA:
	# print comma ###############################
        li     $v0, 4              # output to screen
        la     $a0, STR_FILLER     # point to the message
        syscall                    # push

LOOP:
	# loop ######################################
	bne    $t4, $t2, NUM       # if loop var != total iter, start loop again

SUM:
        # print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, STR_RESULT1    # point to the message
        syscall                    # push

        # print sum ##################################
	move   $a0, $t3		   # moves to be usable
        li     $v0, 1              # output to screen
        syscall                    # push

STOP:
        # stop this program ########################
        jr     $31

######################  EOF  #######################