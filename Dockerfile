FROM nfcore/base

RUN mkdir /home/vigilant
WORKDIR /home/vigilant

COPY ./viralrecon/ ./

ARG SAMPLE_SHEET_PATH
ARG FASTQ_PASS_PATH
ARG SUMMARY_PATH
ARG OUT_PATH

ARG MEDAKA_MODEL="./viralrecon/r941_min_high_g360_model.hdf5"

ARG PARAMS = "--input ${SAMPLE_SHEET_PATH} \
    --platform nanopore \
    --genome 'MN908947.3' \
    --primer_set_version 3 \
    --fastq_dir ${FASTQ_PASS_PATH} \
    --artic_minion_caller medaka \
    --artic_minion_caller_model ${MEDAKA_MODEL} \
    --sequencing_summary ${SUMMARY_PATH} \
    --outdir ${OUT_PATH}"

CMD ["nextflow", "run", "nf-core/viralrecon", ${PARAMS}]


# # Install dependencies
# RUN sudo apt-get install jq

# # Current working directory
# RUN mkdir /home/vigilant
# WORKDIR /home/vigilant

# # Copy files
# COPY ./ ./

# # RUN vigilant.sh
# RUN /bin/bash -c "./vigilant.sh \
#     -i /vigilant/fastq_pass \
#     -s /vigilant/summary/sequencing_summary.txt \
#     -q /vigilant/sample_sheet/shample_sheet.csv \
#     -o /vigilant/out \
#     -v /vigilant/variants/ins_voci.lst"


