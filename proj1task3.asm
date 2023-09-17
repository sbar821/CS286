########         FLOATING POINT         ########
########          PROJECT1 PT3          ########
########         SYDNEY BARNETT         ########

.data

RATIO:       .float   0.08219
PRINC_MAX:   .float   1000000.00
PRINC_MIN:   .float   100.00
INTER_MAX:   .float   0.399
INTER_MIN:   .float   0.005
MON_MAX:     .float   2000000.00
MON_MIN:     .float   1.00

STR_PROMPT1: .asciiz "Enter the principal in $ (100.00 - 1,000,000.00): "
STR_PROMPT2: .asciiz "Enter the annual interest rate (0.005 - 0.399): "
STR_PROMPT3: .asciiz "Enter the monthly payment amount in $ (1.00 - 2,000,000.00): "
STR_RESP1:   .asciiz "month "
STR_RESP2:   .asciiz ": current principal = "
STR_RESP3:   .asciiz "month "
STR_RESP4:   .asciiz "It will take "
STR_RESP5:   .asciiz " months to complete the loan."
ERROR:	     .asciiz "You made an invalid input. Please enter a new input.\n"
NEWLINE:     .asciiz "\n"

.text
.globl main

main:
	li   $t0, 1 	 	   # loop/month counter
	li.s $f10, 0.0             # temp
	li.s $f12, 0.0             # principal
	li.s $f14, 0.0             # interest
	li.s $f16, 0.0             # monthly payment

	la    $a0, RATIO           # load the ratio constant
        lwc1  $f17, ($a0)          # load it to $f17 register

	la    $a0, PRINC_MAX       # load the max principal constant
        lwc1  $f18, ($a0)          # load it to $f18 register

 	la    $a0, PRINC_MIN       # load the min principal constant
        lwc1  $f20, ($a0)          # load it to $f20 register

 	la    $a0, INTER_MAX       # load the max monthly interest constant
        lwc1  $f22, ($a0)          # load it to $f22 register

 	la    $a0, INTER_MIN       # load the min monthly interest constant
        lwc1  $f24, ($a0)          # load it to $f24 register

 	la    $a0, MON_MAX         # load the max monthly payment constant
        lwc1  $f26, ($a0)          # load it to $f26 register

 	la    $a0, MON_MIN         # load the min monthly payment constant
        lwc1  $f28, ($a0)          # load it to $f28 register

Q1:
        # print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, STR_PROMPT1    # point to the message
        syscall                    # push

        # wait for user response #####################
        li     $v0, 6              # read the float
        syscall                    # push
	mov.s  $f12, $f0  	   # store variable
        
	# branch #####################################
	c.lt.s $f12, $f18	   # tests if $f12 < 1mil
	bc1t    Q1_PT2	  	   # if pass- jump to PT2

	# print error ################################
        li     $v0, 4              # output to screen
        la     $a0, ERROR          # point to the message
        syscall                    # push
	j 	Q1		   # if fail- jump to Q1

Q1_PT2:
	# branch #####################################
	c.lt.s $f20, $f12	   # tests if $f12 > 100;
	bc1t    Q2		   # if pass- jump to Q2	

	# print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, ERROR          # point to the message
        syscall                    # push
	j       Q1		   # if fail- jump to Q1

Q2:
        # print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, STR_PROMPT2    # point to the message
        syscall                    # push

        # wait for user response #####################
        li     $v0, 6              # read the float
        syscall                    # push
	mov.s  $f14, $f0  	   # store variable
        
	# branch #####################################
	c.lt.s $f14, $f22	   # tests if $f14 < .399
	bc1t    Q2_PT2	  	   # if pass- jump to PT2

	# print error ################################
        li     $v0, 4              # output to screen
        la     $a0, ERROR          # point to the message
        syscall                    # push
	j       Q2		   # if fail- jump to Q2

Q2_PT2:
	# branch #####################################
	c.lt.s $f24, $f14	   # tests if $f14 > .005
	bc1t    Q3 	  	   # if pass- jump to Q2

	# print error ################################
        li     $v0, 4              # output to screen
        la     $a0, ERROR          # point to the message
        syscall                    # push
	j 	Q2	           # if fail- jump to Q1

Q3:
        # print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, STR_PROMPT3    # point to the message
        syscall                    # push

        # wait for user response #####################
        li     $v0, 6              # read the float
        syscall                    # push
	mov.s  $f16, $f0  	   # store variable
        
	# branch #####################################
	c.lt.s $f16, $f26	   # tests if $f16 < 2mil
	bc1t    Q3_PT2		   # if pass- jump to PT2

	# print error ################################
        li     $v0, 4              # output to screen
        la     $a0, ERROR          # point to the message
        syscall                    # push
	j 	Q3		   # if fail- jump to Q3

Q3_PT2:
	# branch #####################################
	c.lt.s $f28, $f16	   # tests if $f16 > 1
	bc1t    PREMATH		   # if pass- jump to PREMATH

	# print error ################################
        li     $v0, 4              # output to screen
        la     $a0, ERROR          # point to the message
        syscall  
	j Q3		           # if fail- jump to Q1

PREMATH:

	# print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, STR_RESP1      # point to the message
        syscall                    # push

	# print num #################################
	move   $a0, $t0		   # move to be usable
        li     $v0, 1              # output num to screen
        syscall                    # push

	# print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, STR_RESP2      # point to the message
        syscall                    # push

	# print float ################################
        li     $v0, 2              # output float to screen
        syscall                    # push

	# print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, NEWLINE        # point to the message
        syscall                    # push

MATH:
	# loop ######################################
	add    $t0, $t0, 1	   # loop counter

	# math ######################################
	mul.s  $f10, $f12, $f14    # temp = principal * interest
	mul.s  $f10, $f10, $f17    # temp = temp * month ratio
	sub.s  $f10, $f16, $f10    # temp = monthly payment - principal
	sub.s  $f12, $f12, $f10    # principal = principal - temp

	# print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, STR_RESP1      # point to the message
        syscall                    # push

	# print num #################################
	move   $a0, $t0		   # move to be usable
        li     $v0, 1              # output num to screen
        syscall                    # push

	# print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, STR_RESP2      # point to the message
        syscall                    # push

	# print float ################################
        li     $v0, 2              # output float to screen
        syscall                    # push

	# print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, NEWLINE        # point to the message
        syscall                    # push

	# loop ######################################
	c.lt.s $f12, $f16	   # tests if principal < monthly
	bc1t    FINAL		   # if pass- jump to FINAL
	j MATH			   # if fail- jump to MATH

FINAL:
	# print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, NEWLINE        # point to the message
        syscall                    # push

	# print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, STR_RESP4      # point to the message
        syscall                    # push

	# print num #################################
	move   $a0, $t0		   # move to be usable
        li     $v0, 1              # output num to screen
        syscall                    # push

	# print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, STR_RESP5      # point to the message
        syscall                    # push

	# print prompt ###############################
        li     $v0, 4              # output to screen
        la     $a0, NEWLINE        # point to the message
        syscall                    # push

STOP:
        # stop this program ########################
        jr     $31

######################  EOF  #######################