#!/bin/bash

# Carpentries style suggests 50 character lines for callouts
# this script loops over the files to impose that, using sed

for filename in "$@"
do
    sed -i \
        -e 's/:::\+ callout/:::::::::::::::::::::::::::::::::::::::::: callout/g' \
        -e 's/:::\+ challenge/:::::::::::::::::::::::::::::::::::::::: challenge/g' \
        -e 's/:::\+ instructor/::::::::::::::::::::::::::::::::::::::: instructor/g' \
        -e 's/:::\+ keypoints/:::::::::::::::::::::::::::::::::::::::: keypoints/g' \
        -e 's/:::\+ objectives/::::::::::::::::::::::::::::::::::::::: objectives/g' \
        -e 's/:::\+ questions/:::::::::::::::::::::::::::::::::::::::: questions/g' \
        -e 's/:::\+ solution/::::::::::::::::::::::::::::::::::::::::: solution/g' \
        -e 's/:::\+$/::::::::::::::::::::::::::::::::::::::::::::::::::/g' \
        $filename
done

