## ===========================================================================
##
## Coursera / Johns Hopkins - Getting and Cleaning Data Assignment
##
## Paul Lacock
## 14 November 2020
##
## BEFORE RUNNING SET WD TO THE FOLDER IN WHICH YOU WANT THE SCRIPT TO RUN
##
## ===========================================================================

## Capture the current working directory (set by user prior to running script)
## setwd("C:/Users/Paul/Documents/R/data/Coursera/DataScience/GetAndCleanData2/")
wd_base <- getwd()

## DOWNLOAD SOURCE DATA AND UNZIP, IF REQUIRED
## -------------------------------------------

## Set url and file name constants
##data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##zipfilename <- "UCI_HAR_Dataset.zip"

## Download the raw data zip file
##download.file(data_url, destfile=zipfilename)
## Unzip the raw data
##unzip(paste0(wd_base, "/", zipfilename))
## Rename 'root' unzip directory to follow naming convention
##file.rename("UCI HAR Dataset", "UCI_HAR_Dataset")

##wd_base <- paste0(wd_base, "/UCI_HAR_Dataset")
##setwd(wd_base)

## CREATE TIDY DATASET 1
## -------------------------------------------

## Specify data subfolders
wd_train <- paste0(wd_base, "/train")
wd_test <- paste0(wd_base, "/test")

## Read relevant files from the 'root' directory of the unzipped data
feat_list <- read.table("features.txt", stringsAsFactors = FALSE)
feat_list <- feat_list[,2] ## Select just the col with the feature name
## Remove '()' otherwise they make the feature column names untidy later
feat_list <- gsub("[()]", "", feat_list)
## Convert '-' to '_' otherwise they get converted to '.' in colnames.
feat_list <- gsub("[-]", "_", feat_list)
## Create table of activity labels
act_labels <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
colnames(act_labels) <- c("activityID", "activity")

## Read relevant files from the train data folder
setwd(wd_train)
train_features <- read.table("X_train.txt", col.names = feat_list)
train_activities <- read.table("y_train.txt", col.names = "activityID")
train_subjects <- read.table("subject_train.txt", col.names = "subjectID")

## Read relevant files from the test data folder
setwd(wd_test)
test_features <- read.table("X_test.txt", col.names = feat_list)
test_activities <- read.table("y_test.txt", col.names = "activityID")
test_subjects <- read.table("subject_test.txt", col.names = "subjectID")

## Build complete training and test data frames
train_data <- cbind(train_activities, train_subjects, train_features)
test_data <- cbind(test_activities, test_subjects, test_features)

## Append training and test data frames
all_data <- rbind(train_data, test_data)

## Add activity name to data frame
all_data <- merge(all_data, act_labels)

## Identify colummns containing features relating to mean and standard 
## deviation and select relevant columns of data from 'all_data'
## I.e. features with names including "mean" (but not "meanFreq") OR including "std"
ofinterest <- regexpr("mean", colnames(all_data))>0 | regexpr("std", colnames(all_data))>0
## ofinterest <- (regexpr("mean", colnames(all_data))>0 & regexpr("meanFreq", colnames(all_data))<0) | regexpr("std", colnames(all_data))>0
mean_sd_data <- all_data[, c("activity", "subjectID", colnames(all_data)[ofinterest])]

## Write the output to .txt file
setwd(wd_base)
write.table(mean_sd_data, "mean_sd_data.txt", row.names = FALSE)

## CREATE TIDY DATASET 2
## -------------------------------------------
## Calculate the averages and save in another file
library(dplyr)
grouped <- group_by(mean_sd_data, activity, subjectID)
averages <- summarise_all(grouped, mean)

write.table(averages, "averages.txt", row.names = FALSE)
