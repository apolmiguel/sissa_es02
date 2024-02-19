#!/bin/bash

rm ivd_conv_raw.dat
rm ivd_conv_clean.dat

specialklist=($(seq 0 1 3))

for spec in ${specialklist[@]}
do


grep -A 2 "K_POINTS automatic" ./special${spec}/sc.specialk${spec}.scf.in >> ivd_raw.dat
grep -A 11 "Diagonalizing the dynamical matrix" ./special${spec}/sc.specialk${spec}.scf.out >> ivd_raw.dat
done

awk '/freq/ {print$(NF-1)}' ./ivd_raw.dat >> ./ivd_clean.dat
