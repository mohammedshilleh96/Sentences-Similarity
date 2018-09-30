;==============================================================================================;
; THIS IS THE PROJECT FOR THE ASSEMBLY LANGUAGE LAB IN BIRZEIT UNIVERSITY. SECOND SEMETER 2017 ;                                                                              
;     THE PURPOSE OF THE PROJECT IS TO CALCULATE THE SIMILARITY BETWEEN TWO SENTENCES.         ;                                                                                   
;                       THE INPUT SENTENCES ARE READ FROM A FILE.                              ;
;                                                                                              ;
; DONE BY:  MO'ATH SANDOUKA    1140950                                                         ;
;         & MOHAMMED SHILLEH   1140884                                                         ;
;==============================================================================================;

.MODEL SMALL
.STACK 200H                                                
.DATA                                                      


;================= DATA DEFINITIONS FOR READING FROM THE FILE =================================;
FILENAME         DB 0                                                                          ;
                                                                                               ;
FILE1NAME        DB "DATA1.txt", 0                                                             ;
FILE2NAME        DB "DATA2.txt", 0                                                             ;
                                                                                               ;
SENTENCE         DB 300 DUP('$')                                                               ;
                                                                                               ;
SENTENCE1        DB 300 DUP('$')                                                               ;
SENTENCE1_LENGTH DW  ?                                                                         ;
                                                                                               ;
SENTENCE2        DB 300 DUP('$')                                                               ;
SENTENCE2_LENGTH DW  ?                                                                         ;
                                                                                               ;
FHAND DW ?                                                                                     ;
;==============================================================================================;

;================= DATA DEFINITIONS FOR REMOVE_PUNC PROCEDURE =================================;                                                                                             
 PUNC  DB ?                                                                                    ;
;==============================================================================================;
   


;================= DATA DEFINITIONS FOR REMOVE_STOP_WORDS PROCEDURE ===========================; 
 STOP1 DB ?                                                                                    ;
 STOP2 DB ?                                                                                    ;
 STOP3 DB ?                                                                                    ;
 STOP4 DB ?                                                                                    ;
;==============================================================================================;



;================ DATA DEFINITIONS FOR REMOVE_DUPLICATE PROCEDURE =============================;
 WORDS DW ?                                                                                    ;
 EQUAL DB ?                                                                                    ;
 WORDS1 DW ?                                                                                   ;
 WORDS2 DW ?                                                                                   ;
 TWORDS DW ?                                                                                   ;
 DENOMINATOR DW 0                                                                              ;
 CONFIG DW 0                                                                                   ;
 RESULT_INT DB 0                                                                               ;
 RESULT_FLOATING DB 0                                                                          ;        
                                                                                               ;
 TEMP DB 50 DUP(0)                                                                             ;
 WORD_LENGTH  DW ?                                                                             ;
 WORD_LENGTH2 DW ?                                                                             ;
                                                                                               ;
 TEST_F DB 0                                                                                   ;
 COUNTER DW 0                                                                                  ;
                                                                                               ;
 FLAGS DB 100 DUP(0)                                                                           ;
;==============================================================================================; 

;============================= SOME EXTRA INTERFACE PHRASES ===================================;                                                                                             
INTRO1 DB "    THIS IS THE PROJECT FOR THE ASSEMBLY LANGUAGE LAB IN BIRZEIT UNIVERSITY.",'$'   ;
INTRO2 DB "         THE PURPOSE OF THE PROJECT IS TO CALCULATE THE SIMILARITY.",'$'            ;
INTRO3 DB "                          BETWEEN TWO SENTENCES.",'$'                               ;
INTRO4 DB "                 THE INPUT SENTENCES ARE READ FROM A FILE.",'$'                     ;
INTOO DB " ",'$'                                                                               ;
INTRO5 DB " DONE BY:  MO'ATH SANDOUKA    1140950",'$'                                          ;
INTRO6 DB "                 & MOHAMMED SHILLEH   1140884",'$'                                  ;
INTRO7 DB "                                                ENJOY :D :D", '$'                   ;
IN1 DB "  Sentence 1 after input from file:", '$'                                              ;
IN2 DB "  Sentence 2 after input from file:", '$'                                              ;
IN1P DB "  Sentence 1 after REMOVING PUNCTUATION & to LOWER CASE:", '$'                        ;
IN2P DB "  Sentence 2 after REMOVING PUNCTUATION & to LOWER CASE:", '$'                        ;
IN1S DB "  Sentence 1 after REMOVING STOP WORDS:", '$'                                         ;
IN2S DB "  Sentence 2 after REMOVING STOP WORDS:", '$'                                         ;
IN1D DB "  Sentence 1 after REMOVING DUPLICATIONS:", '$'                                       ;
IN2D DB "  Sentence 2 after REMOVING DUPLICATIONS:", '$'                                       ;
FIN1 DB "  Final form of Sentence 1:", '$'                                                     ;
FIN2 DB "  Final form of Sentence 2:", '$'                                                     ;
READIN DB "  READING Sentence 1", 10, 13, '$'                                                  ;
READIN2 DB "  READING Sentence 2", 10, 13, '$'                                                 ;
PRESS DB "                                        PRESS ANY KEY TO CONTINUE...",'$'            ;
PERCENT DB "THE SIMILARITY PERCINTAGE =  ",'$'                                                 ;
                                                                                               ;
