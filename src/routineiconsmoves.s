.thumb

@@@@@ Routine loads icons
.align 2
Routine_Icon_Moves:
	add r0, r0, r5
	lsl r0, r0, #0x03
	ldr r1, Replaced_Address_Routine_Icon_Moves
	add r4, r0, r1
	push {r0-r5}
	ldr r0, =ImageIconForMoves
	ldr r1, OBJVRAM_Routine_Icon_Moves
	mov r2, #0xC0
	swi #0xB
	ldr r0, CurMoveIndex_DMA_Routine_Icon_Moves
	ldr r0, [r0]
	mov r2, #0x10
	lsl r2, #8
	add r2, #0xD
	add r0, r2
	ldrb r0, [r0]
	cmp r0, #0x0
	bne StatFinish_Routine_Icon_Moves
	mov r2, #0x10
	lsl r2, #8
	add r2, #0xA
	cmp r6, #0x0
	beq StatPreStart_Routine_Icon_Moves

Start_Routine_Icon_Moves:
	ldr r0, CurMoveIndex_DMA_Routine_Icon_Moves
	ldr r0, [r0] 
	add r0, r2
	cmp r6, #0x1
	bne Continue_Routine_Icon_Moves
	add r0, #0x1 

Continue_Routine_Icon_Moves:
	ldrb r1, [r0]
	cmp r1, #0x0
	bne GetMove_Routine_Icon_Moves
	mov r2, #0x20
	lsl r2, #8
	add r0, r2
	ldrb r1, [r0] 

GetMove_Routine_Icon_Moves:
	cmp r1, #0x4
	beq GetFifthMove_Routine_Icon_Moves
	lsl r1, r1, #1
	ldr r0, Move_List_DMA_Routine_Icon_Moves
	ldr r2, [r0]
	add r2, #0x84
	mov r0, r2
	add r0, r1
	ldrh r3, [r0]

