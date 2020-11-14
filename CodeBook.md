## ===========================================================================
##
## Coursera / Johns Hopkins - Getting and Cleaning Data Assignment
##
## Paul Lacock - 14 November 2020
##
## CODEBOOK
##
## ===========================================================================

The data sets produced for this assignment are derived from the Human Activity Recognition Using Smartphones Dataset created and described by Anguita et al [1]. A brief summary of that study is provided in the STUDY DESIGN section below, followed by details of the data extraction and manipulation performed as part of this assignment.  The output from this assignment is described in the CODEBOOK section that follows. 

============
STUDY DESIGN
============

--------------
Original Study
--------------

The following description is adapted from Anguita:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.The features selected for this database are derived from accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the prefix 'f' to indicate frequency domain signals). 

----------
This Study
----------

All of the steps carried out to produce both output data sets from this assignment are coded in the R script "run_analysis.R". Instructions for running this script are contained in the accompanying markdown file "README.txt".

This study has derived two data sets from the data output from Anguita. The data is obtained from the .zip file located at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip [last accessed on 28 May 2018]

This file is downloaded to the current active working directory and unzipped into that directory without any change to its internal folder structure or filenames.

Data Set 1 - "mean_sd_data.txt"
-------------------------------

This data set contains a subset of the features data (variables/columns) from the original study, with the subset defined as all features which represent a mean or standard deviation of an element of the processed signals data. 

The features data produced by Anguita is decomposed (by them) into several subsets stored in separate files. Firstly, the feature (variable or column) names are stored in "features.txt". Secondly the features data itself is split into training and test sets, and these in turn are comprised of three files each:
X_train.txt - containing the features data without any row or column headings
y_train.txt - containing the activity element of the row headings, and
subject_train.txt - containing the subject element of the row headings,

... and similarly for the test data.

The data from the three "train" files for the training data were read into separate data frames. Column names were assigned to each of the three data frames, with the column names for the features data frame being set to tidied versions of the feature names set out in the "features.txt" file. cbind() was then used to combine these three data frames into a single data frame representing the training data ("train_data"). A similar process was followed for the test data ("test_data"). The training and test data sets contain 7352 and 2947 observations respectively, and both contain 563 variables (comprised of "activityID", "subjectID" and 561 feature variables).

rbind() was then used to concatenate these two data frames into a single data frame ("all_data") containing both the training and test data. As expected, this data frame contains 563 variables and 10299 observations.

A column was added to the above data frame representing the name of the activity associated with each observation (row). This was done by applying merge() to the features data frame and the data frame of activity names and activity IDs read in from "activity_labels.txt".

The next step was to extract the features representing means and standard deviations of the measurements derived from the signal data. The naming convention of the features data conveniently meant that all relevant features could be identified by searching for "mean" or "std" in the feature names. 79 feature names (out of 561) contain the substring "mean" or "std". We also searched for "average", "standard" and "sd" in case the naming convention extended to include these substrings, but no matches were found.

Following this strategy resulted in the selection of features which include the substring "meanFreq". We chose to include these in the data set even though they don't strictly speaking represent the mean of any particular element of the processed signals data (as specified in the assignment brief), however they do represent the mean frequency of the signals in respect of an observation. If not needed it can be ignored by users of this data. Alternatively the data cleaning can be run using the alternative definition of the vector "ofinterest" which excludes "meanFreq" features - currently commented out in line ?????:
ofinterest <- (regexpr("mean", colnames(all_data))>0 & regexpr("meanFreq", colnames(all_data))<0) | regexpr("std", colnames(all_data))>0

The resulting data frame ("mean_sd_data") contains 81 variables (comprised of "activity", "subjectID" and 79 feature variables). This data frame is then written to the file "mean_sd_data.txt".

The processed inertial signal data has not been included in this data set as it does not include any data representing a mean or standard deviation of any observations (it is the underlying signal data in respect of which means, standard deviations and many other features have been calculated).


Data Set 2 - "averages.txt"
---------------------------



===========
CODEBOOK
===========

mean_sd_data.txt
----------------

Each observation (10299 rows) contains the following variables:

activity - the name of the activity to which the features relate.
subjectID - tactor identifying the human subject to which the features relate. Possible values are the integers [1:30].
 
79 feature variables, all of type numeric:

tBodyAcc_(mean|std)_(X|Y|Z) - i.e. denoting 6 different variables, e.g. tBodyAcc_mean_Z
tGravityAcc_(mean|std)_(X|Y|Z)
tBodyAccJerk_(mean|std)_(X|Y|Z)
tBodyGyro_(mean|std)_(X|Y|Z)
tBodyGyroJerk_(mean|std)_(X|Y|Z)
tBodyAccMag_(mean|std)
tGravityAccMag_(mean|std)
tBodyAccJerkMag_(mean|std)
tBodyGyroMag_(mean|std)
tBodyGyroJerkMag_(mean|std)

fBodyAcc_(mean|std|meanFreq)_(X|Y|Z)
fBodyAccJerk_(mean|std|meanFreq)_(X|Y|Z)
fBodyGyro_(mean|std|meanFreq)_(X|Y|Z)
fBodyAccMag_(mean|std|meanFreq)
fBodyAccJerkMag_(mean|std|meanFreq)
fBodyGyroMag_(mean|std|meanFreq)
fBodyGyroJerkMag_(mean|std|meanFreq)

Where the different components of the variable names have the following interpretation:

t - time domain signals
f - frequency domain signals

Acc - acceleration signal
Body|Gravity - body and gravity elements of the accerlation signal
Gyro - gyroscope signal
Jerk - jerk signal derived from body linear acceleration and angular velocity
Mag - magnitude calculated using the Euclidean norm

mean - mean value of the 128 signal values recorded (or derived from recorded values)
std - standard deviation of the 128 signal values recorded/derived
meanFreq - weighted average of the frequency components to obtain a mean frequency

X|Y|Z - on the X, Y and Z axes respectively


averages.txt
------------

Each observation in this file (180 rows) contains the following variables:

activity - the name of the activity to which the features relate.
subjectID - tactor identifying the human subject to which the features relate. Possible values are the integers [1:30].
 
79 feature variables, all of type numeric, which follow the same naming convention as the features in mean_sd_data.txt,
except that they are prefixed with "ave_"

Each "ave_" feature value in this data set represents the average of the respective feature values, grouped across both 
"activity" and "subjectID". E.g. "ave_tBodyAcc_mean_X" in the row with "activity"=WALKING and "subjectID"= 1 represents 
the average value of tBodyAcc_mean_X across all observations for subject 1 peforming the WALKING activity.

We have 180 (30 * 6) observations as there are 30 subjects who have each recorded at least one set of signals for each 
of the 6 actvities.

==========
References
==========

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
