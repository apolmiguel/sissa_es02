#!/bin/bash

rm ivd_raw.dat
rm ivd_clean.dat

specialklist=($(seq 0 1 3))

for spec in ${specialklist[@]}
do


grep "Calcualtion of q" ./special${spec}/sc.specialk${spec}.scf.out >> ivd_raw.dat
grep -A 11 "Diagonalizing the dynamical matrix" ./special${spec}/sc.specialk${spec}.scf.out >> ivd_raw.dat
done

awk '/freq/ {print$(NF-1)}' ./ivd_raw.dat >> ./ivd_clean.dat
