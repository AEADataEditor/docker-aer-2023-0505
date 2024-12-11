# R 4.1.2 released November 2021. 
# Pass variables into the file
ARG VERSION=4.4.1
ARG TYPE=verse

FROM rocker/$TYPE:$VERSION

COPY setup.R .
RUN R CMD BATCH setup.R

# Add Julia
# This happens in user-space
USER rstudio
WORKDIR /home/rstudio

ARG JULIAVER=1.10.2

RUN  curl -fsSL https://install.julialang.org | sh -s -- -y &&\
     /home/rstudio/.juliaup/bin/juliaup add $JULIAVER &&\
     /home/rstudio/.juliaup/bin/juliaup default $JULIAVER

# Revert back to root
USER root


