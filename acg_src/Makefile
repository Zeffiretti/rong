#OS = linux
OS = linux64
#OS = cygwin

CFLAGS = -O2 -Wall
CC = g++
FFTW = fftw-3.1.2
LIBS =  -L${FFTW}/lib${OS} -lfftw3 -lm
INCLUDES = -I${FFTW}/include
OBJS = auxiliary.o testacg.o acgmodel.o
SRCS = auxiliary.cpp testacg.cpp acgmodel.cpp

all: acg

acg: ${OBJS}
	${CC} ${CFLAGS} ${INCLUDES} -o $@ ${OBJS} ${LIBS}

.cpp.o:
	${CC} ${CFLAGS} ${INCLUDES} -c $<

depend: 
	makedepend ${SRCS}

clean:
	rm -f *.o

