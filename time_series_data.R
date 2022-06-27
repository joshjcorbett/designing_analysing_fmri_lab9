library(tidyverse)

part = "081202SWH"

dir = sprintf('~/documents/mphil/fMRI_Course/lexdec/%s/', part)

setwd(dir) 

#create dataframe from log file
log = readLines("lexdec_swh_1_INDEX.log")[-(1:5)]
df = matrix(ncol = 8)
df = data.frame((df))
for (i in log){
  cat(i, file = "temp")
  while (count.fields("temp", sep = "\t") < 8){
    i = paste(i, "NA", sep = "\t")
    cat(i, file = "temp")
  }
  t = read.table("temp", sep = "\t", col.names = c("X1", "X2", "X3", "X4", "X5", "X6", "X7", "X8"))
  df = rbind(df, t)
}

#find the adjusted start time, to subtract from all other timings
start_time_df <- df %>% filter(X4 == "Start:")
start_time <- start_time_df[1,5]


#only include rows that include info about stimulus presentation timing
stim_pres <- df %>% filter(X4 == "Stim:")

#STIMULUS TYPE 1 TIMING
#only include rows for the first stim type
stim_type1 <- stim_pres %>% filter(X5 == 1)

#get a column vector containing all the onset times of the first stimulus type
times_stim1 <- stim_type1[,1]

#subtract the start time and convert from ms to s
times_stim1 <- (times_stim1 - start_time)/1000
times_stim1 <- round(times_stim1, 1)

#convert timings to type char so it can be written into a txt file
times_stim1 <- as.character(times_stim1)

#create empty txt file 
file.create("timing_cond1.txt")

#add times to txt file
timing_cond1 <- file("timing_cond1.txt")

writeLines(times_stim1, timing_cond1)

#STIMULUS TYPE 1 TIMING
#only include rows for the first stim type
stim_type2 <- stim_pres %>% filter(X5 == 2)

#get a column vector containing all the onset times of the first stimulus type
times_stim2 <- stim_type2[,1]

#subtract the start time and convert from ms to s
times_stim2 <- (times_stim2 - start_time)/1000
times_stim2 <- round(times_stim2, 1)

#convert timings to type char so it can be written into a txt file
times_stim2 <- as.character(times_stim2)

#create empty txt file 
file.create("timing_cond2.txt")

#add times to txt file
timing_cond2 <- file("timing_cond2.txt")

writeLines(times_stim2, timing_cond2)

#BLOCK TIMING (currently done manually)

#enter block start times
block_times <- c(169272, 217775, 265761, 313764, 361767, 409770)
block_times <- t(block_times)

#subtract the start time and convert from ms to s
block_times <- (block_times - start_time)/1000
block_times <- round(block_times, 1)

#convert timings to type char so it can be written into a txt file
block_times <- as.character(block_times)

#create empty txt file 
file.create("timing_block.txt")

#add times to txt file
block_txt <- file("timing_block.txt")

writeLines(block_times, block_txt)
