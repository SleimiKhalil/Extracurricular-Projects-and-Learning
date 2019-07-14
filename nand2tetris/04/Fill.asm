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
	D=A
	@wordcursor
	M=D
	(LOOPSCREEN)		//WORDCURSOR=SCREEN
		@wordcursor
		D=M
		@KBD
		D=D-A		//CURSOR-KBD (addresses)
		@LOOPSCREENEND
		D;JGE		//if (CURSOR-KBD>=0) end screen iteration that is screen memory ended
		
		// INNER LOOP BIT BY BIT ACCESS
		

		@FILLBIT
		0;JMP
		(AFTERFILL)

		// ----------------------------

		@wordcursor
		M=M+1		//Next word 
		
		@LOOPSCREEN
		0;JMP
	(LOOPSCREENEND)
	@LOOP
	0;JMP		//After filling the screen recheck if key is still pressed


(BLACK)
	@wordcursor
		//RAM[WORDCURSOR]=-1  //Does it understand it as 111111111111111
	D=M
	@pixel
	A=D
	M=-1
	@O2
	0;JMP

(WHITE)
	@wordcursor
		//RAM[WORDCURSOR]=-1  //Does it understand it as 111111111111111
	D=M
	@pixel
	A=D
	M=0
	@O1
	0;JMP

(FILLBIT)

	@KBD
	D=M
	@ZERO
	D;JEQ			//How does it work with multibits??
	@MINUSONE
	0;JMP
	(ZERO)
		@WHITE
		0;JMP
		(O1)
		@AFTER
		0;JMP
	(MINUSONE)
		@BLACK
		0;JMP
		(O2)
	(AFTER)		//Key= 0 or -1 (in M)	

	@AFTERFILL
	0;JMP
//Here is what's happening, it now responds to keyboards but actually, if you remove the key midway filling it doesn't stop, it fills it with white. WEIRD!!!! It is not, if you press key now, and if now the screen is midway filling, the filling will happen next time, it's actually, the filling will change!! But I like it, and it works. (it could have been done in the other way, that is, if no key fill white, if key fill black. By the way mine is, it is filling, if you press key, the subsequent filling will be black otherwise white, so due to presses you can have a mosaic!)
//(FILLBIT1)
//	@KBD
//	D=M
//	@ZERO
//	D;JEQ			//How does it work with multibits??
//	@MINUSONE
//	0;JMP
//	(ZERO)
//		@KEY
//		M=0
//		@AFTER
//		0;JMP
//	(MINUSONE)
//		@KEY
//		M=-1
//	(AFTER)		//Key= 0 or -1 (in M)
//	
//	@BITCURSOR //the pixel //I was changing the cursor bit!!
//	D=M
//	@PIXEL
//	A=D
//	@KEY
//	D=M
//	@PIXEL
//	M=D		//PIXEL now have 0 or -1 (according to key)	
//	// Now we actually access that pixel
//	@AFTERFILL
//	0;JMP
//
