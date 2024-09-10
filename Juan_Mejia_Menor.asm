.data
prompt1: .asciiz "Ingrese la cantidad de numeros a comparar, debe ser entre 3 y 5 numeros: "
prompt2: .asciiz "Ingrese un numero: "
result:  .asciiz "El numero menor es: "
error_message: .asciiz "La cantidad de numeros no es correcta. Debe ser entre 3 y 5 numeros."

.text
main:
    # Mostrar mensaje para ingresar la cantidad de números
    li $v0, 4              
    la $a0, prompt1        
    syscall

    # Leer la cantidad de números
    li $v0, 5             
    syscall
    move $t0, $v0          # Guardar la cantidad de números en $t0

    # Verificar que la cantidad esté entre 3 y 5
    li $t1, 3
    blt $t0, $t1, error
    li $t1, 5
    bgt $t0, $t1, error

    # Inicializar variables
    li $t2, 0              # Contador de números leídos
    li $t3, 2147483647     # Inicializar el menor número con un valor grande
    li $t4, 0              # Registro para almacenar el número leído

read_numbers:
    # Mostrar mensaje para ingresar un número
    li $v0, 4             
    la $a0, prompt2        # Cargar la dirección del mensaje
    syscall

    # Leer el número
    li $v0, 5              
    syscall
    move $t4, $v0          # Almacenar el número leído en $t4

    # Comparar con el número menor actual
    ble $t4, $t3, update_min
    j next_number

update_min:
    move $t3, $t4          # Actualizar el número menor

next_number:
    addi $t2, $t2, 1       # Incrementar el contador
    bne $t2, $t0, read_numbers  # Repetir hasta leer todos los números

    # Mostrar el número menor
    li $v0, 4             
    la $a0, result        
    syscall

    li $v0, 1              
    move $a0, $t3          # Cargar el número menor en $a0
    syscall

    # Salir del programa
    li $v0, 10            
    syscall

error:
    li $v0, 4              # syscall para imprimir cadena
    la $a0, error_message  # Cargar la dirección del mensaje de error
    syscall

    li $v0, 10             # Salir del programa
    syscall