;==============================================================================================;   

.CODE 

;ALWAYS START LIKE THIS
;======================
MOV AX , @DATA
MOV DS , AX
MOV ES , AX
           
;ALGORITHM:
;=========
;THIS PROJECT CONSIST OF 7 MAJOR STEPS:

;1) READ SENTENCE1 FROM FILE1

;2) REMOVE PUNCTUATION FROM SENTENCE1 

;3) REMOVE STOP WORDS FROM SENTENCE1

;4) MAKE ALL SENTENCE1 CHARACERS SMALL LETTER 

;5) REMOVE DUPLICATE WORDS IN SENTENCE1

;6) REPEAT STEP 1) & 2) & 3) & 4) & 5) FOR SENTENCE2  

;7) CALCULATE SIMILARITY BETWEERN SENTENCE1 & SENTENCE2 

;==============================================================================================;
;                                        I N T R O                                             ;
;==============================================================================================;
CALL INTRO 

;==============================================================================================;
;                                    SENTENCE --- 1                                            ;
;==============================================================================================;

;FIRST WE READ SENTENCE1 
;-----------------------
CALL NEW_LINE 
MOV DX, OFFSET READIN
CALL PRINT_STRING


LEA SI, FILE1NAME
LEA DI, FILENAME
MOV CX, 10
REP MOVSB

XOR AX, AX
CALL READFILE

LEA SI, SENTENCE
LEA DI, SENTENCE1
MOV CX, 300
REP MOVSB  
CLD
 
;------------------------------------
CALL NEW_LINE
CALL S1_AFTER_READ
LEA SI , SENTENCE1

CALL SENTENCE_LENGTH
MOV SENTENCE1_LENGTH, CX

;------------------------------------
CALL REMOVE_PUNC 
CALL TO_LOWER
CALL CONCAT
CALL S1_AFTER_PUNC_LOW 

;------------------------------------
CALL REMOVE_STOP_WORDS
CALL S1_AFTER_STOPW
CALL CONCAT
    
;------------------------------------
CALL REMOVE_DUPLICATE
MOV DI , OFFSET FLAGS
MOV SI , OFFSET SENTENCE1
CALL REMOVE_BY_FLAG     
CALL CONCAT
CALL S1_AFTER_DUP

;------------------------------------
MOV SI, OFFSET SENTENCE1
CALL FIND_NUMBER_OF_WORDS
MOV CX, WORDS
MOV WORDS1, CX

;------------------------------------
MOV CX, SENTENCE1_LENGTH 
CALL CONCAT  
CALL S1_FINAL

;------------------------------------    

           
;==============================================================================================;
;                                    SENTENCE --- 2                                            ;
;==============================================================================================; 

LEA SI, FILE2NAME
LEA DI, FILENAME
MOV CX, 10
REP MOVSB 

;INITIALIZE SENTENCE1 AND READ FILE
;----------------------------------
MOV AL, "$"
MOV DI, OFFSET SENTENCE
MOV CX, 300
L2334:
  STOSB
LOOP L2334 

CALL READFILE

LEA SI, SENTENCE
LEA DI, SENTENCE2
MOV CX, 300
REP MOVSB

CLD 

;------------------------------------ 
LEA SI , SENTENCE2 
CALL CLEAR_SCREEN
CALL NEW_LINE 

MOV DX, OFFSET READIN2
MOV AH, 09H
INT 21H 

CALL NEW_LINE
CALL S2_AFTER_READ
LEA SI , SENTENCE2

CALL SENTENCE_LENGTH
MOV SENTENCE2_LENGTH, CX
;------------------------------------
CALL REMOVE_PUNC 
CALL TO_LOWER
CALL CONCAT
CALL S2_AFTER_PUNC_LOW 

;------------------------------------
CALL REMOVE_STOP_WORDS
CALL S2_AFTER_STOPW
CALL CONCAT
    
;------------------------------------  
CALL EMPTY_FLAGS
CALL REMOVE_DUPLICATE
MOV DI , OFFSET FLAGS
MOV SI , OFFSET SENTENCE2
CALL REMOVE_BY_FLAG     
CALL CONCAT
CALL S2_AFTER_DUP

;------------------------------------
MOV SI, OFFSET SENTENCE2
CALL FIND_NUMBER_OF_WORDS

MOV CX, WORDS
MOV WORDS2, CX

;------------------------------------
MOV CX, SENTENCE2_LENGTH 
CALL CONCAT
 
CALL CLEAR_SCREEN

CALL NEW_LINE

CALL S1_FINAL   
CALL S2_FINAL 

;------------------------------------


;SIMILARITY
;----------
MOV SI, OFFSET SENTENCE2
CALL FIND_NUMBER_OF_WORDS

MOV CX, WORDS
MOV WORDS2, CX

MOV SI, OFFSET SENTENCE1
CALL FIND_NUMBER_OF_WORDS

MOV CX, WORDS
MOV WORDS1, CX

CALL CALCULATE_SIMILARITY

JMP END_PROJECT 

;==============================================================================================;
;                                    READ SENTENCES                                            ;
;==============================================================================================;


