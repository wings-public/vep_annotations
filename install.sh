#!/bin/bash

usage="$(basename "$0") [-g <GRCh37,GRCh38>]

where:
    -g  GRCh37,GRCh38
    "

unset OPTARG
unset OPTIND
export LC_ALL=C

GENOMEBUILD="GRCh38"

BASEDIR=$(dirname "$SCRIPT")

while getopts g: option
do
case "${option}"
in
g) BUILD=${OPTARG};;
\?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
esac
done


if [[ $BUILD != "GRCh37" &&  $BUILD != "GRCh38" && $BUILD != "GRCh37,GRCh38" ]]; then
    echo "Unknown build input provided for $BUILD. Please provide GRCh37 or GRCh38."
    echo $usage
    exit 1
fi

HG19="install.auto.hg19.sh"
HG38="install.auto.hg38.sh"
SCRIPT1="$BASEDIR/$HG19"
SCRIPT2="$BASEDIR/$HG38"

if [[ $BUILD == "GRCh37" ]];then
    perl INSTALL.pl -a cfp -s homo_sapiens_refseq -y GRCh37 -g all
    echo "Installing data sources for Plugins"
    bash "$SCRIPT1"
fi

if [[ $BUILD == "GRCh38" ]];then
    perl INSTALL.pl -a cfp -s homo_sapiens_refseq -y GRCh38 -g all
    echo "Installing data sources for Plugins"
    bash "$SCRIPT2"
fi

if [[ $BUILD == "GRCh37,GRCh38" ]];then
    echo "$BUILD"
    echo "Both assembly option activated"
    perl INSTALL.pl -a cfp -s homo_sapiens_refseq -y GRCh37 -g all
    perl INSTALL.pl -a cfp -s homo_sapiens_refseq -y GRCh38 -g all
    echo "Installing data sources for Plugins for GRCh37"
    echo "$SCRIPT1"
    bash "$SCRIPT1"
    echo "Installing data sources for Plugins for GRCh38"
    echo "$SCRIPT2"
    bash "$SCRIPT2"
fi


# Install any other plug-in data sources
LOF_SRC="https://github.com/Ensembl/VEP_plugins/blob/release/100/LoFtool_scores.txt"
plugin_src1="$BIND_LOC/Plugins"

cd $plugin_src1
wget $LOF_SRC
cd $BASEDIR

echo "VEP Cache,Plugins and related data sources Installation Completed"
