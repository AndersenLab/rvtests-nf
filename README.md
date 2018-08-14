# rvtests-nf
Nextflow pipeline for burden testing (variable threshold and skat) using zhanxw/rvtests

## Requirements
Must run on linux platform (works on Quest). Also requires one R package, `tidyverse`
```
install.packages("tidyverse")
```
Also requires nextflow installation. Check out this [help page](https://www.nextflow.io/docs/latest/getstarted.html) for more info.
```
wget -qO- https://get.nextflow.io | bash
```

## Usage
```
nextflow run AndersenLab/rvtests-nf --in='<filename.tsv>'
```

## Input
Input file is a `.tsv` file with three columns: **strain**, **trait**, and **value**

| strain | trait | value |
| --- | --- | --- |
| JU258 | latitude | 32.73 |
| ECA640 | latitude | 34.065378 |
| ... | ... | ... |
| ECA250 | latitude |	34.096 |

## Optional parameters
rvtests requires a vcf and refflat file as input, however for use in the Andersen Lab I have defaulted these files to their respective locations on Quest. You can change them as necessary.

| params | default | options | explanation |
| --- | --- | --- | --- |
| **vcf** | WI.20180527.hard-filter.vcf.gz | any VCF file | Most recent VCF for 330 isotypes *C. elegans* |
| **refflat** | refFlat.ws245.txt | any refFlat file | current gene file for *C. elegans* |
| out | date | any name | will be the name of the output folder with all your files |
| freqUpper | 0.05 | any number | Specify upper minor allele frequency bound to be included in analysis |
| freqLower | 0.003 | any number | Specify lower minor allele frequency bound to be included in analysis |

## Example with options
```
nextflow run AndersenLab/rvtests-nf --in='input.tsv' --freqLower='0.001'
```
