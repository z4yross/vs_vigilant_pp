#!/bin/bash
#
# Since the actual version of viralrecon do not support json output
# This script runs nextclade over the fasta files and obtains that json file.
#
# INPUT:
# Path to viralrecon results dir.
# Run ID: user defined id for this run
#
# OUTPUT:
# json file.
#
# EXAMPLE COMMAND LINE:
# run_offline_nextclade.sh [viralrecon_results_dir]
#


#Path of this file.
tp=$(dirname ${0})
source $tp/vigilant.env

#Import common library
source ${VIGILANTHOME}/lib/fp.sh

vReconResultsDir=${1}



#--------------------------------------------------------------------
# CONSTANTS
#--------------------------------------------------------------------
nextCladeBin=$(echo "${VIGILANTHOME}/bin/nextclade-Linux-x86_64")
nextCladeFiles=$(echo "${VIGILANTHOME}/nextclade-input/")
consFileName=$(echo "all.consensus.fasta")
# Where to store results
outputDir=$(echo "nextclade_output")


#--------------------------------------------------------------------
# INPUT CONTROL
#--------------------------------------------------------------------
checkDir=$(direxists ${vReconResultsDir})
if [ $checkDir -eq 0 ]; then
	saythis "ERROR: Unable to find directory: \"${vReconResultsDir}\". Maybe wrong path?." "error"
	exit 1
fi


checkDir=$(direxists ${outputDir})
if [ $checkDir -eq 1 ]; then
	saythis "WARN: Output directory: \"${outputDir}\" exists. Please rename or move the folder." "warn"
	exit 1
fi



saythis "Gathering consensus files" "msg"

cat ${vReconResultsDir}/medaka/*consensus*  > ${consFileName}

#Run nextclade
${nextCladeBin} --input-fasta=${consFileName} --input-root-seq=${nextCladeFiles}reference.fasta --genes=E,M,N,ORF1a,ORF1b,ORF3a,ORF6,ORF7a,ORF7b,ORF8,ORF9b,S --input-gene-map=${nextCladeFiles}genemap.gff --input-tree=${nextCladeFiles}tree.json --input-qc-config=${nextCladeFiles}qc.json --input-pcr-primers=${nextCladeFiles}primers.csv --output-json=${outputDir}/nextclade.json --output-csv=${outputDir}/nextclade.csv --output-tsv=${outputDir}/nextclade.tsv --output-tree=${outputDir}/nextclade.auspice.json --output-dir=${outputDir} --output-basename=vigilant

#Clean up!
mv ${consFileName} ${outputDir}

saythis "Nextclade ran succesfully." "success"
