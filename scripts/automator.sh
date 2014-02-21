#!/bin/bash

path='/home/behrooz/cpu20066/benchspec/CPU2006/'
cd $path
for D in `find . -mindepth 1 -maxdepth 1 -type d`
do
    cd $D/exe/
    file=`ls`

    mv $file $file.bin
    DD=${D:2}
    script="#!/bin/bash\nname=$file\ndir=/home/behrooz/results3/$DD/\nexedir=/home/behrooz/cpu20066/benchspec/CPU2006/$DD/exe/\$name\nmkdir \$dir\nvalgrind --tool=lackey --trace-mem=yes --pname=\$name --outputdir=\$dir \$exedir.bin \$@"

    echo -e $script > $file
    chmod +x $file


    cd ../..
done


