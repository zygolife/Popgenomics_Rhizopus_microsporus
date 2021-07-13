Rscript scripts/fix_sample_strain_names.R
head -n 1 samples.csv > fixed_samples.csv
 grep SRR samp_update.csv  | cut -d, -f2,3 | perl -p -e 'chomp; my @row = split(",",$_); unshift @row, pop @row; $_=join(",",@row)."\n";' >> fixed_samples.csv
 grep -v -P '^(STRAIN|SRR)' samples.csv  >> fixed_samples.csv
 mv fixed_samples.csv samples.csv
