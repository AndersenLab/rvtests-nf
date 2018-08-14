#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

library(tidyverse)

pheno <- readr::read_tsv(args[1])

# split file for each trait
for(t in unique(pheno$trait)) {
    traits <- pheno %>%
        dplyr::select(strain, trait, value) %>%
        dplyr::filter(trait == t) %>%
        tidyr::spread(trait, value) %>%
        dplyr::mutate(Fam = "elegans", Sample = strain, Paternal = 0, Maternal = 0, Sex = 2)%>%
        dplyr::select(Fam:Sex, t)
    
    # take care of NA values
    traits[is.na(traits)] <- -9
    
    # save file
    write.table(traits, glue::glue("{t}.ped"), quote = F, col.names = F, row.names = F)
}
