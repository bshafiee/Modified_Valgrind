#!/bin/bash

path='/home/behrooz/results2/'
cd $path

for file in *bit
do
    res="$file,`cat $file|grep r04000037e1`"
    echo  $res >> output.csv
done
