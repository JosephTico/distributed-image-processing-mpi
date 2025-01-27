# File paths
SRC_DIR := ./src
BUILD_DIR := ./build
OBJ_DIR := $(BUILD_DIR)/obj
HEADER	= stb_image.h stb_image_write.h 

# Compilation flags
CC := gcc
LD := gcc
CFLAGS := -Wall -std=c11
LFLAGS	 = -lm -ltiff -ljpeg -lpng -pthread 

# Files to be compiled
SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
BUILD := $(OBJS:$(OBJ_DIR)/%.o=$(BUILD_DIR)/%)

# Don't remove *.o files automatically
.SECONDARY: $(OBJS)

all: $(BUILD)

# Compile each *.c file as *.o files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c 
	@echo + CC $<
	@mkdir -p $(OBJ_DIR)
	@$(CC) $(CFLAGS) -c -o $@ $< $(LFLAGS)
	
# Link each *.o file as executable files
$(BUILD_DIR)/%: $(OBJ_DIR)/%.o
	@echo + LD $@
	@mkdir -p $(BUILD_DIR)
	@$(LD) $(CFLAGS) -o $@ $< $(LFLAGS)
	
.PHONY: all clean

clean:
	rm -f $(BUILD)
	rm -rf $(OBJ_DIR)