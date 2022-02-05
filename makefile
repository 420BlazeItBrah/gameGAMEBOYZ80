ASM = tools/rgbasm
LINKER = tools/rgblink
FIX = tools/rgbfix
BUILD_DIR = build
OUTPUT_DIR = out
SRC = $(wildcard *.ASM)
OBJS = $(SRC:.ASM=.o)

GAME_NAME = hello-world

all: clean build link fix launch

build:
	mkdir $(BUILD_DIR)
	mkdir $(OUTPUT_DIR)
	$(ASM) -o $(BUILD_DIR)/$(OBJS) $(SRC)

link:
	$(LINKER) -o $(OUTPUT_DIR)/$(GAME_NAME).gb $(BUILD_DIR)/$(OBJS)

fix:
	$(FIX) -v -p 0 $(OUTPUT_DIR)/$(GAME_NAME).gb

launch:
	start $(OUTPUT_DIR)/$(GAME_NAME).gb

clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(OUTPUT_DIR)/$(GAME_NAME).gb
	rm -rf $(OUTPUT_DIR)