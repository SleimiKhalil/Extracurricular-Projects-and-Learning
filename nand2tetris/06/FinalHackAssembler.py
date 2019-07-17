#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jul 15 14:33:56 2019

@author: khalilsleimi
    
    Notation: ** A raw assembly file is a (*.asm) with comments(single line and multiline) and empty lines, and spaces in actual commands (we suppose a command per line at most)
              ** A Clean Assembly file is a (Clean_*.asm) containing no comments or empty lines or spaces, just one command per line
              ** A Translatable file is a (Translatable_*.asm) with no labels or symbolic variables, just known memory locations and instructions locations
              ** A Translatable Command is a string that can be taken from a line of a Translatable file (that is satisfying its' same conditions)
              ** A Hack Machine Language Command is a command that can be executed on the Hack computer
"""


def CleanAssembly(FileName, CleanFileName):
    """
        Input: Takes in a raw assembly file FileName (given by its name: a string).
               Takes a Clean Assembly file (given by its name: a string). 
        Output: Produce a Clean Assembly File. Saved in CleanFileName
        Purpose: Strip all comments, empty lines and spaces from the file. Leaving only one command per line. Save result in file specified by CleanFileName
    """
    ToClean = open(FileName, 'r')
    SaveIn = open(CleanFileName, 'w')
    SaveInList = []
    LinesToClean = ToClean.readlines()
    for line in LinesToClean:
        if line[0:2] != "//" and line!="" and line!="\n":  #a random amount of spaces and returns and multiline comments
            
            SaveInList.append(ExtractCommand(line))
    print(SaveInList[-1])
    SaveInList[-1]=SaveInList[-1][:-1]
    #SaveInList.append("\n")
    SaveIn.writelines(SaveInList)
    ToClean.close()
    SaveIn.close()
    "for now just a simple Comments handlers"

def ExtractCommand(line):
    """
        Input: a line that might contain a command and some comment
        Output: the command itself
        Purpose: extract the command from all the giberish, if none is found return nothing
    """
    result=""
    line=line.lstrip()
    line=line[:line.find("//")]
    line=line.rstrip()
    line+='\n'
    return line



def TranslatableAssembly(CleanFileName, TranslatableFileName):
    """
        Input: Takes a Clean Assembly file (given by its name: a string). 
               Takes a TranslatableFileName  (given by its name: a string).
        Output: Produce a Translatable Assembly file. Saved in TranslatableFileName
        Purpose: Replace all labels with corresponding instruction number and variables with corresponding memory addresses. Save result in file specified by TranslatableFileName
        I assume there are no bad lines of code
    """
    dictio={"R0":0, "R1":1, "R2":2, "R3":3, "R4":4, "R5":5, "R6":6, "R7":7,
            "R8":8, "R9":9, "R10":10, "R11":11, "R12":12, "R13":13, "R14":14, 
            "R15":15, "SCREEN":2**14, "KBD":3*2**13, "SP":0, "LCL":1, "ARG":2,
            "THIS":3, "THAT":4}
    
    lineCount=0
    ToTranslatable = open(CleanFileName, 'r')
    SaveIn = open(TranslatableFileName, 'w')
    SaveInList = []
    #What if a label is defined after being used the first time?? We deal with that!
    LinesToTranslatable = ToTranslatable.readlines()
    #print(LinesToTranslatable)
    for line in LinesToTranslatable:  #Catch all labels to avoid handling a label before its' definition
        if line[0]=="(" and line[-2]==")":  #Because line[-1]=="\n"
            dictio[line[1:-2]]=lineCount  #If it is 0 it'll get 0   
            lineCount-=1        #Remember, labels definitions aren't translated, they point to next line
            #SaveInList.append("@"+str(dict[line[1:]])) #If it is a label we don't put it
        lineCount+=1
        
    varcount=16
    #print(dictio)
    for line in LinesToTranslatable:        #Does it loop this one as well?
        if line[0]!='(' and line[-1]!=')':
            if line[0]=="@":
                #Deal with variable or label usage
                try:
                    int(line[1:]) 
                    SaveInList.append(line) #If it's a number then just put it! we don't need to do anything
                    #SaveInList.append("\n")
                except ValueError:  #if it is not a number It'll raise a ValueError. If it's not a number, it's a variable (or label)
                    if line[1:-1] not in dictio: #By default only labels are here, so if a variable is not already here, then add it // line[1:-1] to avoid "@" and "\n"
                        dictio[line[1:-1]]=varcount
                        varcount+=1              #An extra variable
                    SaveInList.append("@"+str(dictio[line[1:-1]])+"\n")
            else:
            #Just put it in Translatable File It is OK, it is just a simple instruction.
                SaveInList.append(line)
    #This particular design is very good, it avoids mixing up the search for labels and the search for variables, it saves some memory, but it takes the same amount of time!! remember you need to know labels before you begin replacing them so there's always 2 for loops
    #print(dictio)
    #print(SaveInList)
    #SaveInList.append("\n")
    SaveInList[-1]=SaveInList[-1][:]+"\n"
    SaveIn.writelines(SaveInList)
    ToTranslatable.close()
    SaveIn.close()
    return

def AssembleToHackMachine(TranslatableFileName, HackFileName):
    """
        Input:  Takes a TranslatableFileName (given by its name: a string).
                Takes a HackFileName file (given by its name: a string).
        Output: Produce a file in the Hack Machine language (*.hack). Saved in HackFileName
        Purpose: Translate the Translatable Assembly file into the Hack Machine Language. Save result in file specified by HackFileName
    """
    ToTranslate = open(TranslatableFileName, 'r')
    SaveIn = open(HackFileName, 'w')
    LinesToTranslate = ToTranslate.readlines()  #is there a yield here to be efficient?
    SaveInList = []
    for line in LinesToTranslate:
        SaveInList.append(TranslateCommand(line[:-1]))        #Write the translation of the Program line by line into HackFileName #Avoid giving the \n
    #SaveInList.append("\n")
    print(SaveInList)
    print(LinesToTranslate)
    SaveIn.writelines(SaveInList)
    ToTranslate.close()
    SaveIn.close()
    return

def TranslateCommand(Command):
    """
        Input: Takes a Translatable Command
        Output: Produce a Hack Machine Language Command
        Purpose: Translate given command to corresponding Hack Machine Language Command
    """
    result=''
    
    if Command[0]=='@':
        result=str(bin(int(Command[1:])))[2:].zfill(16)  #@Value remember, bin returns string already but how to specify its minimum length, 16 bit command, It is never negative
    else:

        destIndex=Command.find("=")
        jumpIndex=Command.find(";")
        if destIndex != -1:#It actually exists
            dest=Command[:destIndex]
        else:
            dest = ""
        if jumpIndex != -1:
            jump=Command[jumpIndex+1:]
        else:
            jump = ""
        comm=Command[destIndex+1: len(Command) if jumpIndex == -1 else jumpIndex] #if either inexistant: 0 to -1!!
        #use dest, jump and comm to do your work!
        #*AorM
        AorM="0"
        if "M" in comm:
            AorM = '1'
        else:
            AorM = '0'
        
        #*ComToFun see what is to be computed
        ComToFun="000000"
        if comm == "0":
            ComToFun="101010"
        elif comm == "1":
            ComToFun="111111"
        elif comm == "-1":
            ComToFun="111010"
        elif comm == "D":
            ComToFun="001100"
        elif comm == "A" or comm == "M":
            ComToFun="110000"
        elif comm == "!D":
            ComToFun="001101"
        elif comm == "!A" or comm == "!M":
            ComToFun="110001"
        elif comm == "-D":
            ComToFun="001111"
        elif comm == "-A" or comm == "-M":
            ComToFun="110011"
        elif comm == "D+1" or comm == "1+D":
            ComToFun="011111"
        elif comm == "A+1" or comm == "M+1" or comm == "1+A" or comm == "1+M":
            ComToFun="110111"
        elif comm == "D-1":
            ComToFun="001110"
        elif comm == "A-1" or comm == "M-1":
            ComToFun="110010"
        elif comm == "D+A" or comm == "D+M" or comm == "A+D" or comm == "M+D":
            ComToFun="000010"
        elif comm == "D-A" or comm == "D-M":
            ComToFun="010011"
        elif comm == "A-D" or comm == "M-D":
            ComToFun="000111"
        elif comm == "D&A" or comm == "D&M" or comm == "A&D" or comm == "M&D":
            ComToFun="000000"
        elif comm == "D|A" or comm == "D|M" or comm == "A|D" or comm == "M|D":
            ComToFun="010101"
        
        
        
        #*Destination
        toA="0"
        toM="0"
        toD="0"  #0 unless other notice
        Destination="000"
        for c in dest:
            if c == "A":   #Is there switch case capabilities
                toA = "1"
            elif c== "M":
                toM = "1"
            elif c == "D":
                toD = "1"
        Destination=toA+toD+toM
        
        #*Jum 
        Jum="000"
        if jump=="JGT":
            Jum="001"
        elif jump=="JEQ":
            Jum="010"
        elif jump=="JGE":
            Jum="011"
        elif jump=="JLT":
            Jum="100"
        elif jump=="JNE":
            Jum="101"
        elif jump=="JLE":
            Jum="110"
        elif jump=="JMP":
            Jum="111"
        
        result="111"+AorM+ComToFun+Destination+Jum
        
    result=result+"\n"
    return result
        
        

def TranslateCleanToHack():
    File = "RectL.asm"
    Path = "rect/"
    FileName = Path + File
    CleanFileName = Path + "Clean" + File
    TranslatableFileName = Path + "Translatable" + File
    HackFileName = Path + File[:-3] + "hack"
    CleanAssembly(FileName, CleanFileName)
    TranslatableAssembly(CleanFileName, TranslatableFileName)
    AssembleToHackMachine(TranslatableFileName, HackFileName)
    
TranslateCleanToHack()