;THIS PROCEDURE READS A STRING OF MAX LENGTH DEFINED AS 300 CAN BE MODIFIED
;PASSING THE PARAMETERS AS FILE.NAME & WHICH SENTENCE

READFILE PROC NEAR    
MOV AH,3DH                      ; OPEN A FILE
MOV AL,02
LEA DX,FILENAME                 ; THE ADDRESS OF FILE NAME SHOULD BE IN DX
INT 21H                         ; CALL FILE OPEN
MOV FHAND,AX                    ;FILE HANDLE IS RETURNED IN AX 
MOV SI, 0      


L: 
MOV BX, FHAND
;MOV BX,AX                       ; READ FUNCTIONS ASSUMES FILE HANDLER IS IN BX NOT AX
MOV AH,3FH                      ; READ
MOV CX,1                        ; NUMBER OF BYTES TO BE READ 1 ONLY READS CHAR
LEA DX,SENTENCE+SI              ; THE ADDRESS OF DATA TO BE READ
INT 21H
INC SI   

CMP AX, 0                       ;IF AX IS ZERO,READ IS DONE?
JE EXIT
JMP L

EXIT:
DEC SI
DEC SI
MOV BYTE PTR SENTENCE+SI," "    ;ADD $ TO END SO U CAN PRINT
MOV AH,3EH                      ;CLOSE FILE
INT 21H

RET 
ENDP

;==============================================================================================;
;                                   PRINTING TO SCREEN                                         ;
;==============================================================================================;
INTRO PROC NEAR
    PUSH SI
    PUSH CX
    PUSH DI
    
    MOV CX, 4
    LOOPNL1:
    CALL NEW_LINE
    LOOP LOOPNL1
    CALL NEW_LINE
    
    MOV DX, OFFSET INTRO1
    MOV AH, 09H
    INT 21H 
    
    CALL NEW_LINE
    CALL NEW_LINE
    MOV DX, OFFSET INTRO2
    MOV AH, 09H
    INT 21H 
    
    CALL NEW_LINE
    CALL NEW_LINE
    MOV DX, OFFSET INTRO3
    MOV AH, 09H
    INT 21H 
    
    CALL NEW_LINE
    CALL NEW_LINE
    MOV DX, OFFSET INTRO4
    MOV AH, 09H
    INT 21H
    CALL NEW_LINE
    CALL NEW_LINE
   
    MOV CX, 7
    LOOPNL2:
    CALL NEW_LINE
    LOOP LOOPNL2 
    
    CALL TABS
    CALL CONTINUE_SCREEN
    MOV AH, 08H
    INT 21H
 
    CALL CLEAR_SCREEN 
    
    MOV CX, 6
    LOOPNL3:
    CALL NEW_LINE
    LOOP LOOPNL3
    CALL TABS 
    MOV DX, OFFSET INTRO5
    MOV AH, 09H
    INT 21H
    CALL NEW_LINE
    MOV DX, OFFSET INTRO6
    MOV AH, 09H
    INT 21H
    
    MOV CX, 9
    LOOPNL4:
    CALL NEW_LINE
    LOOP LOOPNL4
    MOV DX, OFFSET INTRO7
    MOV AH, 09H
    INT 21H 
    
    CALL CONTINUE_SCREEN
    MOV AH, 08H
    INT 21H
 
    CALL CLEAR_SCREEN
    POP SI
    POP DI
    POP CX
    
    RET
ENDP

;============================:AFTER READING OF THE FILE
S1_AFTER_READ PROC NEAR
    MOV DX, OFFSET IN1
    MOV AH, 09H
    INT 21H 
    
    CALL NEW_LINE
    CALL NEW_LINE
    CALL TABS
    
    MOV DX, OFFSET SENTENCE1
    MOV AH, 09H
    INT 21H
    
    CALL NEW_LINE
    CALL NEW_LINE
    
    RET
ENDP

S2_AFTER_READ PROC NEAR
    MOV DX, OFFSET IN2
    MOV AH, 09H
    INT 21H 
    
    CALL NEW_LINE
    CALL NEW_LINE
    CALL TABS
    
    MOV DX, OFFSET SENTENCE2
    MOV AH, 09H
    INT 21H 
    
    CALL NEW_LINE
    CALL NEW_LINE
    
    RET
ENDP
;============================:AFTER REMOVING PUNCTUATION
S1_AFTER_PUNC_LOW PROC NEAR
    MOV DX, OFFSET IN1P
    MOV AH, 09H
    INT 21H 
    
    CALL NEW_LINE
    CALL NEW_LINE
    CALL TABS
    
    MOV DX, OFFSET SENTENCE1
    MOV AH, 09H
    INT 21H
    
    CALL NEW_LINE
    CALL NEW_LINE
    
    RET
ENDP

S2_AFTER_PUNC_LOW PROC NEAR
    MOV DX, OFFSET IN2P
    MOV AH, 09H
    INT 21H 
    
    CALL NEW_LINE
    CALL NEW_LINE
    CALL TABS
    
    MOV DX, OFFSET SENTENCE2
    MOV AH, 09H
    INT 21H
    
    CALL NEW_LINE
    CALL NEW_LINE
    
    RET
