;cmd /c "cd /d ""C:\ASM Coding\test gameboy z80"" && ""make"""

;gb registers: a b c d e h l (gpr, general purpose; can be combined as well to create a 16bit val (they are all 8bit in size))

INCLUDE "GBHW.INC"

SECTION "HEADER", ROM0[$100]
    DI
    JP START 

REPT $150 - $104
    DB 0
ENDR

SECTION "ROM", ROM0

START:
.WAIT_VBLANK
    LD A, [rLY]
    CP A, 144
    JR C, .WAIT_VBLANK

    XOR A
    LD [rLCDC], A	

	LD HL, $9000
	LD DE, FontTiles
	LD BC, FontTilesEnd - FontTiles    

.COPYFONT
	LD A, [DE]    
    LD [HL+], A
    INC DE
    DEC BC
    LD A, B
    OR A, C
    JR NZ, .COPYFONT

    LD HL, $9900; print sentence on top screen
    LD DE, ONE

.COPYSTRING
    LD A, [DE]
    LD [HL+], A
    INC DE
    AND A
    JR NZ, .COPYSTRING

	LD A, %11100100    
    LD [rBGP], A

    XOR A
    LD [rSCY], A
    LD [rSCX], A
    LD [rNR52], A
    LD A, %10000001
    LD [rLCDC], A

.LOCKUP
    JR .LOCKUP

SECTION "FONT", ROM0

FontTiles:
    INCBIN "FONT.CHR"
FontTilesEnd:

SECTION "STRINGS", ROM0

ONE:
    DB " PRAISE METACRITICS", 0