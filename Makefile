# GCC_BIN=`xcrun --sdk iphoneos --find gcc`
# GCC_UNIVERSAL=$(GCC_BASE) -arch armv7 -arch armv7s -arch arm64

CLANG_BIN="clang-10"
CLANG_UNIVERSAL=$(CLANG_BASE) -arch arm64e
SDK="/usr/share/SDKs/iPhoneOS.sdk" # Make sure it is patched

CFLAGS = 
CLANG_BASE = $(CLANG_BIN) -Os $(CFLAGS) -Wimplicit -isysroot $(SDK) -F$(SDK)/System/Library/Frameworks -F$(SDK)/System/Library/PrivateFrameworks

all: dumpdecrypted.dylib

dumpdecrypted.dylib: dumpdecrypted.o 
	$(CLANG_UNIVERSAL) -dynamiclib -o $@ $^

%.o: %.c
	$(CLANG_UNIVERSAL) -c -o $@ $< 

clean:
	rm -f *.o dumpdecrypted.dylib
