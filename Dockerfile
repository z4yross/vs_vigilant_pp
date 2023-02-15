FROM continuumio/miniconda3:latest

SHELL ["/bin/bash", "-c"]

# RUN usermod -u 1000 /home/conda_cache
# RUN usermod -G staff /home/conda_cache

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get -y install \
    # openjdk-11-jre-headless \
    wget git make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io

ENV PATH=$PATH:/app/bin
ENV CONDA_ALWAYS_YES true

RUN conda install -c anaconda openjdk

# COPY ./viralrecon/ /home/config/

# install nextflow wget
WORKDIR /home/nextflow
RUN wget -qO- https://get.nextflow.io | bash
RUN chmod +x nextflow
RUN /home/nextflow/nextflow self-update

# RUN conda update --all

# biocommons conda channels
RUN conda config --add channels defaults
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge
# RUN conda config --set allow_conda_downgrades true
RUN conda config --set channel_priority false
# RUN conda install --no-channel-priority conda=4.6.14
# RUN conda config --set channel_priority false

# install pangolin github
# RUN git clone https://github.com/cov-lineages/pangolin.git /home/pangolin
# RUN conda env create -f /home/pangolin/environment.yml -p /home/conda_cache/nextflow
# RUN conda create -n nextflow
# SHELL ["/home/conda_cache/nextflow/bin/conda", "/bin/bash", "-c"]
# RUN conda install -c bioconda nextflow
# RUN conda install -c bioconda -c conda-forge -c defaults pangolin

# RUN conda install -c bioconda -c conda-forge -c defaults pangolin

# RUN /home/conda_cache/nextflow/bin/pip install /home/pangolin

# install gcc
# RUN conda install pysam
# RUN conda install -c conda-forge gcc
# RUN pip install Cython
# install nanoplot
# RUN mkdir /home/NanoPlot
# # RUN wget https://raw.githubusercontent.com/bioconda/bioconda-recipes/master/recipes/nanoplot/meta.yaml -O /home/NanoPlot/environment.yml
# RUN git clone https://github.com/wdecoster/NanoPlot.git /home/NanoPlot
# WORKDIR /home/NanoPlot
# RUN python setup.py install
# RUN conda install -c bioconda nanoplot

# install mosdepth
# RUN conda install mosdepth

# SHELL ["conda", "run", "--no-capture-output", "-n", "nextflow", "/bin/bash", "-c"]
# clone viralrecon pipeline
RUN git clone https://github.com/nf-core/viralrecon.git /home/viralrecon
WORKDIR /home/context

# set env variables
ENV SAMPLE_SHEET_PATH "/storage/sample_sheet.csv"
ENV FASTQ_PASS_PATH "/storage/fastq_pass/"
ENV SUMMARY_PATH "/storage/sequencing_summary.txt"
ENV OUT_PATH "/storage/out"

ENV MAX_MEMORY "48GB"
ENV MAX_CPUS "12"

ENV NXF_CONDA_ENABLED "true"

ENV MEDAKA_MODEL="/home/config/r941_min_high_g360_model.hdf5"
ENV NXF_CONDA_CACHEDIR="/home/conda_cache"

CMD /home/nextflow/nextflow run /home/viralrecon/main.nf --input ${SAMPLE_SHEET_PATH} \
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
    -profile conda,docker \
    -with-conda  \
    --enable_conda \
    --skip_mosdepth \
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