ENDP
;============================::AFTER REMOVING STOP WORDS
S1_AFTER_STOPW PROC NEAR
    MOV DX, OFFSET IN1S
    MOV AH, 09H
    INT 21H 
    
    CALL NEW_LINE
    CALL NEW_LINE
    CALL TABS
    
    MOV DX, OFFSET SENTENCE1
    MOV AH, 09H
    INT 21H
    
    CALL NEW_LINE
    CALL NEW_LINE
    
    RET
ENDP

S2_AFTER_STOPW PROC NEAR
    MOV DX, OFFSET IN2S
    MOV AH, 09H
    INT 21H 
    
    CALL NEW_LINE
    CALL NEW_LINE
    CALL TABS
    
    MOV DX, OFFSET SENTENCE2
    MOV AH, 09H
    INT 21H
    
    CALL NEW_LINE
    CALL NEW_LINE
    
    RET
ENDP
;=============================:AFTER DUPLICATION REMOVAL
S1_AFTER_DUP PROC NEAR
    MOV DX, OFFSET IN1D
    MOV AH, 09H
    INT 21H 
    
    CALL NEW_LINE
    CALL NEW_LINE
    CALL TABS
    
    MOV DX, OFFSET SENTENCE1
    MOV AH, 09H
    INT 21H
    
    CALL NEW_LINE
    CALL NEW_LINE
    
    RET
ENDP

S2_AFTER_DUP PROC NEAR
    MOV DX, OFFSET IN2D
    MOV AH, 09H
    INT 21H 
    
    CALL NEW_LINE
    CALL NEW_LINE
    CALL TABS
    
    MOV DX, OFFSET SENTENCE2
    MOV AH, 09H
    INT 21H
    
    CALL NEW_LINE
    CALL NEW_LINE
    
    RET
ENDP
;==============================:FINAL FORM
S1_FINAL PROC NEAR
    MOV DX, OFFSET FIN1
    MOV AH, 09H
    INT 21H 
    
    CALL NEW_LINE
    CALL NEW_LINE
    CALL TABS
    
    MOV DX, OFFSET SENTENCE1
    MOV AH, 09H
    INT 21H
    
    CALL NEW_LINE
    CALL NEW_LINE
    
    RET
ENDP

S2_FINAL PROC NEAR
    MOV DX, OFFSET FIN2
    MOV AH, 09H
    INT 21H 
    
    CALL NEW_LINE
    CALL NEW_LINE
    CALL TABS
    
    MOV DX, OFFSET SENTENCE2
    MOV AH, 09H
    INT 21H
    
    CALL NEW_LINE
    CALL NEW_LINE
    
    RET
ENDP


;==============================================================================================;
;                                    REMOVE PUNCUATION                                         ;
;==============================================================================================;

;THIS PROCEDURE REMOVES ALL PUNCTUATION IN A SENTENCE
;SI MUST POINT AT THE START OF THE SENTENCE

REMOVE_PUNC PROC NEAR
 
    PUSH SI  
    PUSH CX
    
   ;----------------
   
    MOV PUNC, ";"
    CALL DELETE_PUNC
   
   ;----------------
   
    MOV PUNC, "/"
    CALL DELETE_PUNC
   
   ;----------------
    
    MOV PUNC, "."
    CALL DELETE_PUNC
    
   ;----------------
    
    MOV PUNC, "?"
    CALL DELETE_PUNC
    
   ;----------------
   
    MOV PUNC, "!"
    CALL DELETE_PUNC
   
   ;----------------
    
    MOV PUNC, ":"
    CALL DELETE_PUNC
   
   ;----------------
    
    MOV PUNC, "-"
    CALL DELETE_PUNC
   
   ;----------------
    
    MOV PUNC, "_"
    CALL DELETE_PUNC
   
   ;----------------
    
    MOV PUNC, "("
    CALL DELETE_PUNC
   
   ;----------------
    
    MOV PUNC, ")"
    CALL DELETE_PUNC
   
   ;----------------
    
    MOV PUNC, "["
    CALL DELETE_PUNC
   
   ;----------------
    
    MOV PUNC, "]"
    CALL DELETE_PUNC
   
   ;----------------
    
    MOV PUNC, ","
    CALL DELETE_PUNC
   
   ;----------------
    
    MOV PUNC, "'"
    CALL DELETE_PUNC
   
   ;----------------
    
    MOV PUNC, 34H
    CALL DELETE_PUNC
   
   ;----------------
   
   POP CX
   POP SI
    
    RET 
ENDP
 

;TRAVERSE ALL SENTENCE AND REPLACES THE CHARACTERS THAT EQUALS "PUNC" BY BEEP = 07H
;CX = SENTENCE LENGTH

DELETE_PUNC PROC NEAR 
    
    PUSH SI
    PUSH DI
    PUSH CX
          
    MOV DI , SI       
    
    DELETE_PUNC_L1: 
        
        MOV AL , PUNC
        CMP [DI] , AL
        JZ DELETE
        
        CMP BYTE PTR [DI], "$"
        JZ DELETE_PUNC_DONE
        
        INC DI
        
        DELETE_PUNC_NEXT:
        
    JMP DELETE_PUNC_L1
    
    JMP DELETE_PUNC_DONE

DELETE:
    PUSH DI 
    MOV AX , 07H    ;"BEEP"              
    STOSB
    POP DI 
