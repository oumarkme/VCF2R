
# vcf2r

[SAMtools](https://www.htslib.org/) need to be installed before using this package. This package is only tested in UNIX-like system (Linux and MacOS). For Windows users, you may be able to use Windows Subsystem for Linux (WSL), but this is not tested.

## Install SAMtools

-   If you are a Linux user, you can install SAMtools by following the provided [instructions](https://www.htslib.org/download/).
-   Mac users can install using the source file or via [Homebrew](https://brew.sh/) using this script.

```
brew install samtools
```

Verify if the software has been installed correctly.

```
samtools --version
```

## Install vcf2r package

This package is NOT submitted to CRAN; thus, you may only install through GitHub.

```
devtools::install_github("oumarkme/vcf2r", dependencies = TRUE, force = TRUE)
library(vcf2r)
```
