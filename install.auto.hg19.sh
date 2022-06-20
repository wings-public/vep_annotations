#!/bin/bash

set -e

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")

cd $BASEDIR


#Data sources related to VEP Plugins
CLINVAR_SRC="ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh37/clinvar.vcf.gz"
CLINVAR_IDX="ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh37/clinvar.vcf.gz.tbi"
EXAC_SRC="ftp://ftp.ensembl.org/pub/data_files/homo_sapiens/GRCh37/variation_genotype/ExAC.0.3.GRCh37.vcf.gz"
EXAC_IDX="ftp://ftp.ensembl.org/pub/data_files/homo_sapiens/GRCh37/variation_genotype/ExAC.0.3.GRCh37.vcf.gz.tbi"
GNOMAD_SRC="ftp://ftp.ensembl.org/pub/data_files/homo_sapiens/GRCh37/variation_genotype/gnomad.genomes.r2.0.1.sites.noVEP.vcf.gz"
GNOMAD_IDX="ftp://ftp.ensembl.org/pub/data_files/homo_sapiens/GRCh37/variation_genotype/gnomad.genomes.r2.0.1.sites.noVEP.vcf.gz.tbi"

function download()
{
    wget --tries 10000 -c $1
    wget -c $2

    #wget $2.md5
    #wget $2.tbi.md5
    #md5sum -c *.md5
    #rm *.md5
}

GRCh37=true

if [ "$GRCh37" = true ]
then
    #bind_path="/opt/vep/.vep"
    plugin_src="$BIND_LOC/plugin_data_source/GRCh37/"
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
