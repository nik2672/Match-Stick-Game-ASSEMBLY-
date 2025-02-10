PlayerInfo:
      MOV R0, #msg1
      STR R0, .WriteString
      MOV R0, #playerName
      STR R0, .ReadString
AskNumberofMatchsticks:
      MOV R0, #msg2
      STR R0, .WriteString
      LDR R0, .InputNum
      CMP R0, #5
      BLT AskNumberofMatchsticks
      CMP R0, #100
      BGT AskNumberofMatchsticks
      MOV R1, R0        ; R1 keeps the current number of matchsticks
PlayerTurn:
      MOV R0, #msg3
      STR R0, .WriteString
      MOV R0, #playerName
      STR R0, .WriteString
      MOV R0, #msg4
      STR R0, .WriteString
      MOV R0, R1
      STR R0, .WriteUnsignedNum
      MOV R0, #msg5
      STR R0, .WriteString
      LDR R0, .InputNum
      CMP R0, #1
      BLT InvalidNumberToRemove
      CMP R0, #3
      BGT InvalidNumberToRemove
      CMP R0, R1
      BGT InvalidNumberToRemove ;incase select more than total matchsticks
      SUB R1, R1, R0    ; remove matchsticks
      CMP R1, #1        ; determine computer turn or player win
      BGT ComputerTurn
      BEQ PlayerWins
InvalidNumberToRemove:
      B PlayerTurn
ComputerTurn:
      MOV R0, #msg7
      STR R0, .WriteString
      B ComputerMove
ComputerMove:
      LDR R2, .Random   ; Load random number
      AND R2, R2, #3    ; reduce to 2 least sig fig making range 0 to 3
      ADD R2, R2, #1    ; add 1 to make it between 1 and 4
      CMP R2, #4        ; compares if the number is 4
      BEQ ComputerMove  ; if it's 4 new number generated
      CMP R2, R1        ; compare with remaining matchsticks
      BGT ComputerMove  ; incase computerr removes more than total matchsticks
      SUB R1, R1, R2    ; remove matchsticks
      CMP R1, #1
      BGT PlayerTurn
      BEQ ComputerWins
      B TotalisZeroCheck
TotalisZeroCheck:       ;Ensures there is a winner not allowing total matchsticks to reach zero
      CMP R1, #0
      BEQ ComputerMove
      B PlayerTurn      ;not equal to 0 player turn
PlayerWins:
      MOV R0, #msg8
      STR R0, .WriteString
      MOV R0, #playerName
      STR R0, .WriteString
      MOV R0, #msg9
      STR R0, .WriteString
      B AskPlayAgain
ComputerWins:
      MOV R0, #msg8
      STR R0, .WriteString
      MOV R0, #playerName
      STR R0, .WriteString
      MOV R0, #msg10
      STR R0, .WriteString
      B AskPlayAgain
AskPlayAgain:
      MOV R0, #msg11
      STR R0, .WriteString
      LDR R0, .InputNum
      CMP R0, #0x79     ; 'y' = 121 couldnt input string
      BEQ ResetGame
      CMP R0, #0x6E     ; 'n' = 110
      BEQ HaltGame
      B AskPlayAgain
ResetGame:
      B PlayerInfo
HaltGame:
      HALT
playerName: .BLOCK 128
msg1: .ASCIZ "\nPlease enter your name: "
msg2: .ASCIZ "\nHow many matchsticks (5-100)? "
msg3: .ASCIZ "\nYour turn, "
msg4: .ASCIZ ", there are "
msg5: .ASCIZ " matchsticks remaining. How many do you want to remove (1-3)? "
msg7: .ASCIZ "\nComputer's turn.\n"
msg8: .ASCIZ "\nPlayer "
msg9: .ASCIZ " YOU WIN!"
msg10: .ASCIZ " YOU LOSE!"
msg11: .ASCIZ "\nPlay again (y/n) y=121 n = 110?"
