#!/bin/bash

rm energies_rhocut.dat

printf "ecutwfc\tenergy\n" >> energies_rhocut.dat

ecutwfc=($(seq 50 10 120))
# do loop for distances
for r in ${ecutwfc[@]}
do

energy=$( awk '/!/ {print $5}' ./ecutwfc${r}/Sc_rhocut${r}.scf.out)

printf "$r\t$energy\n" >> energies_rhocut.dat

done
