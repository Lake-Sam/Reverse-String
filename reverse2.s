.global _start


_start:
        MOV R7, #4              @These five lines print to prompt
        MOV R0, #1
        MOV R2, #42
        LDR R1, =prompt
        SWI 0



read:
        MOV R7, #3              @These 5 lines read 255 characters
        MOV R0, #0              @from the keyboard
        MOV R2, #255
        LDR R1, =string
        SWI 0
        MOV R4, #0              @index for array
        MOV R5, #0              @index for output array

	LDR R6, =gnirts

length:
        LDRB R8, [R1, R4]
	CMP R8, #0
	BEQ reverse
	ADD R4, R4, #1
	B length

reverse:
	SUB R4, R4, #1
	LDRB R8, [R1, R4]
	STRB R8, [R6, R5]
	CMP R4, #0
	BEQ write
	ADD R5, R5, #1
	B reverse


write:
	ADD R5, R5, #1
	LDRB R8, [R1, R5]
	STRB R8, [R6, R5]
        MOV R7, #4
        MOV R0, #1
        MOV R2, #255
        LDR R1, =gnirts
        SWI 0

newline:
	MOV R0, #1
	MOV R2, #1
	MOV R7, #4
	LDR R1, =newlinechar
	SWI 0

end:
        MOV R7, #1
        SWI 0

.data


prompt: .ascii "Please enter a string up to 32 characters:"

gnirts: .space 256

string: .space 256
 
newlinechar: .byte '\n'

