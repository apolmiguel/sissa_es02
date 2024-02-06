#!/bin/bash

rm i_wfclower_energies.dat

printf "ecutwfc\tenergy\n" >> i_wfclower_energies.dat

ecutwfc=($(seq 10 10 70))
# do loop for distances
for r in ${ecutwfc[@]}
do

energy=$( awk '/!/ {print $5}' ./wfclower${r}/Sc_wfclower${r}.scf.out)

printf "$r\t$energy\n" >> i_wfclower_energies.dat

done
