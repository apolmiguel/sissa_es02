#!/bin/bash

rm ivc_conv_raw.dat
rm ivc_conv_clean.dat

kptlist=($(seq 1 1 12))

for kpt in ${kptlist[@]}
do


grep -A 2 "K_POINTS automatic" ./kpt${kpt}/sc.kpt${kpt}.scf.in >> ivc_conv_raw.dat
grep -A 11 "Diagonalizing the dynamical matrix" ./kpt${kpt}/sc.kpt${kpt}.scf.out >> ivc_conv_raw.dat
done

awk '/freq/ {print$(NF-1)}' ./ivc_conv_raw.dat >> ./ivc_conv_clean.dat
