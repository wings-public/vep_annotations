#!/bin/bash

set -e

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")

cd $BASEDIR


#Data sources related to VEP Plugins
CLINVAR_SRC="ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh38/clinvar.vcf.gz"
CLINVAR_IDX="ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh38/clinvar.vcf.gz.tbi"
EXAC_SRC="ftp://ftp.ensembl.org/pub/data_files/homo_sapiens/GRCh38/variation_genotype/ExAC.0.3.GRCh38.vcf.gz"
EXAC_IDX="ftp://ftp.ensembl.org/pub/data_files/homo_sapiens/GRCh38/variation_genotype/ExAC.0.3.GRCh38.vcf.gz.tbi"
GNOMAD_SRC="ftp://ftp.ensembl.org/pub/data_files/homo_sapiens/GRCh38/variation_genotype/gnomad.genomes.r2.0.1.sites.GRCh38.noVEP.vcf.gz"
GNOMAD_IDX="ftp://ftp.ensembl.org/pub/data_files/homo_sapiens/GRCh38/variation_genotype/gnomad.genomes.r2.0.1.sites.GRCh38.noVEP.vcf.gz.tbi"

GRCh38=true

function download()
{
    wget --tries 1000 -c $1
    wget -c $2
    #wget -c $1.tbi

    #wget $2.md5
    #wget $2.tbi.md5
    #md5sum -c *.md5
    #rm *.md5
}

if [ "$GRCh38" = true ]
then
    #bind_path="/opt/vep/.vep"
    plugin_src="$BIND_LOC/plugin_data_source/GRCh38/"
    mkdir -p $plugin_src
    cd $plugin_src


    echo "Initiate download data sources for Clinvar"
    download ${CLINVAR_SRC} ${CLINVAR_IDX}

    echo "Initiate download data sources for ExAC"
    download ${EXAC_SRC} ${EXAC_IDX}

    echo "Initiate download data sources for gnomAD"
    download ${GNOMAD_SRC} ${GNOMAD_IDX}

    cd $BASEDIR

fi
