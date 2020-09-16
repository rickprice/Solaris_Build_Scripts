echo Creating scratch folder
mkdir -p scratch
echo Cleaning out scratch folder
rm scratch/*
echo Getting order
platform project order -o ActiveStateEE -p apee-526-linux > scratch/apee-526-Solaris.json 
echo Update order to use Linux platform instead
PATH=$PATH:$HOME/go/bin
#yq w -i -j -P scratch/apee-526-Solaris.json 'platforms[0]' 0fa42e8c-ac7b-5dd7-9407-8aa15f9b993a
# Set Solaris 10 plattform
yq w -i -j -P scratch/apee-526-Solaris.json 'platforms[0]' 877400aa-0a73-5aed-9e60-aa34aae360fb
echo Resolving Order
resolve order -o scratch/apee-526-Solaris-resolved.json --update-timestamp  scratch/apee-526-Solaris.json
echo Setting up build
/home/fprice/camel/dev/bin/setup-builds.pl --enable-cold-storage --skip-tests --recipe-file scratch/apee-526-Solaris-resolved.json-CentOS_6.9-de08090c.json
