;este codigo convierte don numeros hexadecimales a bcd ´para al final sumarlos
;los valores que arroja el codigo estan dados en bcd decimal
;por ejemplo 55H-->85BDC
;los valores de la primera cifra se encontraran en el registro BC
;los valores de la segunda cifra se encontraran en el registro DE
;el resultado de la suma se repartira por centena, decena y unidad; acomodado en A,H y L respectivamente
	.org 0000h
	;se ingresa los numeros a trabajar
	ld b, 63h
	ld c, 63h

	;guardamos los numeros en otras registros
	ld h,b
	ld l,c
	ld a,c

	;limpiamos o pones a cero los registros
	ld b,0
	ld c,0
	ld d,0

	;comenzamos la identificaion de los valores de uno de los numeros
Decenas:
	cp 10              ; Comparar a con 10 para determinar la decena del numero
	jr c,Unidades      ; Si a < 10 dirige a unidad
	sub 10             ; Restar 10 de a
	inc c              ; Incrementa c para poder poner un valor bdc en la decena
	jr Decenas         ; Se repite el proceso

	;se le a asignado el valor de la unidad
Unidades:
	ld d, a

	;se acomodan los registros para cumplir con especificaciones
acomodo:
	ld e,d
	ld d,c
	ld a,h
	ld b,0
	ld c,0
	ld h,0
	;se repiten lo anterior pero para el siguiente numero
Decena:
	cp 10
	jr c,Unidad
	sub 10
	inc c
	jr Decena

Unidad:
	ld h, a

acomodador:
	ld b,c
	ld c,h

;limpiar registros
	ld a,0
	ld h,0
	ld l,0

;suma de unidades
S_unidad:
	ld a,0
	ld a,c
	add a,e

;compara si el valor de la suma es mayor a 10
Compara_u:
	cp 10
	jr Reduccion
	ld l,a ;cuando a < 10 coloca el valor correspondiente a la unidad de la suma en l
	ld a,0
;cuendo a > 10, resta 10 y conserva un 1 para que sirva como acarrep¿o uy guarda el resultado
Reduccion:
	sub 10
	ld l,a
	ld a,1

;suma de decenas
S_decena:
	add a,b
	add a,d

;compara si el valor de la suma es mayor a 10
Compara_d:
	cp 10
	jr red
	ld h,a;cuando a < 10 coloca el valor correspondiente a la decena de la suma en h
	ld a,0

;cuendo a > 10, resta 10 y coloca un 1 en a y el resuktado de la resta se pone en el registro h
red:
	sub 10
	ld h,a
	ld a,1

	end
