FROM ubuntu:latest

# Install dependencies
RUN sudo apt-get install jq

# Current working directory
RUN mkdir /home/vigilant
WORKDIR /home/vigilant

# Copy files
COPY ./ ./

# RUN vigilant.sh
RUN /bin/bash -c "./vigilant.sh \
    -i /vigilant/fastq_pass \
    -s /vigilant/summary/sequencing_summary.txt \
    -q /vigilant/sample_sheet/shample_sheet.csv \
    -o /vigilant/out \
    -v /vigilant/variants/ins_voci.lst"


