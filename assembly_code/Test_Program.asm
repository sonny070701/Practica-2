##Programa para resolver las torres de Hanoi
##Equipo 
##Integrantes: Sonny Dominique Ceja Celis & Juan Pablo García Pérez

.eqv discos 3 ## Cant. de discos para la torre inicial, debe ser mayor o igual a 5
.data
.text

main:
addi s0, zero, discos	## Se asigna a s0 la cantidad de discos iniciales 
add a0, zero, s0	## usaremos t0 como auxiliar para la función
			## Usaremos S1 para la cantidad de movimientos totales 
jal ra, colocar_memoria
lui a1, 0x10010 ## marcador para inicio de memoria
add a1,a1,t3 ##primera torre con espacio que se obtuvo en t3
lui a2, 0x10010 ## marcador para inicio de memoria torre 
add a2,a2,t4 # Hacemos la segundatorre con la diferencia de cant. de discos torre 2
lui a3, 0x10010 ## marcador para inicio de memoria
add a3,a3,t4 # Hacemos la segundatorre con la diferencia de cant. de discos
add a3,a3,t4 # Hacemos la segundatorre con la diferencia del doble de cant. de discos
addi s4, zero, 1 # posición disco 
addi s5, zero,2 #auxiliar
addi s6, zero, 3 ## posición a la que va
addi s7, zero,0	## la usaremos para mover datos a memoria
addi s8, zero,0 ## lo usaremos para cargar 0 cuando retiremos discos
addi t3, zero,1 #valor comparación 
addi t4, zero,2 #valor comparación
addi t5, zero,3 #valor comparación
jal ra,mover_disco	##saltamos a ejecutar código para las torres

jal zero, end

##inicalizar torres 

mover_disco:
addi sp, sp, -20 #reducir en uno el stack
sw ra , 0(sp)	#guardar return address
sw s4, 4(sp)		#guardar el valor s4 - origen
sw s5, 8(sp)		#guardar el valor s5 - aux
sw s6, 12(sp)		#guardar el valor s6 - destino
sw a0, 16(sp)		#guardar cant. discos
addi t6,zero,1		# valor para comparación
addi t1,zero,0		# se establece en 0 default si es que al compárar hay discos, cambia 
blt a0,t6, change      # si cantidad de discos es menor a valor de comparacion 

regreso:
bne t1,t6,mover_disco_recursivo #si t1 no es igual a valor de comparacion 
jal zero, data #vamos a data

mover_disco_recursivo: ##parte recursiva torres
lw s4, 4(sp)		#guardar el valor s4 - origen en origen
lw s6, 8(sp)		#guardar el valor s5 - aux en destino
lw s5, 12(sp)		#guardar el valor s6 - destino en aux 
lw a0, 16(sp)		#guardar cant. discos	
addi a0,a0,-1		#-1 a auxiliar
	
jal ra, mover_disco

## Codigo mover disco 

beq s4, t3, torre1 #si posicion de disco es igual a 1
beq s4, t4, torre2 #si posicion de disco es igual a 2
beq s4, t5, torre3 #si posicion de disco es igual a 3

torre1:
beq s5, t5, op13 ## mover disco superior torre 1 a 2
lw s7, 0(a1)	#cargar valor a registro para pasarlo a memoria
sw s8, 0(a1)	#dejar en 0
addi a1,a1,-4   #quita un espacio a torre 1
sw s7, 0(a2)    #guarda el valor en torre 2
addi a2,a2,4    #recorre un espacio en torre 2 y agrega 
beq s8, zero, continue

op13:lw s7, 0(a1) ##mover disco superior torre 1 a 3
sw s8, 0(a1)	#dejar en 0
addi a1,a1,-4   #memoria inicial se resta 4
sw s7, 0(a3)	#cargar valor a registro para pasarlo a memoria
addi a3,a3,4    # se recorre 4 bytes en memoria 
beq s8, zero, continue

torre2:
beq s5, t5, op23 ## mover disco superior torre 2 a 1
addi a2,a2,-4    #decrementamos un espacio a torre 2
lw s7, 0(a2)	#cargar valor a registro para pasarlo a memoria
sw s8, 0(a2)	#dejar en 0
addi a1,a1,4    #agregamos un espacio a torre 1
sw s7, 0(a1)    #guardamos en torre 1
addi a1,a1,-4   #decrementamos espacio en torre 1
addi a1,a1,4    #agregamos espacio a torre 1
beq s8, zero, continue

op23:	## mover disco superior torre 2 a 3
addi a2,a2,-4  #decrementamos espacio a torre 2
lw s7, 0(a2)	#cargar valor a registro para pasarlo a memoria
sw s8, 0(a2)	#dejar en 0
sw s7, 0(a3)    #lo guardamos a torre 3
addi a3,a3,4   #agregamos espacio en torre 3
beq s8, zero, continue

torre3:
beq s5, t4, op32 #si s5 es sigual al valor de comparacion
addi a3,a3,-4 
lw s7, 0(a3)	## mover disco superior torre 3 a 1 #cargar valor a registro para pasarlo a memoria
sw s8, 0(a3)	#dejar en 0
addi a1,a1,4	#aumentar valor de la torre
sw s7, 0(a1)    #guardamos en torre 1
addi a1,a1,-4   #dcrementamos en torre 1
addi a1,a1,4    #agregamos numero en torre 1
beq s8, zero, continue

op32:		## mover disco superior torre 3 a 2
addi a3,a3,-4   ## decrementa un espacio de la torre 3
lw s7, 0(a3)	#cargar valor a registro para pasarlo a memoria
sw s8, 0(a3)	#dejar en 0
sw s7, 0(a2)	# cagragr a memoria el valor
addi a2,a2,4	#aumentar valor torre
beq s8, zero, continue

continue: lw s5, 4(sp)		#guardar el valor s4 - origen
lw s4, 8(sp)		#guardar el valor s5 - aux
lw s6, 12(sp)		#guardar el valor s6 - destino
lw a0, 16(sp)		#guardar cant. discos
addi a0,a0,-1		#decrementar disco
jal ra,mover_disco	#regresar a funcion
	

data:lw ra , 0(sp)	#guardar return address
lw s4, 4(sp)		#guardar el valor s4 - origen en origen
lw s5, 8(sp)		#guardar el valor s5 - aux en destino
lw s6, 12(sp)		#guardar el valor s6 - destino en aux 
lw a0, 16(sp)		#guardar cant. discos	
addi sp, sp, 20		#aumentar stack
jalr zero, ra, 0	#regresar

colocar_memoria: add t0,zero,a0 ## inicializar la memoria inicial
lui t0, 0x10010 ## marcador para inicio de memoria 
add t1, s0,zero ## parametro de numero de disco a variable temporal
addi, t2,zero,0## parametro para comparar en ciclo
ciclo:	sw t1, 0(t0) # ciclo para cargar disco en memoria y variables utiles 
	addi t1, t1,-1 #para restar -1 a los discos al colocarlo
	addi t0, t0,4 #agrega disco
	addi t3,t3,4 #guardamos 4 bytes
	addi t4, t4,4 #guardamos 4 bytes
bne t1,t2 ciclo #ciclo condición
addi t3,t3,-4 #restar 1 a variable que nos ayudará a saber tamano torre 1
jalr zero, ra,0 # regresar 

change:
addi t1,zero,1	#cambiar parametro operativo
bne a1,zero, regreso#regresar al programa 

end:	#fin programa