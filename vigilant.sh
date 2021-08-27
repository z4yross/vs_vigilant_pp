#!/bin/bash
#
# BIOINFORMATICS AND SYSTEMS BIOLOGY LABORATORY
#  Instituto de Genetica - Universidad Nacional de Colombia
#
# This script is a wrapper for a series of routines that
# allow to run nf-core/viral recon plus inhouse scripts for
# the Genomic Surveillance of human Sars-CoV2 in Colombia.
#
#


#--------------------------------------------------------------------
#
# GET THE VIGILANTHOME environmental variable
#
#--------------------------------------------------------------------
tp=$(dirname ${0})
source $tp/vigilant.env

#Import common library
source ${VIGILANTHOME}/lib/fp.sh


#--------------------------------------------------------------------
#
# GET SCRIPT ARGUMENTS
#
#--------------------------------------------------------------------
while getopts i:s:q:o:v: flag
do
  case "${flag}" in
    i) fastqDir=${OPTARG};;
    s) sequencingSummary=${OPTARG};;
    q) sampleSheet=${OPTARG};;
    o) outDir=${OPTARG};;
    v) voci=${OPTARG};;
   \?) echo "Option not existent: ${OPTARG}" 1>&2;;
    :) echo "Missing value: ${OPTARG} requires an argument " 1>&2;;
  esac
done


#--------------------------------------------------------------------
#
# RUN VIRALRECON
#
#--------------------------------------------------------------------
${VIGILANTHOME}/run_viralrecon.sh \
 -i ${fastqDir} \
 -s ${sequencingSummary} \
 -q ${sampleSheet} \
 -o ${outDir}

#--------------------------------------------------------------------
#
# RUN NEXTCLADE 
#
#--------------------------------------------------------------------
${VIGILANTHOME}/run_offline_nextclade.sh ${outDir} 


#--------------------------------------------------------------------
#
# CREATE REPORT
#
#--------------------------------------------------------------------
${VIGILANTHOME}/create_ins_report.sh nextclade_output/nextclade.json ${voci} ${outDir}



