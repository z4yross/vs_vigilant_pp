FROM nextflow/nextflow
# SHELL ["/bin/bash", "-c"]

# RUN apk update && \
#     apk add sudo shadow

# RUN chmod 777 /var/run/docker.sock
# RUN chmod 777 /var/run/docker.sock
# RUN echo '%docker ALL=(ALL) ALL' > /etc/sudoers.d/docker
# RUN addgroup -S docker && adduser -S docker -G docker
# USER docker

# RUN apk update && apk add git wget bash openjdk11

# SHELL ["/bin/bash", "-c"]

# # install nextflow wget
# WORKDIR /home/nextflow
# RUN wget -qO- https://get.nextflow.io | bash
# RUN chmod +x nextflow
# RUN /home/nextflow/nextflow self-update

# RUN git clone https://github.com/nf-core/viralrecon.git /home/viralrecon
WORKDIR /home/context

# set env variables
ENV SAMPLE_SHEET_PATH "/storage/sample_sheet.csv"
ENV FASTQ_PASS_PATH "/storage/fastq_pass/"
ENV SUMMARY_PATH "/storage/sequencing_summary.txt"
ENV OUT_PATH "/storage/out"

ENV MAX_MEMORY "48GB"
ENV MAX_CPUS "12"

# ENV NXF_CONDA_ENABLED "true"

ENV MEDAKA_MODEL="/home/config/r941_min_high_g360_model.hdf5"
# ENV NXF_CONDA_CACHEDIR="/home/conda_cache"

CMD nextflow kuberun nf-core/viralrecon --input ${SAMPLE_SHEET_PATH} \
    -c /home/config/custom.config \
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
    # -with-docker \
    # --skip_mosdepth \
    ${RESUME}
    # --nextclade_dataset false \
    # --nextclade_dataset_tag false
    # -profile docker


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



