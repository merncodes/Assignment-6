# i) Load three Borreliella burgdorferi sequences from NCBI

# Specify unique NCBI identifiers to be applied in entrez_fetch() search
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

# rentrez package allows you to search for and download data from NCBI in R
library(rentrez)  

# entrez_fetch() downloads data from NCBI. 
  # db=nuccore : indicates that the database to search (db) is the NCBI nucleotide database 
  # id=ncbi_ids : Here the ID codes captured in the object "ncbi_ids" are downloaded
  # rettype="fasta" : 'rettype' specifies how the extracted NCBI data should be returned 
    # here we selected a FASTA file as the return format
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")

# ii) Inspect Bburg object
str(Bburg)

# iii. Separate the three sequences in Bburg
Sequences <- strsplit(Bburg, "\n\n")
print(Sequences)

# iv. convert Sequences list object to a data frame object
Sequences <-unlist(Sequences)

# v. Separate the sequences from the headers
  # this matches the entire header (> to \\n), but excluding \\n
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences <-data.frame(Name=header,Sequence=seq)

# vi. Remove newline characters
Sequences$Sequence <- gsub("\n", "\\1", Sequences$Sequence)

# vii. Export cleaned sequence dataframe to a csv file
write.csv(Sequences,"/Users/mh_mac/Documents/CLASSES/BIOL 432/Week 6/Rentrz/Sequences.csv", row.names=F)

