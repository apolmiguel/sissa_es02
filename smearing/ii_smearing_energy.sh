#!/bin/bash

#printf "smearing\tkptmult\tenergy\n" >> energies_smearing.dat
rm energies_smearing.dat

kptmult=($(seq 2 1 12))

# do loop for smearing parameter
for smr in 0.1 0.05 0.02 0.01 0.005 0.002 0.001;
do

for kpt in ${kptmult[@]}
do

energy=$( awk '/!/ {print $5}' ./smearing_kpt${smr}/kptmult${kpt}/Sc_smearing${smr}_kpt${kpt}.scf.out)

printf "$smr\t$kpt\t$energy\n" >> energies_smearing.dat

done

done
