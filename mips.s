.data
prompt:         .asciiz "Enter a string: "
input_string:   .space 1001   #buffer
space_slash:        .asciiz " / "
dash:           .asciiz "-"


.text
main:
  # Prompt user for input
    li $v0, 4
    la $a0, prompt
    syscall

    # Read user input into input_string
    li $v0, 8
    la $a0, input_string
    li $a1, 1000
    syscall

     #call process_whole_string
     jal process_whole_string

     #Exit program 
     li $v0, 10
     syscall


process_whole_string:
    li $s0, 0     #index for substring 
    whole_string_loop: 
        lb $t2, 0($a0)
        beq $t2, $0, end_whole_string

        bne $t2, 47, slash_found #checks if character is a forward slash

        sb $t2, 0($s0)  #store the character into string beuffer
        sub $sp, $sp, 4 #make space is stack
        sw $a0, 0($sp)

        jal process_substring
        
        lw $a0, 0($sp) #resotore substring
        add $sp, $sp, -4

        j print_sum

        found_slash:
          addi $a0, $a0, 1  #move to the next character in the input string 
          j whole_string_loop
          
    print_sum: 
        # Print the sum
        li $v0, 1
        move $a0, $v0
        syscall
   
        li $v0, 4
        la $a0, space_slash
        syscall

        j whole_string_loop

end_whole_string:
  jr $ra


process_substring: 
    move $t6, $t2
    li $t8, 0 #sum 
    
    substring_loop:
      lb $t7, 0($t6) # load 
      beqz $t7, print_result   # If null terminator is encountered, print the result
    

      blt $t7, $t1, not_valid  # If the character is not a digit, go to not_valid
      bgt $t7, $t0, not_digit
    

        
     
  
  
