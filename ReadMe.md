===================================================================
 Coursera / Johns Hopkins - Getting and Cleaning Data Assignment
 Paul Lacock
 14 November 2020
===================================================================

The output for this assignment consists of the following files:

CodeBook.md

This is the codebook describing the data, data cleaning and output of this assignment.

run_analysis.R

User to set active directory to the directory containing the UCI HAR data files before running.

This script performs the following tasks:
- Download and unzip the source data for the assignment. (This code is commented out, assuming the user has already performed this task and has set the working directory to the directory containing the unzipped files)
- Combine the training and testing data sets (x_train.txt, y_train.txt, subject_train.txt, x_test.txt, y_test.txt and subject_test.txt), adding activity names (activity_labels.txt) to each of the rows, and using simplified versions of the feature names (features.txt) as columns names
- Select from the above data set, only the columns which contain averate and standard deviation information
- Save the above as mean_sd_data.txt
- Based on the above data set, extract a second data set containing the average values of each of the features, for each activity and each subject
- Save the above data set as averages.txt

mean_sd_data.txt

This is a text file (" " as separator) containing the first data set required for the assignment. It is the combination of the training and testing data, containing only the data in respect of means and standard deviations of the measurements taken in the study.

averages.txt

This is a text file (" " as separator) containing the second data set required for the assignment. It contains the average values for each of the features in mean_sd_data.txt, for each activity for each subject.

<end>
