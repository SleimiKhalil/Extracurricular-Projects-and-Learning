// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.


@sum
M=0		//sum=0

@i
M=0		//i=0


@R0
D=M
@n
M=D		//n=RAM[0]

@R1
D=M
@m
M=D		//m=RAM[1]

//while i<=n
//  sum+=m
//  i++
(LOOP)
	@i
	D=M
	@n
	D=D-M		//i-n
	@STOP
	D;JGE		//if i-n>=0 GOTO STOP

	@m
	D=M		//m
	@sum
	M=M+D		//sum=sum+D

	@i
	M=M+1

	@LOOP
	0;JMP

(STOP)
	@sum
	D=M
	@R2
	M=D		//R2=sum

(END)
	@END
	0;JMP
