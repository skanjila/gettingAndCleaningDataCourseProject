# Getting and Cleaning Data

## Course Project Readme
## March 2015

##Course Project Instructions
You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## To work on this course project:

1. Download the data source and store in a local folder called ```UCI HAR Dataset``` folder.
2. Create the R script ```run_analysis.R``` in the parent directory of ```UCI HAR Dataset```, then set the correct working directory by using setwd
3. Load up the R source code by typing ```source("run_analysis.R")```, the script will load up the training and test data and ultimately create a clean data set called ```tiny_data.txt``` in the working directory.

## Dependencies

```run_analysis.R``` automatically installs ```reshape2``` and ```data.table```. 
