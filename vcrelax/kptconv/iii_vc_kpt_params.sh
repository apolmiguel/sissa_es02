#!/bin/bash

rm kptconv_vols_all.dat
rm kptconv_vols_raw.dat
rm kptconv_cparams_all.dat
rm kptconv_cparams_raw.dat
rm kptconv_cparams_a.dat
rm kptconv_cparams_ca.dat
rm kptconv_energies_all.dat
rm kptconv_energies_raw.dat
rm kptconv_energies_clean.dat
rm kptconv_pressures_all.dat
rm kptconv_pressures_raw.dat
rm kptconv_pressures_clean.dat


kptlist=($(seq 1 1 12))

for kptm in ${kptlist[@]}
do

# cell volumes
grep -A 2 "K_POINTS" ./kptm${kptm}/Sc_iii_kptm${kptm}.vcrelax.in >> kptconv_vols_all.dat
grep "unit-cell volume" ./kptm${kptm}/Sc_iii_kptm${kptm}.vcrelax.out >> kptconv_vols_all.dat
grep "unit-cell volume" ./kptm${kptm}/Sc_iii_kptm${kptm}.vcrelax.out | tail -1 >> kptconv_vols_raw.dat

# cell parameters
grep -A 2 "K_POINTS" ./kptm${kptm}/Sc_iii_kptm${kptm}.vcrelax.in >> kptconv_cparams_all.dat
grep -A 3 'crystal axes' ./kptm${kptm}/Sc_iii_kptm${kptm}.vcrelax.out >> kptconv_cparams_all.dat 
grep -A 3 'crystal axes' ./kptm${kptm}/Sc_iii_kptm${kptm}.vcrelax.out | tail -3 >> kptconv_cparams_raw.dat 


# energies
grep -A 2 "K_POINTS" ./kptm${kptm}/Sc_iii_kptm${kptm}.vcrelax.in >> kptconv_energies_all.dat
grep "!" ./kptm${kptm}/Sc_iii_kptm${kptm}.vcrelax.out >> kptconv_energies_all.dat
grep "!" ./kptm${kptm}/Sc_iii_kptm${kptm}.vcrelax.out | tail -1 >> kptconv_energies_raw.dat

# pressures
grep -A 2 "K_POINTS" ./kptm${kptm}/Sc_iii_kptm${kptm}.vcrelax.in >> kptconv_pressures_all.dat
grep -A 2 "Computing stress" ./kptm${kptm}/Sc_iii_kptm${kptm}.vcrelax.out >> kptconv_pressures_all.dat
grep -A 2 "Computing stress" ./kptm${kptm}/Sc_iii_kptm${kptm}.vcrelax.out | tail -1 >> kptconv_pressures_raw.dat

done

# Cleaning data to be read to plotter.ipynb
#{print $NF} prints starting from the last instance. $(NF-n) to print the last nth instance.
awk '/total/ {print $NF}' ./kptconv_pressures_raw.dat >> kptconv_pressures_clean.dat 
awk '/total/ {print $(NF-1)}' ./kptconv_energies_raw.dat >> kptconv_energies_clean.dat

#  a and c parameters
awk '/a\(1\)/ {print $4}' ./kptconv_cparams_raw.dat >> kptconv_cparams_a.dat
awk '/a\(3\)/ {print $(NF-1)}' ./kptconv_cparams_raw.dat >> kptconv_cparams_ca.dat
