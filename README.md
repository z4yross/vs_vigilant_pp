# Vigilant
Vigilant is a wrapper for the [nfcore/viralrecon](https://nf-co.re/viralrecon) pipeline, and a series of in-house scripts that aid in data visualization and generation of specific reports as required by the Colombian Network for Genome Surveillance of Sars-CoV-2.

## Running Vigilant
Vigilant is heavily based on core Linux BASH core utils, such as AWK, and sed.
It also requires a functional ["jq"](https://stedolan.github.io/jq/)  utility to parse JSON files, which is not installed by default on Linux/Unix systems.   
It also makes use of a series of libraries our group has developed (i.e [BOBASH] (https://github.com/gibbslab/biobash)) but are included into Vigilant.
