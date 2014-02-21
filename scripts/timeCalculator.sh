#!/bin/bash

path='/home/behrooz/results2/'
cd $path

for file in *bit
do
    res="$file,`cat $file|grep seconds`"
    echo  $res >> output.csv
done
