###################
## ascii_chart
###################
this program creates 
bar charts (histograms)
and pie charts
using ascii data read from files 
or from the standard input
###################
- compiled, updated and tested on GNU/Linux ubuntu 18.04 (x86_64)
by Francesco Lazzarotto fralaz1971@gmail.com on 2020-07-16
linked to GNU plotutils  v2.6 , 
tested also on MS windows (i386 & x86_64) and MacOS (darwin8.7 i386)
- added a constants.h header file with mathematical constants
- updated to use xstrdup() function included in plotutils libcommon.a
- added ascii_chart_ps  a second version of the program that defaults on creating
postscript output (it's the same of ./ascii_chart -T ps)
- updated the makefile with other make targets to test file generation, clean products, ...
- added the use of viewers launched from Makefile, need to be configured
  by the user, i used okular https://okular.kde.org/ 
  that can handle ps, gif, png files and can read from the stdin
  also works perfectly both on Linux and MS win
  (other viewers of course can be used as well e.g. gv, gwenview, eog, ...)
* to do: 
    - add tests handling svg plots/files, that can be viewed
  with web browsers (firefox, chrome, safari, edge, IE, ...)
    - put in an automake project
##
# to compile:
# 1) update the Makefile with location of your gnu plotutils installation
# 2) run 
make
# or 
make <target>
# where target can be
test010 or test015 or test020 ...
# to remove generated files
make clean
##
The program ascii_chart 
(https://web.archive.org/web/20181023193740/http://biolpc22.york.ac.uk/linux/plotutils/)

This program takes data in a two column ascii format (labels, data; see Sample data files) and plots them using the libplot routine of the plotutils package. It is based on the piechart program of  Bernhard Reiter,  without which I could not have written the code which plotted the linebars. Both this program and its piechart basis are released under the GPL version 2.

To install it you need the makefile and source listed below and the plotutils package.  This is best downloaded fom a mirror of the www.gnu.org site.
You will have to alter the Makefile to reflect the places in which you put the library libplot.so the binary files (eg plot) and the source files from the plotutils package.

To run  the program use a command line like thes two examples where the display type, title, axis labels etc are provided by command line parameters and the data from an ascii file

./ascii_chart -TX -t "Jobs Histogram" -X "period" -Y "n. of jobs" -r 0.6 < months.dat
./ascii_chart -TX -t "Distribution of tasks" -P -r 0.6 -d 0.2 < spring.dat

Output can be sent to an X display, tektronix 4014 display, to a gif, ps or pcl file, or several other devices supported by the plotutils library. The gif files from the sample data look like this (click the image to see  enlarged version)

Sample Data files are provided in the distribution

      months.dat      
      probe.dat       
      spring.dat

Chris Elliott, cje2@york.ac.uk, 15 Sept 1999
