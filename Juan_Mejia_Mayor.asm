.data
prompt1: .asciiz "Ingrese la cantidad de numeros a comparar.Debe ser entre 3 y 5 numeros.: "
prompt2: .asciiz "Ingrese un numero: "
result:  .asciiz "El numero mayor es: "

.text
main:
    # Mostrar mensaje para ingresar la cantidad de números
    li $v0, 4              
    la $a0, prompt1        
    syscall

    # Leer la cantidad de números
    li $v0, 5              
    syscall
    move $t0, $v0         

    # Verificar que la cantidad esté entre 3 y 5
    li $t1, 3
    blt $t0, $t1, error
    li $t1, 5
    bgt $t0, $t1, error

    # Leer números y encontrar el mayor
    li $t2, 0              
    li $t3, -2147483648   
    li $t4, 0             

read_numbers:
    # Mostrar mensaje para ingresar un número
    li $v0, 4             
    la $a0, prompt2       
    syscall

    # Leer el número
    li $v0, 5              
    syscall
    move $t4, $v0          

    # Comparar con el número mayor actual
    bge $t4, $t3, update_max
    j next_number

update_max:
    move $t3, $t4          

next_number:
    addi $t2, $t2, 1      
    bne $t2, $t0, read_numbers  # repetir hasta leer todos los números

    # Mostrar el número mayor
    li $v0, 4              
    la $a0, result        
    syscall

    li $v0, 1             
    move $a0, $t3          
    syscall

    # Salir del programa
    li $v0, 10             
    syscall

error:
    li $v0, 4              
    la $a0, error_message  
    syscall

    li $v0, 10            
    syscall

.data
error_message: .asciiz "La cantidad de numeros no es valida. Debe estar entre 3 y 5."
