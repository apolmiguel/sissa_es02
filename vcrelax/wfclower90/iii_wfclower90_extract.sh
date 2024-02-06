#!/bin/bash


rm iii_wfclow_cparams_all.dat
rm iii_wfclow_cparams_raw.dat
rm iii_wfclow_cparams_a.dat
rm iii_wfclow_cparams_ca.dat
rm iii_wfclow_pressures_all.dat
rm iii_wfclow_pressures_raw.dat
rm iii_wfclow_pressures_clean.dat
rm iii_wfclow_energies_all.dat
rm iii_wfclow_energies_raw.dat
rm iii_wfclow_energies_clean.dat

ecutwfc=($(seq 40 10 80))

for wfc in ${ecutwfc[@]}
do

# energies

grep "ecutwfc=" ./wfc${wfc}/Sc_iii_lower90${wfc}.vcrelax.in >> iii_wfclow_energies_all.dat
grep "!" ./wfc${wfc}/Sc_iii_lower90${wfc}.vcrelax.out >> iii_wfclow_energies_all.dat
grep "!" ./wfc${wfc}/Sc_iii_lower90${wfc}.vcrelax.out | tail -1 >> iii_wfclow_energies_raw.dat


# pressures
grep "ecutwfc=" ./wfc${wfc}/Sc_iii_lower90${wfc}.vcrelax.in >> iii_wfclow_pressures_all.dat
grep -A 2 "Computing stress" ./wfc${wfc}/Sc_iii_lower90${wfc}.vcrelax.out >> iii_wfclow_pressures_all.dat
grep -A 2 "Computing stress" ./wfc${wfc}/Sc_iii_lower90${wfc}.vcrelax.out | tail -1 >> iii_wfclow_pressures_raw.dat

# cell parameters
grep "ecutwfc=" ./wfc${wfc}/Sc_iii_lower90${wfc}.vcrelax.in >> iii_wfclow_cparams_all.dat
grep -A 3 'crystal axes' ./wfc${wfc}/Sc_iii_lower90${wfc}.vcrelax.out >> iii_wfclow_cparams_all.dat 
grep -A 3 'crystal axes' ./wfc${wfc}/Sc_iii_lower90${wfc}.vcrelax.out | tail -3 >> iii_wfclow_cparams_raw.dat 

done

# a parameter
awk '/a\(1\)/ {print $4}' ./iii_wfclow_cparams_raw.dat >> iii_wfclow_cparams_a.dat
# c parameter
awk '/a\(3\)/ {print $(NF-1)}' ./iii_wfclow_cparams_raw.dat >> iii_wfclow_cparams_ca.dat

# pressure
awk '/total/ {print $NF}' ./iii_wfclow_pressures_raw.dat >> iii_wfclow_pressures_clean.dat

# energy
awk '/!/ {print $5} ' ./iii_wfclow_energies_raw.dat >> iii_wfclow_energies_clean.dat
