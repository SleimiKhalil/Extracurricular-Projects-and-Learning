// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

(LOOP)
	@FILL		//Forever fill the screen, but with what??
	0;JMP
@LOOP
0;JMP

(FILL)
	@SCREEN
	D=M
	@WORDCURSOR
	M=D
	(LOOPSCREEN)		//WORDCURSOR=SCREEN
		@WORDCURSOR
		D=M
		@KBD
		D=D-M		//CURSOR-KBD (addresses)
		@LOOPSCREENEND
		D;JGE		//if (CURSOR-KBD>=0) end screen iteration that is screen memory ended
		
		// INNER LOOP BIT BY BIT ACCESS
		
		@BITCURSOR
		M=0		//BITCURSOR=WORDCURSOR
		(LOOPWORD)
			
			@BITCURSOR
			D=M
			@ISWORDENDED
			@15
			D=D-A		//B-15
			@LOOPWORDEND
			D;JGT			//if bit iterated entirely over word

			@FILLBIT
			0;JMP
			(AFTERFILL)
			@BITCURSOR
			M=M+1		//Next BIT

			@LOOPWORD
			0;JMP
		(LOOPWORDEND)
		// ----------------------------

		@WORDCURSOR
		M=M+1		//Next word 
		
		@LOOPSCREEN
		0;JMP
	(LOOPSCREENEND)
	@LOOP
	0;JMP		//After filling the screen recheck if key is still pressed

(FILLBIT)
	@BITCURSOR //the pixel //I was changing the cursor bit!!
	D=M		//BITCURSOR
	@PIXEL
	A=D		//RAM[BITCURSOR]=-1
	M=-1
	@AFTERFILL
	0;JMP

(FILLBIT1)
	@KBD
	D=M
	@ZERO
	D;JEQ			//How does it work with multibits??
	@MINUSONE
	0;JMP
	(ZERO)
		@KEY
		M=0
		@AFTER
		0;JMP
	(MINUSONE)
		@KEY
		M=-1
	(AFTER)		//Key= 0 or -1 (in M)
	
	@BITCURSOR //the pixel //I was changing the cursor bit!!
	D=M
	@PIXEL
	A=D
	@KEY
	D=M
	@PIXEL
	M=D		//PIXEL now have 0 or -1 (according to key)	
	// Now we actually access that pixel
	@AFTERFILL
	0;JMP