JMP DELETE_PUNC_NEXT                                       


DELETE_PUNC_DONE: 
    POP CX
    POP DI
    POP SI
    
    RET
ENDP

;==============================================================================================;
;                                    TO LOWER CASE                                             ;
;==============================================================================================;

TO_LOWER PROC NEAR 
    
    PUSH SI
    PUSH CX
    
    TO_LOWER_L1: 

        LODSB  
        
        CMP AL , "$"
        JZ TO_LOWER_DONE 
               
        CMP AL , 41H   
        JL TO_LOWER_NEXT
        
        CMP AL , 5AH
        JG TO_LOWER_NEXT
        
        ADD AL , 20H
        DEC SI
        MOV DI , SI 
        INC SI
        STOSB  
                
    TO_LOWER_NEXT:
    
    JMP TO_LOWER_L1   
    
    TO_LOWER_DONE: 
    POP CX 
    POP SI
    
    RET
ENDP

;==============================================================================================;
;                                    REMOVE STOP WORDS                                         ;
;==============================================================================================;
 
;THIS PROCEDURE REMOVES ALL STOP WORDS

REMOVE_STOP_WORDS PROC NEAR 
    
    PUSH SI
    PUSH CX 
    
    CALL CONCAT 
    CALL SENTENCE_LENGTH    
    
   ;------------------
   ;---- 1 DIGIT -----
   ;------------------ 
    MOV STOP1, "i"
    CALL REMOVE_1DIGIT
    
    MOV STOP1, "a"
    CALL REMOVE_1DIGIT
    
    
   ;------------------
   ;----- 2 DIGIT ----
   ;------------------ 
    MOV STOP1, "a"
    MOV STOP2, "n"
    CALL REMOVE_2DIGIT
    
    MOV STOP1, "a"
    MOV STOP2, "s"
    CALL REMOVE_2DIGIT
    
    MOV STOP1, "a"
    MOV STOP2, "t"
    CALL REMOVE_2DIGIT
    
    MOV STOP1, "b"
    MOV STOP2, "y"
    CALL REMOVE_2DIGIT
    
    MOV STOP1, "i"
    MOV STOP2, "n"
    CALL REMOVE_2DIGIT
    
    MOV STOP1, "o"
    MOV STOP2, "f"
    CALL REMOVE_2DIGIT
    
    MOV STOP1, "o"
    MOV STOP2, "n"
    CALL REMOVE_2DIGIT
    
   ;------------------
   ;----- 3 DIGIT ----
   ;------------------ 
    
    MOV STOP1, "t"
    MOV STOP2, "h"
    MOV STOP3, "e"
    CALL REMOVE_3DIGIT
    
    MOV STOP1, "f"
    MOV STOP2, "o"
    MOV STOP3, "r"
    CALL REMOVE_3DIGIT
    
   ;------------------
   ;----- 4 DIGIT ----
   ;------------------ 
   
    MOV STOP1, "t"
    MOV STOP2, "h"
    MOV STOP3, "a"
    MOV STOP4, "t"
    CALL REMOVE_4DIGIT
    
    CALL CONCAT 
    CALL SENTENCE_LENGTH
    
    POP CX
    POP SI
    
    RET
ENDP



REMOVE_1DIGIT PROC NEAR
    
    PUSH CX
    PUSH SI
    
    LD1:
    
        LODSB
        
        CMP AL , "$"
        JZ END_PROC1
        CMP AL , STOP1
        JNZ NEXTD1
        
        LODSB 
        CMP AL , " "
        JNZ NEXTD1
        
        ;DELETE
        SUB SI , 2
        MOV DI , SI
        MOV AL , 07H
        STOSB
        STOSB
        
        NEXTD1:    
        CALL NEXT_WORD_SI
    LOOP LD1
    
    END_PROC1:
    
    POP SI
    POP CX
    RET
ENDP  


REMOVE_2DIGIT PROC NEAR
    
    PUSH CX
    PUSH SI
    
    LD2:
    
    LODSB
    
    CMP AL , "$"
    JZ END_PROC2
    
    CMP AL , STOP1
    JNZ NEXTD2
    
    LODSB
    CMP AL , STOP2
    JNZ NEXTD2
    
    LODSB 
    CMP AL , " "
    JNZ NEXTD2
    
    ;DELETE
    SUB SI , 3
    MOV DI , SI
    MOV AL , 07H
    STOSB
    STOSB 
    STOSB
    
   
    NEXTD2:    
    CALL NEXT_WORD_SI
    LOOP LD2
    
    END_PROC2:
        POP SI
        POP CX
    RET
ENDP

REMOVE_3DIGIT PROC NEAR
    
    PUSH CX
    PUSH SI
    
    LD3:
    
    LODSB
    
    CMP AL , "$"
    JZ END_PROC3
    
    CMP AL , STOP1
    JNZ NEXTD3
    
    LODSB
    CMP AL , STOP2
    JNZ NEXTD3
    
    LODSB
    CMP AL , STOP3
    JNZ NEXTD3
    
    LODSB 
    CMP AL , " "
    JNZ NEXTD3
    
    ;DELETE
    SUB SI , 4
    MOV DI , SI
    MOV AL , 07H
    STOSB
    STOSB
    STOSB
    STOSB
    
   
    NEXTD3:    
    CALL NEXT_WORD_SI
    LOOP LD3
    
    END_PROC3:
        POP SI
        POP CX
    RET
