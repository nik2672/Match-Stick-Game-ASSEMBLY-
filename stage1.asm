PlayerInfo: 
      MOV R0, #msg1
      STR R0, .WriteString
      MOV R0, #player1Name
      STR R0, .ReadString
AskNumberofMatchsticks:
      MOV R0, #msg2
      STR R0, .WriteString
      LDR R0, .InputNum
      CMP R0, #5
      BLT invalidNumberMatchsticks
      CMP R0, #100
      BGT invalidNumberMatchsticks
      B validNumberMatchsticks
invalidNumberMatchsticks:
      B AskNumberofMatchsticks
validNumberMatchsticks:
      MOV R1, R0
      MOV R0, #msg3
      STR R0, .WriteString
      MOV R0, #player1Name
      STR R0, .WriteString
      MOV R0, #msg4
      STR R0, .WriteString
      MOV R0, R1
      STR R0, .WriteUnsignedNum
      HALT
player1Name: .BLOCK 128
msg1: .ASCIZ "Please enter your name  "
msg2: .ASCIZ "How many matchsticks (5-100)?  "
msg3: .ASCIZ "Player 1 is "
msg4: .ASCIZ "                                                          Matchsticks: "
