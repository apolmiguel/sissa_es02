#!/bin/bash


rm iii_vols_all.dat;
rm iii_vols_raw.dat;
rm iii_vols_clean.dat;
rm iii_cparams_all.dat;
rm iii_cparams_raw.dat;
rm iii_cparams_a.dat;
rm iii_cparams_ca.dat;
rm iii_vcrelax_energies_all.dat;
rm iii_vcrelax_energies_raw.dat;
rm iii_vcrelax_energies_clean.dat;
rm iii_vcrelax_pressures_all.dat;
rm iii_vcrelax_pressures_raw.dat;
rm iii_vcrelax_pressures_clean.dat

ecutwfc=($(seq 50 10 120))

for wfc in ${ecutwfc[@]}
do

# cell volumes
#grep "ecutwfc=" ./wfcutoff/wfc${wfc}/Sc_wfcut${wfc}.vcrelax.in >> iii_vols_all.dat
#grep "unit-cell volume" ./wfcutoff/wfc${wfc}/Sc_wfcut${wfc}.vcrelax.out >> iii_vols_all.dat
#grep "unit-cell volume" ./wfcutoff/wfc${wfc}/Sc_wfcut${wfc}.vcrelax.out | tail -1 >> iii_vols_raw.dat

# cell parameters
grep "ecutwfc=" ./wfcutoff/wfc${wfc}/Sc_wfcut${wfc}.vcrelax.in >> iii_cparams_all.dat
grep -A 3 'crystal axes' ./wfcutoff/wfc${wfc}/Sc_wfcut${wfc}.vcrelax.out >> iii_cparams_all.dat 
grep -A 3 'crystal axes' ./wfcutoff/wfc${wfc}/Sc_wfcut${wfc}.vcrelax.out | tail -3 >> iii_cparams_raw.dat 


# energies
grep "ecutwfc=" ./wfcutoff/wfc${wfc}/Sc_wfcut${wfc}.vcrelax.in >> iii_vcrelax_energies_all.dat
grep "!" ./wfcutoff/wfc${wfc}/Sc_wfcut${wfc}.vcrelax.out >> iii_vcrelax_energies_all.dat
grep "!" ./wfcutoff/wfc${wfc}/Sc_wfcut${wfc}.vcrelax.out | tail -1 >> iii_vcrelax_energies_raw.dat

# pressures
#| w/ tail -n we only get the final n value(s)
grep "ecutwfc=" ./wfcutoff/wfc${wfc}/Sc_wfcut${wfc}.vcrelax.in >> iii_vcrelax_pressures_all.dat
grep -A 2 "Computing stress" ./wfcutoff/wfc${wfc}/Sc_wfcut${wfc}.vcrelax.out >> iii_vcrelax_pressures_all.dat
grep -A 2 "Computing stress" ./wfcutoff/wfc${wfc}/Sc_wfcut${wfc}.vcrelax.out | tail -1 >> iii_vcrelax_pressures_raw.dat

done

# Cleaning data to be read to plotter.ipynb
#{print $NF} prints starting from the last instance. $(NF-n) to print the last nth instance.
awk '/total/ {print $NF}' ./iii_vcrelax_pressures_raw.dat >> iii_vcrelax_pressures_clean.dat 
awk '/total/ {print $(NF-1)}' ./iii_vcrelax_energies_raw.dat >> iii_vcrelax_energies_clean.dat

#  a parameter
awk '/a\(1\)/ {print $4}' ./iii_cparams_raw.dat >> iii_cparams_a.dat
awk '/a\(3\)/ {print $(NF-1)}' ./iii_cparams_raw.dat >> iii_cparams_ca.dat