Body_Routine_Icon_Moves:
	mov r0, #0x0
	lsl r0, r3, #1
	add r0, r3
	lsl r0, r0, #2
	ldr r1, MoveBase_Routine_Icon_Moves
	ldr r1, [r1]
	add r0, r1
	ldrb r4, [r0, #10]
	lsl r4, #1
	mov r0, #0x40
	lsl r0, #20
	ldr r1, [r0]
	mov r2, #0x20
	orr r1, r2
	stm r0!, {r1}
	ldr r0, OAMMemAddress_Routine_Icon_Moves
	ldr r1, IconOAM1_Routine_Icon_Moves
	ldr r2, IconOAM2_Routine_Icon_Moves
	cmp r4, #0x2
	beq SpecAdd_Routine_Icon_Moves
	cmp r4, #0x4
	beq StatAdd_Routine_Icon_Moves

Draw_Routine_Icon_Moves:
	stmia r0!, {r1, r2}
	ldr r0, OAMMemAddress_Routine_Icon_Moves
	mov r1, #0x70
	lsl r1, #0x14
	add r1, #0xD8
	mov r2, #0x4
	swi #0xb

StatFinish_Routine_Icon_Moves:
	cmp r6, #0x1
	beq MoveFinish_Routine_Icon_Moves
	cmp r6, #0x2
	beq LearnFinish_Routine_Icon_Moves
	pop {r0-r6}
	ldr r0, Return_Address_Stat_Routine_Icon_Moves
	bx r0

GetFifthMove_Routine_Icon_Moves:
	cmp r6, #0x2
	bne StatFinish_Routine_Icon_Moves
	ldr r0, CurMoveIndex_DMA_Routine_Icon_Moves
	ldr r0, [r0]
	mov r2, #0x10
	lsl r2, #8
	add r2, #0xA
	add r0, r2
	sub r0, #0x2
	ldrh r3, [r0]
	cmp r3, #0x0
	bne Body_Routine_Icon_Moves
	mov r2, #0x20
	lsl r2, #8
	add r0, r2
	ldrh r3, [r0]
	cmp r3, #0x0
	bne Body_Routine_Icon_Moves
	b Start_Routine_Icon_Moves

StatPreStart_Routine_Icon_Moves:
	mov r3, #0x20
	lsl r3, #8
	add r2, r3
	b Start_Routine_Icon_Moves

LearnFinish_Routine_Icon_Moves:
	pop {r0-r6}
	ldr r0, Return_Address_Learn_Routine_Icon_Moves
	bx r0

MoveFinish_Routine_Icon_Moves:
	pop {r0-r6}
	ldr r0, Return_Address_Move_Routine_Icon_Moves
	bx r0

SpecAdd_Routine_Icon_Moves:
	mov r3, #0x20
	lsl r3, #8
	add r3, #0x04
	add r2, r3
	b Draw_Routine_Icon_Moves

StatAdd_Routine_Icon_Moves:
	add r2, #0x08
	b Draw_Routine_Icon_Moves

.align 2
.pool
MoveBase_Routine_Icon_Moves: .word 0x080001CC
CurMoveIndex_DMA_Routine_Icon_Moves: .word 0x0300090C
Move_List_DMA_Routine_Icon_Moves: .word 0x0203CF1C
Replaced_Address_Routine_Icon_Moves: .word 0x03005E08
Return_Address_Stat_Routine_Icon_Moves: .word 0x081C0F56+1
Return_Address_Move_Routine_Icon_Moves: .word 0x081C12F6+1
Return_Address_Learn_Routine_Icon_Moves: .word 0x081C175C+1
IconOAM1_Routine_Icon_Moves: .word 0x40280078
IconOAM2_Routine_Icon_Moves: .word 0x0000D580
OBJVRAM_Routine_Icon_Moves: .word 0x06013000
OAMMemAddress_Routine_Icon_Moves: .word 0x030023E4

.align 2
ImageIconForMoves:
.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x22, 0x22
.byte 0x00, 0x32, 0x33, 0x33, 0x00, 0x33, 0x32, 0x23, 0x00, 0x33, 0x22, 0x23, 0x00, 0x33, 0x23, 0x22
.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x22, 0x02, 0x00
.byte 0x33, 0x33, 0x23, 0x00, 0x32, 0x23, 0x33, 0x00, 0x32, 0x22, 0x33, 0x00, 0x22, 0x32, 0x33, 0x00
.byte 0x00, 0x33, 0x22, 0x22, 0x00, 0x33, 0x23, 0x22, 0x00, 0x33, 0x22, 0x23, 0x00, 0x33, 0x32, 0x23
.byte 0x00, 0x3D, 0x33, 0x33, 0x00, 0xD0, 0xDD, 0xDD, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.byte 0x22, 0x22, 0x33, 0x00, 0x22, 0x32, 0x33, 0x00, 0x32, 0x22, 0x33, 0x00, 0x32, 0x23, 0x33, 0x00
.byte 0x33, 0x33, 0xD3, 0x00, 0xDD, 0xDD, 0x0D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x60, 0x66, 0x66
.byte 0x00, 0x46, 0x44, 0x44, 0x00, 0x44, 0x64, 0x66, 0x00, 0x44, 0x56, 0x55, 0x00, 0x64, 0x45, 0x66
.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x06, 0x00
.byte 0x44, 0x44, 0x64, 0x00, 0x66, 0x46, 0x44, 0x00, 0x55, 0x65, 0x44, 0x00, 0x66, 0x54, 0x46, 0x00
.byte 0x00, 0x64, 0x64, 0x44, 0x00, 0x64, 0x54, 0x66, 0x00, 0x54, 0x46, 0x55, 0x00, 0x44, 0x65, 0x66
.byte 0x00, 0x4D, 0x54, 0x55, 0x00, 0xD0, 0xDD, 0xDD, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.byte 0x44, 0x46, 0x46, 0x00, 0x66, 0x45, 0x46, 0x00, 0x55, 0x64, 0x45, 0x00, 0x66, 0x56, 0x44, 0x00
.byte 0x55, 0x45, 0xD4, 0x00, 0xDD, 0xDD, 0x0D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0xFF, 0xFF
.byte 0x00, 0x8F, 0x88, 0x88, 0x00, 0x88, 0xF8, 0xFF, 0x00, 0x88, 0x8F, 0x88, 0x00, 0xF8, 0x88, 0xF8
.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x0F, 0x00
.byte 0x88, 0x88, 0xF8, 0x00, 0xFF, 0x8F, 0x88, 0x00, 0x88, 0xF8, 0x88, 0x00, 0xFF, 0x88, 0x8F, 0x00
.byte 0x00, 0xF8, 0x88, 0x88, 0x00, 0xF8, 0x88, 0x88, 0x00, 0x88, 0x8F, 0xF8, 0x00, 0x88, 0xF8, 0xFF
.byte 0x00, 0x8D, 0x88, 0x88, 0x00, 0xD0, 0xDD, 0xDD, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.byte 0xFF, 0x8F, 0x8F, 0x00, 0xFF, 0xFF, 0x8F, 0x00, 0xFF, 0xFF, 0x88, 0x00, 0xFF, 0x8F, 0x88, 0x00
.byte 0x88, 0x88, 0xD8, 0x00, 0xDD, 0xDD, 0x0D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.byte 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00

