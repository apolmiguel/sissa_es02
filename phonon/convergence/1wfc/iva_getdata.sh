#!/bin/bash

rm iva_conv_raw.dat
rm iva_conv_clean.dat

ecutwfc=($(seq 50 10 120))

for wfc in ${ecutwfc[@]}
do


grep "ecutwfc" ./wfc${wfc}/sc.wfc${wfc}.scf.in >> iva_conv_raw.dat
grep -A 11 "Diagonalizing the dynamical matrix" ./wfc${wfc}/sc.wfc${wfc}.scf.out >> iva_conv_raw.dat
done

awk '/freq/ {print$(NF-1)}' ./iva_conv_raw.dat >> ./iva_conv_clean.dat
