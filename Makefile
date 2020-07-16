# updated on 16 July 2020 by fralaz1971@gmail.com
# $Id: makefile,v 1.6 1999/04/03 10:19:43 breiter Exp $

# you have to change the following paths to where you have installed/compiled plotutils
#BASE is where plotutils binaries has been compiled
BASE=/opt/plotutils
#PLOTLIBPATH is where plotutils lib libplot.so is
PLOTLIBPATH=/usr/local/lib
#PLOTLIBPATH2 is where plotutils lib libcommon.a is
PLOTLIBPATH2=/$(BASE)/lib
#PLOTBINPATH is where plotutils executables (graph, spline, plot, ...) has been installed
PLOTBINPATH=/usr/local/bin
PLOTINCLUDEPATH=$(BASE)/include
PLOTINCLUDEPATH2=$(BASE)
PLOT2X=$(PLOTBINPATH)/plot -T X
#postscript viewer (i use okular but you can use gv or whatever) able to read from stdin
PSVIEWER=okular 
#image viewer (i use okular but you can use gwenview, eog or whatever) able to read from file
IMGVIEWER=okular
CC=gcc -Wall -ansi
CFLAGS= -I$(PLOTINCLUDEPATH) -I$(PLOTINCLUDEPATH2)
#uncomment under if you want to use the DEBUG preprocessor definition switch 
#CFLAGS= -g -I$(PLOTINCLUDEPATH) -DDEBUG
LDFLAGS= -L$(PLOTLIBPATH) -L$(PLOTLIBPATH2)

TARGETS= ascii_chart ascii_chart_ps probe.dat probe2.dat probe-elena.dat
OBJ= ascii_chart.o ascii_chart_ps.o


test010:: ascii_chart probe.dat
	<probe.dat ./ascii_chart -P -r0.6 -d0.05 -C skyblue2,green,aquamarine,red -t "Hello World" | $(PLOT2X)
test015:: ascii_chart probe2.dat
	<probe2.dat ./ascii_chart -P -r0.6 -d0.05 -C skyblue2,green,aquamarine,red -t "Hello MAPS" | $(PLOT2X)
test020:: ascii_chart probe.dat
	./ascii_chart <probe.dat -P -r0.6 -d0.05  | plot -T ps  | $(PSVIEWER) -
test030:: ascii_chart probe.dat
	<probe.dat ./ascii_chart -X "x axis" -Y "Y axis" -t "Hello Histogram" -TX
test040: ascii_chart_ps probe-elena.dat
	./ascii_chart_ps -P -r 1.2 -X sector -Y counts -t ElenaPie  < probe-elena.dat | $(PSVIEWER) -
test050: ascii_chart_ps probe-elena.dat
	./ascii_chart_ps  -X sector -Y counts -t ElenaHisto  < probe-elena.dat | $(PSVIEWER) -
.PHONY: testpng
testpng:
	./ascii_chart -X "x axis" -Y "Y axis" -t "Hello Histogram" -Tpng <probe.dat > test.png
	$(IMGVIEWER) test.png &

.PHONY: testgif
testgif:
	./ascii_chart -P -r 1.1 -X sector -Y counts -t "ElenaPie" -Tgif <probe-elena.dat > test.gif 
	$(IMGVIEWER) test.gif &

.PHONY: testps
testps:
	./ascii_chart_ps -r 1.1 -X player -Y score -t "Probe Pie" -Tps <probe.dat > test.ps 
	$(PSVIEWER) test.ps &

probe.dat:
	echo '#just a very small input file for testing piechart'>probe.dat
	echo 'Bernhard 50'  >>probe.dat
	echo 'Cliff	20' >>probe.dat
	echo 'Joe Box 10'   >>probe.dat

probe2.dat:
	echo '#just another  small input file for testing piechart'>probe2.dat
	echo 'Cristina 50'>>probe2.dat
	echo 'Emanuele        20'>>probe2.dat
	echo 'Alice 10'>>probe2.dat
	echo 'Maurizio 2.4'>>probe2.dat

probe-elena.dat:
	echo '#elena like histogram input file for testing the chart'>probe-elena.dat
	./probe-elena.sh >> probe-elena.dat

ascii_chart: ascii_chart.c $(PLOTLIBPATH)/libplot.so
	$(CC) $(CFLAGS) $(LDFLAGS) \
		ascii_chart.c -o $@ -lplot -lcommon -lm

ascii_chart_ps: ascii_chart.c $(PLOTLIBPATH)/libplot.so
	$(CC) $(CFLAGS) $(LDFLAGS) \
		ascii_chart_ps.c -o $@ -lplot -lcommon -lm

all: ascii_chart ascii_chart_ps test010 test015 test020 test030 test040 testpng testgif testps

.PHONY: clean
clean:
	rm -f $(OBJ) $(TARGETS) test.gif test.png test.ps