ENDP

REMOVE_4DIGIT PROC NEAR 
    
    PUSH CX
    PUSH SI
    
    LD4:
    
    LODSB
    
    CMP AL , "$"
    JZ END_PROC4
    
    CMP AL , STOP1
    JNZ NEXTD4
    
    LODSB
    CMP AL , STOP2
    JNZ NEXTD4
    
    LODSB
    CMP AL , STOP3
    JNZ NEXTD4
    
    LODSB
    CMP AL , STOP4
    JNZ NEXTD4
    
    LODSB 
    CMP AL , " "
    JNZ NEXTD4
    
    ;DELETE
    SUB SI , 5
    MOV DI , SI
    MOV AL , 07H
    STOSB
    STOSB
    STOSB
    STOSB 
    STOSB
    
   
    NEXTD4:    
    CALL NEXT_WORD_SI
    LOOP LD4
    
    END_PROC4:
        POP SI
        POP CX
    RET
ENDP

;==============================================================================================;
;                                    REMOVE DUPLICATE                                          ;
;==============================================================================================;

REMOVE_DUPLICATE PROC NEAR
    
    
    
    CALL FIND_NUMBER_OF_WORDS
     
    MOV CX , WORDS
                 
    RD_L1:
    PUSH SI
    PUSH CX 
    CMP CX , 1
    JZ JAHEZ   
    
       
        
        DEC CX  
        
        MOV DI , SI
        CALL NEXT_WORD_DI   ; DONE

        

        
        RD_L2: 
        
            MOV TEST_F, 0
            CALL TEST_FLAG  ;TEST IS DEST WORD IS DUPLICATE 
            
            CMP TEST_F , 1 
            JZ RD_NEXT
             
            CALL STRCMP
            CMP EQUAL , 1
            
            JNZ RD_NEXT
            
            CALL SET_FLAG ; LENGTH - CX 
                        
            
            RD_NEXT:
            CALL NEXT_WORD_DI 
        LOOP RD_L2 
    
            
        
        
        POP CX
        POP SI
   
        CALL NEXT_WORD_SI
        
    LOOP RD_L1
    
    JAHEZ:
    
    
      
      
      
     
      ;MOV SI , OFFSET SENTENCE1
      ;CALL CONCAT  
      POP CX 
      POP SI

      
    RET
ENDP

;RESULT IS SAVED IN EQUAL DB
;=================================================

STRCMP PROC NEAR          ; DONE
    MOV EQUAL , 0
    
    PUSH CX
    PUSH SI
    PUSH DI 
    
    XOR AX, AX
    MOV AX , " " 
    CALL FIND_WORD_LENGTH_SI    ; SETS WORD_LENGTH     DONE
    CALL FIND_WORD_LENGTH_DI    ; SETS WORD_LENGTH2    DONE
    
    MOV AX , WORD_LENGTH
    CMP AX , WORD_LENGTH2
    
    JNZ HERE
    
    MOV CX , WORD_LENGTH 
    
    ; SI POINTS AT FIRST STRING
    ; DI POINTS AT SECOND STRING
    
    L11:    
        CMPSB
        JNZ DONEE 
    LOOP L11
     
     
    DONEE:
    CMP CX , 0
    JNZ HERE
    MOV EQUAL , 1
    HERE: 
    
    POP DI 
    POP SI
    POP CX   
    RET
ENDP 


;==============================================================================================;
;                                    INTERSECTION FUNCTIONS                                    ;
;==============================================================================================;

INTERSECTION PROC NEAR 
    
    PUSH CX
    PUSH AX
    PUSH DX
    MOV CX , WORDS1
    
    
    MOV SI, OFFSET SENTENCE1
    MOV DI, OFFSET SENTENCE2
    
    NEW_SI:
        
        PUSH CX
        
        MOV CX , WORDS2 
        
            
            LI1:
                CALL STRCMP
                CMP EQUAL, 1
                JZ NEXTSUCC
                CALL NEXT_WORD_DI
                JMP LI2
                
                
                NEXTSUCC:
                INC COUNTER
                JMP NEXT_SI
                
                LI2:
            LOOP LI1   
    
    NEXT_SI:
        CALL NEXT_WORD_SI
        LEA DI, SENTENCE2
        
        POP CX
    LOOP NEW_SI
    POP CX
    POP AX
    POP DX
    RET
ENDP

;==============================================================================================;
;                                    SIMILARITY FUNCTION                                       ;
;==============================================================================================; 

CALCULATE_SIMILARITY PROC NEAR 
    
    
    CALL INTERSECTION
    XOR BX, BX 
    MOV BX, WORDS1
    ADD BX, WORDS2
    MOV TWORDS, BX
    
    XOR DX, DX
    MOV DX, TWORDS
    SUB DX, COUNTER
    MOV DENOMINATOR, DX
    
    MOV BX, 100
    MOV AX, COUNTER
    MUL BX
    PUSH BX
    MOV BX, DENOMINATOR
    DIV BL
    POP BX
    MOV RESULT_INT, AL
    MOV RESULT_FLOATING, AH
    MOV AH, 00
    MOV AL, RESULT_FLOATING
    MUL BX
    MOV DX, 0000H
    DIV DENOMINATOR
    MOV RESULT_FLOATING, AL
    
    MOV DX, OFFSET PERCENT
    MOV AH, 09H
    INT 21H
    
    XOR AX, AX
    MOV AH, 00
    MOV AL,RESULT_INT
    CALL DISPLAY_NUMBER_IN_ANY_RADEX
    MOV DX, 2EH
    MOV AH, 02H
    INT 21H
