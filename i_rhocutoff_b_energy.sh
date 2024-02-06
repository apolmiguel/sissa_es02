#!/bin/bash

# list of ecutrho multipliers.
rhocut=($(seq 4 2 8)) 
ecutwfc=90

for r in ${rhocut[@]}
do

energy=$( awk '/!/ {print $5}' ./rhocutoff_b/rhocut${r}/Sc_rhocut_${ecutwfc}_${r}.scf.out)

printf "$r\t$energy\n" >> energies_rhocut_b.dat

done
