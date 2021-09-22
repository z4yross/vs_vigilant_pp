#!/bin/bash
# This script gets useful files reported by nf-core/viralrecon
# and other scripts and makes them available for revision.
# This was necessary since it is important to check results several times
# in each run and it is quite boring going through different directories copying etc.
#
# USE:
# publish.sh path_to_results_dir
#


#Import common library
tp=$(dirname ${0})
source $tp/vigilant.env
source ${VIGILANTHOME}/lib/fp.sh

#Check argument 2 is passed if not then die
resultsDir=${2}

#if publish dir is not defined as third argument create one in the same dir.

#Get Multiqc report in resultsDir/multiqc/medaka



