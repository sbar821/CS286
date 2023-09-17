########             IF-THEN            ########
########          PROJECT1 PT1          ########
########         SYDNEY BARNETT         ########

.data

STR_PROMPT1: .asciiz "Enter your current driving speed in MPH (1 to 200): "
STR_PROMPT2: .asciiz "Enter the absolute speed limit specified for the road you are currently running on (15 - 70): "
STR_ERROR1:  .asciiz "You made an invalid input for your current driving speed. Enter a valid input for your current driving speed.\n"
STR_ERROR2:  .asciiz "You made an invalid input for the absolute speed limit. Enter a valid input for the speed limit.\n"
STR_RESULT1: .asciiz "\nYou are a safe driver!"
STR_RESULT2: .asciiz "\nYou may receive a $120 fine"
STR_RESULT3: .asciiz "\nYou may receive a $140 fine"
STR_RESULT4: .asciiz "\nClass B misdemeanor and carries up to six months in jail and a maximum $1,500 in fines"
STR_RESULT5: .asciiz "\nClass A misdemeanor and carries up to one year in jail and a maximum $2,500 in fines"

.text
.globl main

main:
	li $t0, 0 		   # current speed variable
	li $t1, 0		   # limit variable
	li $t2, 0		   # difference variable (speed - limit)

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
	ble    $t0, 200, Q1_PT2    # tests if $t0 <= 200; if pass- jump to PT2
        li     $v0, 4              # output to screen
        la     $a0, STR_ERROR1     # point to the message
        syscall                    # push
	j Q1		           # if fail- jump to Q1

Q1_PT2:
	# branch #####################################
	bge    $t0, 1, Q2          # tests if $t0 >= 1; if pass- jump to Q2
	li     $v0, 4              # output to screen
        la     $a0, STR_ERROR1     # point to the message
        syscall                    # push
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
	ble    $t1, 70, Q2_PT2     # tests if $t1 <= 70; if pass- jump to PT2
        li     $v0, 4              # output to screen
        la     $a0, STR_ERROR2     # point to the message
        syscall                    # push
	j Q2	  	           # if fail- jump to Q2

Q2_PT2:
	# branch #####################################
	bge    $t1, 15, MATH       # tests if $t1 >= 15; if pass- jump to MATH
	li     $v0, 4              # output to screen
        la     $a0, STR_ERROR2     # point to the message
        syscall                    # push
	j Q2		           # if fail- jump to Q2


MATH:
	# create variable ############################
	sub   $t2, $t0, $t1	   # creates the difference


CLASS_A:
	# 35+ response ###############################
	blt    $t2, 35, CLASS_B    # tests if $t2 < 35; if pass- jump to CLASS_B
        li     $v0, 4              # output to screen
        la     $a0, STR_RESULT5    # point to the message
        syscall			   # push
	j STOP			   # if pass, quit

CLASS_B:
	# 26-34 response #############################
	blt    $t2, 26, MED_FINE   # tests if $t2 < 26; if pass- jump to MED_FINE
        li     $v0, 4              # output to screen
        la     $a0, STR_RESULT4    # point to the message
        syscall			   # push
	j STOP                     # if pass, quit

MED_FINE:
	# 21-25 response #############################
	blt    $t2, 21, SMALL_FINE # tests if $t2 < 21; if pass- jump to SMALL_FINE
        li     $v0, 4              # output to screen
        la     $a0, STR_RESULT3    # point to the message
        syscall			   # push
	j STOP			   # if pass, quit

SMALL_FINE:
	# 1-20 response ##############################
	blt    $t2, 1, SAFE        # tests if $t2 < 1; if pass- jump to SAFE
        li     $v0, 4              # output to screen
        la     $a0, STR_RESULT2    # point to the message
        syscall			   # push
	j STOP			   # if pass, quit

SAFE:
	# 1 and under response #######################
        li     $v0, 4              # output to screen
        la     $a0, STR_RESULT1    # point to the message
        syscall			   # push

STOP:
        # stop this program ##########################
        jr     $31

#######################  EOF  ########################