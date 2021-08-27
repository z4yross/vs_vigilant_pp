#!/bin/bash
#         BIOINFORMATICS AND SYSTEMS BIOLOGY LABORATORY
#     Instituto de Genetica - Univesidad Nacional de Colombia 
#
#  Routine to run  nf-core/viralrecon
#
# INPUT
# 
#
#
# OUTPUT
#
# RUN EXAMPLE
# run_viralrecon.sh -i fastq_pass/ -s sequencing_summary.txt  -q samplesheet.csv -o mirun
#
#
#
#
#Path of this file.
tp=$(dirname ${0})
source $tp/vigilant.env

#Import common library
source ${VIGILANTHOME}/lib/fp.sh

#Constants
nfBin="${VIGILANTHOME}/bin/nextflow-21.04.1-all"
vReconRelease="2.2"
medakaModel="${VIGILANTHOME}/viralrecon/r941_min_high_g360_model.hdf5"
customConfig="${VIGILANTHOME}/viralrecon/custom.config"

while getopts i:s:q:o: flag
do
  case "${flag}" in
    i) fastqDir=${OPTARG};;
    s) sequencingSummary=${OPTARG};;
    q) sampleSheet=${OPTARG};;
    o) outDir=${OPTARG};;
   \?) echo "Option not existent: ${OPTARG}" 1>&2;;
    :) echo "Missing value: ${OPTARG} requires an argument " 1>&2;;
  esac
done



#--------------------------------------------------------------------
# INPUT CONTROL
#--------------------------------------------------------------------
checkDir=$(direxists ${outDir})
if [ $checkDir -eq 1 ]; then
	saythis "WARN: Output directory: \"${outDir}\" exists. Please rename or move the folder." "warn"
	exit 1
fi

checkDir=$(direxists ${fastqDir})
if [ $checkDir -eq 0 ]; then
	saythis  "ERROR: Unable to find $fastqDir. Make sure directory exist." "error"
	exit 1
fi

checkFile=$(fileexists ${sequencingSummary})
if [ $checkFile -eq 0 ]; then
	saythis  "ERROR: Unable to find $sequencingSummary. Make sure it exists." "error"
	exit 1
fi


checkFile=$(fileexists ${sampleSheet})
if [ $checkFile -eq 0 ]; then
	saythis  "ERROR: Unable to find $sampleSheet. Make sure it exists." "error"
	exit 1
fi




#--------------------------------------------------------------------
# RUN IT
#--------------------------------------------------------------------
echo ""
saythis "STARTING VIRALRECON ${vReconRelease}" "msg"
echo ""

sudo ${nfBin} run nf-core/viralrecon -r ${vReconRelease} \
--input ${sampleSheet} \
--platform nanopore \
--genome 'MN908947.3' \
--primer_set_version 3 \
--fastq_dir ${fastqDir} \
--artic_minion_caller medaka \
--artic_minion_medaka_model ${medakaModel} \
-profile docker \
-c ${customConfig} \
--sequencing_summary ${sequencingSummary} \
--outdir ${outDir} \ 



