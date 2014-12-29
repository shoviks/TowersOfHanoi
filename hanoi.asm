#purpose: write a recursive factorial method to illustrate the saving of $ra and $a0.
#main()
#{
#  int input;  
#  printf("Please enter a number:\n"); 
#  scanf("%d", &input) 
#  moveTower(input, 1, 3, 2);
#}
#
#void moveTower(int disk, int source, int dest, int spare) { #fact is the shortcut of factorial
#    if (disk == 1)
#    {
#       printf("Disk moved from %d to %d\n", source, dest);
#    }
#    else
#    {
#       moveTower(disk-1, source, spare, dest);
#       printf("Disk moved from %d to %d\n", source, dest);
#       moveTower(disk-1, spare, dest, source);
#    }
#}
 
.data
    #n: .word 5
    prompt: .asciiz "Please enter an integer: "
    printDisk: .asciiz "Disk moved from "
    printTo: .asciiz " to "
    newLine: .asciiz "\n"
    
.text
    main:
         #print out a string to the screen using syscall with $v0 set to be 4
         la $a0, prompt
         li $v0, 4
         syscall
         
         #read an integer from keyboard 
         li $v0, 5
         syscall
         
         move $a0, $v0  #put the input integer into $a0, the input parameter for fact
         
         #storing values in arguments
         addi $a1, $zero, 1 
         addi $a2, $zero, 3
         addi $a3, $zero, 2
         
         jal moveTower
         
         #return to the operating system
         li $v0, 10
         syscall
         
    moveTower:
    
    	 #adjust stack for 5 items
    	 addi, $sp, $sp, -20
    	 
    	 #save registers for later use
    	 sw $ra, 16($sp)
    	 sw $a0, 12($sp)
    	 sw $a1, 8($sp)
    	 sw $a2, 4($sp)
    	 sw $a3, 0($sp)
    	 
    	 #branch to else $a0 does not = 1 	 
    	 bne $a0, 1, else
    	 
    	 #print out a string to the screen using syscall with $v0 set to be 4
         la $a0, printDisk
         li $v0, 4
         syscall
    	 
    	 #print integer
    	 move $a0, $a1
         li $v0, 1
         syscall
    	 
         #print out a string to the screen using syscall with $v0 set to be 4
         la $a0, printTo
         li $v0, 4
         syscall
    	 
    	 #print integer
    	 move $a0, $a2
         li $v0, 1
         syscall
    	 
    	 #print out a string to the screen using syscall with $v0 set to be 4
         la $a0, newLine
         li $v0, 4
         syscall
    	 
    	 # restore registers for caller
    	 lw $a3, 0($sp)
    	 lw $a2, 4($sp)
    	 lw $a1, 8($sp)
    	 lw $a0, 12($sp)
    	 lw $ra, 16($sp)
    	 
    	 #adjust stack to delete items
    	 addi $sp, $sp, 20
    	 jr $ra

    	 
    else:
    	 
    	 #Disk - 1 and switch $a2 and $a3
    	 subi $a0, $a0, 1
    	 
    	 # necessary switching of arguments
    	 add $t0, $a3, $zero
    	 add $a3, $a2, $zero
    	 add $a2, $t0, $zero
    	 
    	 jal moveTower
    	 
    	 # restore register for caller
    	 lw $a3, 0($sp)
    	 lw $a2, 4($sp)
    	 lw $a1, 8($sp)
    	 lw $a0, 12($sp)
    	 lw $ra, 16($sp)
    	 
    	 # adjust stack to delete items
    	 addi $sp, $sp, 20  	 
    	 
    	 #store $a0's value in $t1
    	 add $t1, $a0, $zero
    	 
    	 #print out a string to the screen using syscall with $v0 set to be 4
         la $a0, printDisk
         li $v0, 4
         syscall
    	 
    	 #print integer
    	 move $a0, $a1
         li $v0, 1
         syscall
    	 
         #print out a string to the screen using syscall with $v0 set to be 4
         la $a0, printTo
         li $v0, 4
         syscall
    	 
    	 #print integer
    	 move $a0, $a2
         li $v0, 1
         syscall
    	 
    	 #print out a string to the screen using syscall with $v0 set to be 4
         la $a0, newLine
         li $v0, 4
         syscall
    	 
         #$a0 to disk - 1
    	 add $a0, $t1, $zero
    
    	 #adjust stack for 5 items
    	 addi, $sp, $sp, -20
    	 
    	 #save registers for later use
    	 sw $ra, 16($sp)
    	 sw $a0, 12($sp)
    	 sw $a1, 8($sp)
    	 sw $a2, 4($sp)
    	 sw $a3, 0($sp)
    	 	 
    	 	 
    	 subi $a0, $a0, 1
    	 	 	 	 
    	 #Switch $a1 and $a3
    	 add $t0, $a3, $zero
    	 add $a3, $a1, $zero
    	 add $a1, $t0, $zero
    	 
    	   	 
    	 jal moveTower
    	 
	 # restore registers for caller
    	 lw $a3, 0($sp)
    	 lw $a2, 4($sp)
    	 lw $a1, 8($sp)
    	 lw $a0, 12($sp)
    	 lw $ra, 16($sp)
    	 
    	 #adjust stack to delete items
    	 addi $sp, $sp, 20
    	 jr $ra
    	 
