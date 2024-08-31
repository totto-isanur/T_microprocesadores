;convertit dos numero hex a bcd par aluego sumarlos
	.org 0000h
	ld b, ABh; se asignan los valores en los registros b y c
	ld c, cdh
;movemos el contenido de los registros para manipularlos mas facil
	ld a,b
	ld e,c
	and 0x0f;separando los bits menos y mas significantes
	ld c,a
	ld a,b
	and 0xf0
	ld b,a
	ld a,e;separando los datos del segundo numero
	and 0xf0
	ld d,a
	ld a,e
	and 0x0f
	ld e,a
