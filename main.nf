#! usr/bin/env nextflow

//params.in - required
date = new Date().format( 'yyyyMMdd' )
params.out = "$date"
params.vcf = "/projects/b1059/analysis/WI-20180527/variation/WI.20180527.hard-filter.vcf.gz"
params.refflat = "/projects/b1059/projects/Katie/data/refFlat.ws245.txt"
params.freqUpper = 0.05
params.freqLower = 0.003

// Make the phenotype .ped file required for rvtests
process makeped {
	input:
		file 'infile' from Channel.fromPath(params.in)

	output:
		file("*.ped") into ped_files


	"""
	Rscript --vanilla "${workflow.projectDir}/makeped.R" "${infile}"

	"""
}

process rvtest {
	cpus 4
	tag { ped }
	publishDir "analysis-${params.out}/", mode: 'copy'

	input:
		file ped from ped_files.flatten()

	output:
		file("*.assoc") into burden_files


	"""
	${workflow.projectDir}/rvtests/executable/rvtest --pheno $ped --out $ped --inVcf ${params.vcf} --freqUpper ${params.freqUpper} --freqLower ${params.freqLower} --geneFile ${params.refflat}  --vt price --kernel skat

	"""
}