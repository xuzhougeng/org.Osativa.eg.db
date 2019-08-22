[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3374105.svg)](https://doi.org/10.5281/zenodo.3374105)

# org.Osativa.eg.db

## Introduction

The Orazy sativa simple organism annotation for GO enrichment analysis, and ID conversion between MSU and RAP

水稻的物种注释包, 方便用在clusterProfiler里进行GO富集分析, 以及MSU和RAP-DB之间的ID转换

## Installation

Required:

- R > 3.5.1
- AnnotationDbi > 1.44.0 

```r
install.packages("https://github.com/xuzhougeng/org.Osativa.eg.db/releases/download/v0.01/org.Osativa.eg.db.tar.gz", 
    repos = NULL, 
    type="source")
```

## Usage

Load the packages

```r
library(org.Osativa.eg.db)
org <-org.Osativa.eg.db
```

Convert RAP-DB ID to MSU LOC-ID

```r
# rap_id: RPA-DB ID
map_id <- AnnotationDbi::select(org, keys = rap_id, 
                                columns=c("GID"), keytype = "RAP")
```

Convert MSU LOC-ID to RAP-DB ID

```r
# msu_id: MSU ID
map_id <- AnnotationDbi::select(org, keys = rap_id, 
                                columns=c("RAP"), keytype = "GID")       
```

GO enrichment anlysis using clusterProfiler enrichGO

```r
ego <- enrichGO(rap_id,
        OrgDb = org,
        keyType = "RAP",
        ont="BP")
```

For more information about clusterProfiler, please go to <https://guangchuangyu.github.io/software/clusterProfiler/documentation/>

## Citation

If you use the org.Osativa.eg.db in your project, it is very nice for you to cite it 

xuzhougeng. (2019, August 22). xuzhougeng/org.Osativa.eg.db v0.01 (Version v0.01). Zenodo. http://doi.org/10.5281/zenodo.3374105
