#!/bin/bash

# extract from all the special points
grep -A 11 "Diagonalizing the dynamical matrix" ./sc.scf.out >> iv_freq_all.dat
