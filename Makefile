CC	=	ruby

FOLDER	=	src/

SRC	=	$(FOLDER)RealEstateCalc.rb
BIN	=	$(FOLDER)RealEstateCalc.bin
COMP	=	$(FOLDER)compiler.rb
EXEC	=	$(FOLDER)exec.rb

all:
	$(CC) $(COMP) $(SRC)

compile:
	$(CC) $(COMP) $(SRC)

launch:
	$(CC) $(EXEC) $(BIN)

clean:
	rm $(BIN)

ruby_version:
	ruby -v