;    MOV CX,2
;    LC:
    MOV AH, 00H
    MOV AL, RESULT_FLOATING
;    MUL BX
;    MOV DX, 0000H
;    DIV DENOMINATOR
;    MOV RESULT_FLOATING, AH
CALL DISPLAY_NUMBER_IN_ANY_RADEX
;    LOOP LC
    
    MOV DX, 20H
    MOV AH, 02H
    INT 21H
    MOV DX, 25H
    MOV AH, 02H
    INT 21H 
    
    RET
ENDP


;==============================================================================================;
;                                    HELPING FUNCTIONS                                         ;
;==============================================================================================;


NEXT_WORD_SI PROC NEAR
    
    MOV AH, 00H
    PUSH CX
    LOOOP:
    CMP BYTE PTR [SI] , '$'
    JZ END_STRING
    
    CMP BYTE PTR [SI] , ' '
    JZ END_PROC
    
    INC SI
    JMP LOOOP
    
    END_PROC:
    INC SI     
    
    END_STRING: 
    POP CX
    RET
ENDP

;===============================

CONCAT PROC NEAR
    
    PUSH SI
    PUSH CX 
    
    MOV AH, 00H
    MOV AX, 07H    ;ASCII CODE FOR BEEP 
    MOV DI, SI
    
    CONCAT_L1:
        
        CMP BYTE PTR [DI], "$"
        JE CONCAT_DONE
        
        SCASB
        JE SHIFT_LEFT
         
    CONCAT_RETURN:
        
    JMP CONCAT_L1
     
     
    SHIFT_LEFT:
    
        PUSH CX 
        PUSH DI     
       
        MOV SI , DI
        
        DEC DI 
        
        SHIFT_LEFT_L1: 
            CMP BYTE PTR [SI], "$"
            JE DONE_SHIFT_LEFT             
            MOVSB
        JMP SHIFT_LEFT_L1    
        
        DONE_SHIFT_LEFT:
        MOVSB
        POP DI  
        POP CX 
        DEC DI
         
    JMP CONCAT_RETURN 
    
    CONCAT_DONE: 
    POP CX
    POP SI
    
    RET
ENDP

;===============================

;THIS PROCEDURE CALCULATES THE NUMBER OF NON $ CHARACTERS IN THE STRING AND SAVE IT IN CX.

SENTENCE_LENGTH PROC NEAR
    
    PUSH SI
    MOV CX, 0
         
    SENTENCE_LENGTH_L1:
    
        CMP BYTE PTR [SI] , 24H
        JE SENTENCE_LENGTH_END
        INC CX
        INC SI 
        
        JMP SENTENCE_LENGTH_L1
            
        
    SENTENCE_LENGTH_END:
    POP SI  
    
    RET
ENDP

;===============================

NEXT_WORD_DI PROC NEAR
    
    MOV AH, 00H
    MOV AX, " "   
    PUSH CX
    
    NEXT_WORD_DI_L1:
    
        CMP BYTE PTR [DI], '$'
        JZ NEXT_WORD_DI_DONE 
           
        SCASB
        JZ NEXT_WORD_DI_DONE
    
    JMP NEXT_WORD_DI_L1    
    
    NEXT_WORD_DI_DONE: 
    POP CX
    RET
ENDP

;===============================
 

FIND_WORD_LENGTH_SI PROC NEAR 
    
    PUSH SI
    PUSH DI 
    MOV WORD_LENGTH , 0 
    
    MOV DI , SI
     
    LWLS:
        
        CMP BYTE PTR [DI], '$'
        JZ FINISH
        SCASB
        JZ FINISH
        INC WORD_LENGTH
    JMP LWLS
    
    FINISH:
    POP DI
    POP SI
    RET
ENDP 

;=============================== 
 
FIND_WORD_LENGTH_DI PROC NEAR 
    
    PUSH SI
    PUSH DI
    MOV WORD_LENGTH2 , 0
    XOR BX, BX 
    LWLD:
        
        MOV BX, [DI]
        MOV CONFIG, BX
        
        SCASB
        JZ FINISH1
        
        DEC DI
        CMP BYTE PTR [DI], '$'
        JZ FINISH1
        INC DI
        INC WORD_LENGTH2
    JMP LWLD
    
    
    FINISH1:
    POP DI
    POP SI
    RET
ENDP


SET_FLAG PROC NEAR
    
    PUSH SI
    PUSH DI
    PUSH CX
    
    MOV SI , OFFSET FLAGS

    MOV AX , WORDS    
    
    ADD SI , AX
    SUB SI , CX
    
    MOV BYTE PTR [SI] , 01H
    
    
    POP CX
    POP DI
    POP SI 
   
    RET
ENDP

