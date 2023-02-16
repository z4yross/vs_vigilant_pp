FROM ubuntu:latest
SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y \
    wget \
    git \
    openjdk-11-jdk \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# set env variables
ENV WORK_PATH "/storage/workspace/"
ENV SAMPLE_SHEET_PATH "/storage/sample_sheet.csv"
ENV FASTQ_PASS_PATH "/storage/fastq_pass/"
ENV SUMMARY_PATH "/storage/sequencing_summary.txt"
ENV OUT_PATH "/storage/out"
ENV NAME "nextflow-test-pod"
ENV CLAIM_NAME "custom-claim-nextflow"
ENV CONFIG_PATH "/storage/viralrecon/"

ENV MAX_MEMORY "48GB"
ENV MAX_CPUS "12"

# ENV NXF_CONDA_ENABLED "true"

ENV MEDAKA_MODEL="${CONFIG_PATH}r941_min_high_g360_model.hdf5"
# ENV NXF_CONDA_CACHEDIR="/home/conda_cache"

# RUN apk update && \
#     apk add sudo shadow

# RUN chmod 777 /var/run/docker.sock
# RUN chmod 777 /var/run/docker.sock
# RUN echo '%docker ALL=(ALL) ALL' > /etc/sudoers.d/docker
# RUN addgroup -S docker && adduser -S docker -G docker
# USER docker

# RUN apk update && apk add git wget bash openjdk11

# SHELL ["/bin/bash", "-c"]

# install nextflow wget
WORKDIR /home/nextflow
RUN wget -qO- https://get.nextflow.io | bash
RUN chmod +x nextflow
RUN /home/nextflow/nextflow self-update

WORKDIR ${WORK_PATH}

CMD git clone https://github.com/nf-core/viralrecon.git ${WORK_PATH}viralrecon; \
    /home/nextflow/nextflow run ${WORK_PATH}viralrecon/main.nf --input ${SAMPLE_SHEET_PATH} \
    -c "${CONFIG_PATH}custom.config" \
    --platform nanopore \
    --genome 'MN908947.3' \
    --primer_set_version 3 \
    --fastq_dir ${FASTQ_PASS_PATH} \
    --artic_minion_caller medaka \
    --artic_minion_medaka_model ${MEDAKA_MODEL} \
    --outdir ${OUT_PATH} \
    --max_memory ${MAX_MEMORY} \
    --max_cpus ${MAX_CPUS} \
    -profile docker \
    ${RESUME}


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



