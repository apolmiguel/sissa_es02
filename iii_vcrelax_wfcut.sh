#!/bin/bash

#printf "smearing\tkptmult\tenergy\n" >> energies_smearing.dat

wfcutoff=($(seq 50 10 120))


for wfc in ${wfcutoff[@]}
do

energy=$( awk '/!/ {print $5}' ./vcrelax/wfcutoff/wfc${wfc}/Sc_wfcut${wfc}.vcrelax.out)

printf "$wfc\t$energy\n" >> iii_energies_vcrelax_wfcut.dat

done

