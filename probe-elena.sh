#!/bin/bash
seq 32 | awk 'BEGIN{srand();} {print "sec" $1, 100*rand()}'
