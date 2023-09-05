
#' @name read_line
#' @title Read single variant from VCF file to R.
#' @description Read single variant from block zipped VCF file to R.
#'
#' @import stringr
#'
#' @param VCF Path to target block zipped VCF file (*.vcf.gz)
#' @param chr The chromosome you wanted to read. Whole VCF file will be loaded by default.
#' @param pos The specific positions wanted to load on the target chromosome.
#' @param infoOnly Only load variant information. Default: TRUE. Use FALSE if you want to load genotype data.
#'
#' @return VCF file read in data frame format
#' @export
read_line = function(VCF, chr=NULL, pos=NULL, infoOnly=TRUE){

  # check if index file exist with the VCF file
  if(! file.exists(paste(VCF, "tbi", sep="."))){
    cat("Index file not found. Generate index file for random reading.")
    system(paste("tabix -p vcf", VCF))
  }

  # Read line
  SCRIPT = paste("tabix", VCF, paste0(chr, ":", pos, "-", pos))
  dat = str_split(system(SCRIPT, intern = TRUE), "\t", simplify = TRUE)

  # If only read variant information
  if(infoOnly) dat = dat[, 1:9]

  # return result
  return(dat)
}