;=========================

RESET_FLAG PROC NEAR 
    ; SET 0 IN FLAG ARRAY IN SPECIFIC LOCATION
    ; THIS LOCATION IS THE BASE ADDRESS OF FLAGS + (WORDS - CX) 
    
    PUSH SI
    PUSH DI
    PUSH CX
    
    MOV SI , OFFSET FLAGS


    MOV AX , WORDS 
        
    ADD SI , AX
    SUB SI , CX
    
    
    MOV BYTE PTR [SI] , 00H

    
    
    POP CX
    POP DI
    POP SI 
    
    RET
ENDP

;==================================== 

DISPLAY_NUMBER_IN_ANY_RADEX PROC
PUSH AX 
PUSH CX
PUSH BX
PUSH DX      
MOV CX, 0000        ;CLEAR DIGIT COUNTER
    
MOV BH, 0
MOV BL, 10       ;BX = RADIX
    
XOR SI, SI          ;CLEAR REGISTER SI
     
     
DISPX1:
    MOV DX , 0000   ;CLEAR DX
    DIV BX          ;DIVIDE DX:AX BY RADIX 
    MOV TEMP[SI], DL;SAVE REMAINDER
    INC SI
    INC CX          
    ADD AX, 00      ;TEST FOR QUOTIENT IF ZERO
    JNZ DISPX1      ;JUMP BACK IF QUOTIENT IS NOT ZERO
    DEC SI
        
DISPX2:
    MOV DL, TEMP[SI];GET REMAINDER 
    CMP DL , 9
    JG DISP_CHAR
    MOV AH, 02H 
    ADD DL, 30H     ;CONVERT TO ASCII
    INT 21H 
    DEC SI
    JMP CONTINUE

DISP_CHAR:
    MOV AH, 02H 
    ADD DL, 37H     ;CONVERT TO ASCII IF CHARACTER
    INT 21H 
    DEC SI
CONTINUE:
LOOP DISPX2         ;REPEAT FOR ALL DIGITS 
    POP AX
    POP CX
    POP BX
    POP DX
    RET
ENDP

       
;===================================

REMOVE_BY_FLAG PROC NEAR
    
    

    MOV CX , WORDS
    
    LOP:    
        CMP BYTE PTR [DI] , 1
        JZ DLT
        
        RETT: 
        CMP CX , 1
        JZ SKIP
        
        CALL NEXT_WORD_SI  
        
        SKIP:
        INC DI
    LOOP LOP
    JMP JAHEZ1
    
    DLT:
    PUSH SI
    PUSH DI
     
    MOV DI , SI
    MOV AX , 07H 
    DEC DI
        IN_LOP: 
            
            STOSB
            CMP BYTE PTR [DI] , " "
            JZ DN
        JMP IN_LOP
        DN:
    POP DI
    POP SI
    
    JMP RETT 
    
    JAHEZ1:   
    RET
ENDP

TEST_FLAG PROC NEAR
    
    ; SETS OR RESET A VALUE FOR TEST_F
    
    PUSH SI
    PUSH DI
    PUSH CX
    
    MOV SI , OFFSET FLAGS


    MOV AX , WORDS
       
    ADD SI , AX
    SUB SI , CX
    ;DEC SI
    ;DEC SI
    
    MOV BX , [SI]   
    MOV TEST_F , BL
    
    
    POP CX
    POP DI
    POP SI 
    RET
ENDP 

FIND_NUMBER_OF_WORDS PROC NEAR
    PUSH SI
    MOV WORDS, 0
    CALL SENTENCE_LENGTH 
   
    
        L1:     
        
            LODSB
            CMP AL , "$"
            JZ RESULTS
            CMP AL , " "
            JNZ NEXT
            INC WORDS 
            
        NEXT:
    LOOP L1 
    RESULTS:
    ;DEC WORDS
   
    POP SI
        
    RET
ENDP

;PRINTING PROPERTIES
;-----------------------
NEW_LINE PROC NEAR
     
    MOV DL, 0DH
    MOV AH, 02H
    INT 21H
    MOV DL, 0AH
    MOV AH, 02H
    INT 21H
    
    RET
ENDP 

TABS PROC NEAR
    MOV CX, 1
    LOOPTAB:
    MOV DL, 09H
    MOV AH, 02H
    INT 21H
    LOOP LOOPTAB
    
    RET
ENDP

CLEAR_SCREEN PROC NEAR
    XOR AX, AX
    MOV AX, 0003H
    INT 10H
    RET
ENDP

CONTINUE_SCREEN PROC NEAR
    
    CALL NEW_LINE
    
    CALL TABS
    
    MOV DX, OFFSET PRESS
    MOV AH, 09H
    INT 21H
    RET
ENDP 

PRINT_STRING PROC NEAR
    
    MOV AH, 09H
    INT 21H
        
    RET
ENDP

EMPTY_FLAGS PROC NEAR
    PUSH SI
    PUSH CX
    
    MOV CX , 100
    MOV SI , OFFSET FLAGS
    MOV AL , 00H
    EF:
        MOV [SI] , AL
        INC SI
    LOOP EF 
    
    POP CX
    POP SI
        
    RET
ENDP




END_PROJECT: 
MOV AH,4CH
INT 21H

END               
