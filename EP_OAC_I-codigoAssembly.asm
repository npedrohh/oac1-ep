########## Codigo para entrega do EP de OAC I
########## Pedro Henrique Resnitzky Barbedo (14657691)
########## Aline (Eduardo) Crispim de Moraes (14567051)
.text
.globl main
main:
    li $v0, 5        		# syscall de scan int
    syscall
    move $a1, $v0      		# movimentacao do dado de v0 para a1
    li $a0, 8        		# preparacao do syscall de alocacao de 8 bits
    li $v0, 9        		# syscall de alocacao de 8 bits em v0
    syscall
    move $s0, $v0    		# movimentacao do array alocado em v0 para s0
    jal valor        		# jump and link pra funcao 'valor'
    lw $a0, 0($s0)    	 	# load em a0 do primeiro elemento do array s0 (resultado de F)
    li $v0, 1        		# syscall de print int
    syscall
    li $a0, 32        		# load imediato de 32 em a0, ASCII do caractere de espaco
    li $v0, 11       		# syscall de print char
    syscall
    lw $a0, 4($s0)    		# load em a0 do segundo elemento do array em s0 (resultado de G)
    li $v0, 1        		# syscall de print int
    syscall
    li $a0, 10        		# load imediato de 10 em a0, ASCII de nova linha
    li $v0, 11       		# syscall de print char
    syscall
    li $v0, 10        		# syscall de fim de execucao
    syscall 

valor:
    bgt $a1, 2, valor_maior    # branch se a1 > 2
    beq $a1, 1, valor_um       # branch se a1 == 1
    beq $a1, 2, valor_dois     # branch se a1 == 2

valor_um:
    li $t0, 2        		# load imediato de 2 em t0
    sw $t0, 0($s0)		# guarda o resultado de F no primeiro indice do array s0
    li $t0, 1        		# load imediato de 1 em t0
    sw $t0, 4($s0)		# guarda o resultado de G no segundo indice do array s0
    j valor_fim        		# jump para o fim da funcao

valor_dois:
    li $t0, 1        		# load imediato de 1 em t0
    sw $t0, 0($s0)		# guarda o resultado de F no primeiro indice do array s0
    li $t0, 2        		# load imediato de 2 em t0
    sw $t0, 4($s0)		# guarda o resultado de G no segundo indice do array s0
    j valor_fim        		# jump para o fim da funcao

valor_maior:			# funcao de inicializacao de pilha
    subu $sp, $sp, 16  		# abre 4 espacos na pilha
    li $t0, 2       		# load imediato de 2 em t0
    li $t1, 2        		# load imediato de 2 em t1
    li $t2, 1        		# load imediato de 1 em t2
    li $t3, 1        		# load imediato de 1 em t3

    sw $t3, 0($sp)        	# guarda t3 no inicio da pilha
    sw $t2, 4($sp)        	# guarda t2 no segundo espaco da pilha
    sw $t1, 8($sp)       	# guarda t1 no terceiro espaco da pilha
    sw $t0, 12($sp)       	# guarda t0 no quarto espaco da pilha

    li $a2, 3        		# load imediato de 3 em a2 (contador)
    move $a3, $a1		# movimento do dado de a1 para a3
    j valor_loop        	# jump funcao valor_loop
    
valor_loop:
    lw $t0, 0($sp)        	# load do topo da pilha em t0
    addu $sp, $sp, 4		# diminui a pilha em 1 elemento
    lw $t1, 0($sp)        	# load do topo da pilha em t1
    addu $sp, $sp, 4      	# diminui a pilha em 1 elemento
    mul $t2, $t0, 2        	# guarda o resultado da multiplicacao de (2 * t0) em t2
    addu $t2, $t2, $t1        	# guarda o resultado da adicao de (t2 + t1) em t2

    # t0 = f(n-1) / t2 = f(n)

    lw $t3, 0($sp)        	# load do topo da pilha em t3
    addu $sp, $sp, 4		# diminui a pilha em 1 elemento
    lw $t4, 0($sp)        	# load do topo da pilha em t4
    addu $sp, $sp, 4      	# diminui a pilha em 1 elemento
    mul $t5, $t4, 3      	# guarda o resultado da multiplicacao de (3 * t4) em t5
    addu $t5, $t5, $t3        	# guarda o resultado da adicao de (t5 + t3) em t5

    # t3 = g(n-1) / t5 = g(n) 

    subu $sp, $sp, 16       	# abre 4 espacos na pilha
    sw $t2, 0($sp)        	# guarda t2 no topo da pilha
    sw $t3, 4($sp)        	# guarda t2 no segundo espaco da pilha
    sw $t5, 8($sp)        	# guarda t2 no terceiro espaco da pilha
    sw $t0, 12($sp)        	# guarda t2 no quarto espaco da pilha

    addi $a2, $a2, 1        	# adicao de 1 ao contador

    ble $a2, $a3, valor_loop   # branch se a2 <= a3, caso verdadeiro, volta para valor_loop

    sw $t2, 0($s0)		# guarda o resultado de F no primeiro indice do array s0
    sw $t5, 4($s0)		# guarda o resultado de G no segundo indice do array s0

    j valor_fim       		# jump para o fim da função

valor_fim:
    jr $ra        		# jump register para o endereço de retorno
