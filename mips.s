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

  
