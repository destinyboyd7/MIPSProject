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
    move $t1, $a0
    
    whole_string_loop: 
        lb $t7, 0($t1)
        beq $t2, $0, end_whole_string

        beq $t2, 47, slash_found #checks if character is a forward slash

        jal process_substring

        lw $a0, 0($sp)
        addi $sp, $sp, -4 
        
        j print_sum

      slash_found:
        addi $a0, $a0, 1  #move to the next character in the input string 
        j whole_string_loop
          
    print_sum: 
        # Print the sum

        beq $t8, 0, print_dash

        li $v0, 1
        move $a0, $t8
        syscall
        
        li $v0, 4
        la $a0, space_slash
        syscall

        beq $t2, $0, end_whole_string
        j whole_string_loop
    
    print_dash: 
          li $v0, 4
          la $t8, dash
          j print_sum


end_whole_string:
  jr $ra


process_substring: 
    move $t6, $t2
    li $t8, 0 #sum 
    
    substring_loop:
      lb $t7, 0($t6) # load 
      beq $t7, $0, process_substring   # If null terminator is encountered, print the result
      
      blt $t7, 48, not_valid
      bgt $t7, 122, not_valid

      bgt $t7, 48, check_digit

      
      check_digit: 
        blt $t7, 48, not_valid  # If the character is not a digit, go to not_valid
        bgt $t7, 57, not_digit

        # Convert ASCII digit to integer and update sum
        sub $t7, $t7, 48
        add $t8, $t8, $t7

        # Move to the next character in the input string
        addi $t6, $t6, 1
        j substring_loop

      not_digit: 
        blt $t7, 65, not_valid
        bgt $t7, 90, is_lower
    
        sub $t7, $t7, 65
        add $t7, $t7, 10
        add $t8, $t8, $t7

        # Move to the next character in the input string
        addi $t6, $t6, 1
        j substring_loop

      is_lower:
        blt $t7, 97, not_valid
        bgt $t7, 122, not_valid
    
        sub $t7, $t7, 97
        add $t7, $t7, 10
        add $t8, $t8, $t7

        # Move to the next character in the input string
        addi $t6, $t6, 1
        j substring_loop

    not_valid:
      # Print an error message for invalid input
      add $t8, $t7, 0 
      
      jr $ra

    move $v0, $t8
    jr $ra


