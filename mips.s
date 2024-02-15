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
    li $t8, 0     #index for substring 
    whole_string_loop: 
        lb $t2, 0($a0)
        beq $t2, $0, end_whole_string

        bne $t2, 47, slash_found #checks if character is a forward slash

        sb $t2, 0(t8)  #store the character into string beuffer
        sub $sp, $sp, 4 
        sw $a0, 0($sp)

        jal process_substring

        lw $a0, 0($sp) 
        add $sp, $sp, -4
        
        addi $t2, $t2, 1
        addi $t8, $t8, 1

        found_slash:
          addi $a0, $a0, 1  #move to the next character in the input string 
          j whole_string_loop

    end:
        no_slash
        j next_char

        
     
  
  
