
#' @name read_vcf
#' @title Read VCF file to R.
#' @description Read block zipped VCF file to R.
#'
#' @import data.table
#'
#' @param VCF Path to target block zipped VCF file (*.vcf.gz)
#' @param chr The chromosome you wanted to read. Whole VCF file will be loaded by default.
#' @param from The specific region wanted to load on the target chromosome.
#' @param to The specific region wanted to load on the target chromosome.
#' @param infoOnly Only load variant information. Default: TRUE. Use FALSE if you want to load genotype data.
#'
#' @return VCF file read in data frame format
#' @export
read_vcf = function(VCF, chr=NULL, from=NULL, to=NULL, infoOnly=TRUE){

  # return dat
  dat = NULL

  # Header
  header = system(paste('tabix -H', VCF, "| grep '#CHROM'"), intern = T)
  header = strsplit(header, "\t")[[1]]
  header[1] = "CHROM"

  # If only read variant information
  if(infoOnly){
    infoOnly = 1:9
    header = header[infoOnly]
  }else{
    infoOnly = NULL
  }


  if(is.null(chr)){  # Read whole VCF file
    dat = fread(VCF, sep='\t', select=infoOnly)
    colnames(dat)[1] = "CHROM"

  }else if(!is.null(from) & !is.null(to)){ # Read target region

    # check if index file exist with the VCF file
    if(! file.exists(paste(VCF, "tbi", sep="."))){
      system(paste("tabix -p vcf", VCF))
    }

    # target region
    SCRIPT = paste("tabix", VCF, paste(chr, paste(from, to, sep="-"), sep=":"))
    dat = fread(text = system(SCRIPT, intern = TRUE), select=infoOnly)

    # add column names
    colnames(dat) = header

  }else{
    warning("Target region information is not complete")
  }

  return(dat)
}
