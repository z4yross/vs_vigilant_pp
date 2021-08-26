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
# RUN VIRALRECON
#
#--------------------------------------------------------------------

#--------------------------------------------------------------------
#
# RUN NEXTCLADE 
#
#--------------------------------------------------------------------
#ESTE 1 DEBE VERSE NO CREO NECESARIO ESE ID
/home/apinzon/mis_datos/GitHub/redVigilancia/run_offline_nextclade.sh ${outDir} 1


#--------------------------------------------------------------------
#
# CREATE REPORT
#
#--------------------------------------------------------------------
/home/apinzon/mis_datos/GitHub/redVigilancia/create_ins_report.sh 1_nextclade_output/1_nextclade.json /home/apinzon/mis_datos/GitHub/redVigilancia/ins_voci.lst ${outDir}






