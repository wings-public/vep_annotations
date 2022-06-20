#Use VEP Image as parent image
FROM ensemblorg/ensembl-vep:release_105.0
USER root
RUN apt-get -qq update && apt-get -qq -y install wget git
USER vep
COPY . .
