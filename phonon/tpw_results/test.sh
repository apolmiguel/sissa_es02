#!/bin/sh

input="./iv_freq_all.dat"

while read -r line;
do 
	echo "$line"
done < "$input"
