#!/usr/bin/bash -l
echo "STRAIN,FILEBASE" > samples.csv
pushd input
ls *_1.fastq.gz | perl -p -e 's/((\S+)_1\.fastq\.gz)/$2,$2_[12].fastq.gz/' >> ../samples.csv
ls *_R1.fq.gz | perl -p -e 's/((\S+)_R1\.fq\.gz)/$2,$2_R[12].fq.gz/' >> ../samples.csv
#ls *R1_001.fastq.gz | perl -p -e 's/(((\S+)_S\d+)_R1_001\.fastq\.gz)/$3,$2_R[12]_001.fastq.gz/'  >> ../samples.csv
