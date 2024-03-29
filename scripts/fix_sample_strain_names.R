library(readr)
library(tidyverse)
samp <- read_csv("samples.csv")
sra <- read_tsv("lib/PRJNA526061_SRA.tab")
colnames(samp) <- c("RUN","FILEBASE")
comb <- full_join(samp,sra,by="RUN")
write_csv(comb,"samp_update.csv")
