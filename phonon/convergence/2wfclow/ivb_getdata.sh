#!/bin/bash

rm ivb_conv_raw.dat
rm ivb_conv_clean.dat

ecutwfc=($(seq 40 10 70))

for wfc in ${ecutwfc[@]}
do


grep "ecutwfc" ./wfclow${wfc}/sc.wfclow${wfc}.scf.in >> ivb_conv_raw.dat
grep -A 11 "Diagonalizing the dynamical matrix" ./wfclow${wfc}/sc.wfclow${wfc}.scf.out >> ivb_conv_raw.dat
done

awk '/freq/ {print$(NF-1)}' ./ivb_conv_raw.dat >> ./ivb_conv_clean.dat
