library(RSQLite)
library(AnnotationForge)
options(stringsAsFactors = F)

# 具体流程
# 1. 读取locus和GO的对应关系
# 2. 构建RAP和MUS的ID对应关系


# GO  ---------------------------------------------------------------------
# 获取转录本和GO编号的关系
go_df <- read.table("./all.GOSlim_assignment",
                    sep = "\t", header = FALSE)
go_df <- go_df[,c(1,2,3,5)]
go_df$V3 <- ifelse(go_df$V3 == "C", "CC",
                   ifelse(go_df$V3 == "P", "BP",
                          ifelse(go_df$V3 == "F", "MF", "")))
colnames(go_df) <- c("GID","GO","ONTOLOGY","EVIDENCE")

# 为了方便, 只考虑基因水平上的GO
go_df$GID <- substr(go_df$GID, 1,14)


# RAP - MSU ---------------------------------------------------------------
RAP_MSU <- read.table("RAP-MSU_2019-06-11.txt",
                      sep = "\t")
colnames(RAP_MSU) <- c("RAP","MSU")

RAP_MSU <- tidyr::separate(RAP_MSU, MSU,
                        "GID", sep=",", extra="drop")

RAP_MSU <- RAP_MSU[! RAP_MSU$GID == "None" & ! RAP_MSU$RAP == "None", ]
RAP_MSU$GID <- substr(RAP_MSU$GID, 1,14)
RAP_MSU <- RAP_MSU[,c("GID", "RAP")]

# Duplication -------------------------------------------------------------
go_df <- go_df[!duplicated(go_df), ]
go_df <- go_df[,c(1,2,4)]
RAP_MSU <- RAP_MSU[!duplicated(RAP_MSU),]

# Build -------------------------------------------------------------------
file_path <- file.path( getwd())
makeOrgPackage(go=go_df,
               conversion = RAP_MSU,
               version = "0.1",
               maintainer = "xuzhougeng <xuzhougeng@163.com>",
               author="xuzhogueng <xuzhougeng@163.com>",
               outputDir = file_path,
               tax_id = "3702",
               genus = "oryza",
               species = "sativa",
               goTable = "go"

)
