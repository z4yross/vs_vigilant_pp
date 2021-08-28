# Vigilant
Vigilant is a wrapper for the [nfcore/viralrecon](https://nf-co.re/viralrecon) pipeline, and a series of in-house scripts that aid in data visualization and generation of specific reports as required by the Colombian Network for Genome Surveillance of Sars-CoV-2.

## Pre-requisites 
Vigilant is heavily based on core Linux BASH core utils, such as AWK, and sed.
It also requires a functional ["jq"](https://stedolan.github.io/jq/)  utility to parse JSON files, which is not installed by default on Linux/Unix systems.   
It also makes use of a series of libraries our group has developed, such as [BioBash] (https://github.com/gibbslab/biobash) which  are included into Vigilant.

## Installing Vigilant
As for this version there is not installation, just clone the repository. 

## Running Vigilant
On the top level directory of cloned repository you will find a "vigilant.sh" script,
this is the main script that runs all other scripts and utilities.
This script requires 5 arguments:

-i Path to fastq_pass folder
-s Path to sequencing summary 
-q Path to sample sheet
-o Unique name for output dir.
-v Path to a file containig a description of variants of interest.

### Sample sheet
This is a simple text file with the following structure:

`sample,barcode
sample name, 01
another sample, 03
just another sample, 07
`
The whole idea is that you have two colums, first one for the sample name and second one for the particular barcode that identifies that sample.

### Output dir
The -o (output) option requires a non spaces name for the output dir. This is the place where all results files will be placed.

### Variants of interest file
This file is required for the final step of Vigilant, the creation of the INS report.
The idea is that for each entry in this file,  the results obtained from Nextclade are screened and if there is a coincidence the particular variant is registered in the report file. 
This is a single column file:
`
D253G
D614G
D796H
E484K
E484Q
E516Q
N501T
N501Y
N:T205I
...
`
If this option is not provided or if empty, Vigilant will use a internal list of variants of interest/concern.


The following is a sample command line:

`vigilant.sh -i fastq_pass/ -s sequencing_summary.txt  -q samplesheet.csv  -o myfirstrun -v ins_voci.lst`


