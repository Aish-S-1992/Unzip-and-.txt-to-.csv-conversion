###This code unzips a .zip file and then converts the selected unzipped files to 
###.csv. This code requires change only at line # 10 i.e. when setting your
###working directory

rm(list = ls())

cat("\014")

###The working directory will need to be updated and set as the folder which contains the latest Master.zip 
wd <- setwd("C:/Users/aishwarya.sharma/OneDrive - insidemedia.net/Dell Lattitude - 5300/Unilever Daria/New folder")


#Loading required packages 
# install.packages("utils")

library(stringr)

library(utils)

library(dplyr)

#Mention the files to unzip below. However, if a change is made to them 
#i.e. another mapping file is added or anything's deleted it'd require a
#change in the Alteryx Workflows as well

files_to_unzip <- c("advertiser.txt", 
"brand.txt",
"category.txt",
"media_medtype.txt",
"oproduct.txt",
"parent.txt",
"product.txt")

#Unzipping the files in your set working directory
unzip("Master.zip", files = files_to_unzip)

#Loading the unzipped file names from the directory 
df <- as.data.frame(dir())

#Filtering file names only which contain .txt extension
df <- dplyr::filter(df,grepl(".txt",df$`dir()`))

#Converting .txt files to .csv
for (i in 1:nrow(df)){
temp <- read.table(df[i,], header = FALSE, sep = ",")
write.table(temp,file = paste(wd,str_replace(df[i,],".txt",".csv") ,sep ="/"), sep = ",",row.names = F, col.names = F)
}