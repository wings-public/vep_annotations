#Use VEP Image as parent image
FROM ensemblorg/ensembl-vep:release_109.3
USER root
RUN apt-get -qq update && apt-get -qq -y install wget git tabix
USER vep
WORKDIR /opt/vep/src/ensembl-vep 
COPY . .
