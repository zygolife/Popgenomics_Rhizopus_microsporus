#!/usr/bin/bash
module load samtools/1.12
module load bwa/0.7.17
if [ -f config.txt ]; then
	source config.txt
fi
mkdir -p $GENOMEFOLDER
pushd $GENOMEFOLDER
# THIS IS EXAMPLE CODE FOR HOW TO DOWNLOAD DIRECT FROM FUNGIDB
URL=https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/006/680/115/GCA_006680115.1_ASM668011v1/GCA_006680115.1_ASM668011v1_genomic.fna.gz
FASTAFILE=$(basename $URL .fna.gz).fasta
if  [ ! -s $FASTAFILE ]; then
	curl $URL | pigz -dc > $FASTAFILE
fi

if [[ ! -f $FASTAFILE.fai || $FASTAFILE -nt $FASTAFILE.fai ]]; then
	samtools faidx $FASTAFILE
fi
if [[ ! -f $FASTAFILE.bwt || $FASTAFILE -nt $FASTAFILE.bwt ]]; then
	bwa index $FASTAFILE
fi

DICT=$(basename $FASTAFILE .fasta)".dict"

if [[ ! -f $DICT || $FASTAFILE -nt $DICT ]]; then
	rm -f $DICT
	samtools dict $FASTAFILE > $DICT
	ln -s $DICT $FASTAFILE.dict 
fi

popd
