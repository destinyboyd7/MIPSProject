.data
prompt:         .asciiz "Enter a string: "
input_string:   .space 1001   #buffer
newline:        .asciiz " / "
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


process_whole_strinng:
     move $t1, $a0

    whole_string_loop: 
        lb $t2, 0($t1)
        beq $t2, $0, end_whole_string

        
     
  
  
