## This is an R script to do the following tasks:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Create one R script called run_analysis.R that does the following:
## @author Saikat Kanjilal

# check for the existence of the appropriate packages
# and install them if we need
if (!require("data.table")) {
    install.packages("data.table")
}

if (!require("reshape2")) {
    install.packages("reshape2")
}

require("data.table")
require("reshape2")

# we first load all the test data
# and establish the column names
xDFTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
yDFTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjectDFTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
featureSet <- read.table("./UCI HAR Dataset/features.txt")[,2]
names(xDFTest) = featureSet

# we load the resultant activity labels into a dataframe
activityLabelDF <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# we build a filter that extracts only the mean and standard deviation
# and then we use the filter to reap the measurements we want
featureFilter <- grepl("mean|std", featureSet)
xDFTest = xDFTest[,featureFilter]


# we load all the resultant feature data
yDFTest[,2] = activityLabelDF[yDFTest[,1]]
names(yDFTest) = c("Activity_ID", "Activity_Label")
names(subjectDFTest) = "subject"


# we columnWise combine all the data together to represent
# our test data
testData <- cbind(as.data.table(subjectDFTest), yDFTest, xDFTest)



# ok we're done with the test data
# we now go about loading the training data and the subject
# data associated with training
xDFTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
yDFTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjectDFTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(xDFTrain) <- featureSet


# Extract only the measurements on the mean and standard deviation for each measurement.
xDFTrain <- xDFTrain[,featureFilter]


# Load activity data including the column labels and the subject
yDFTrain[,2] = activityLabelDF[yDFTrain[,1]]
names(yDFTrain) = c("Activity_ID", "Activity_Label")
names(subjectDFTrain) = "subject"


# we have all the training data so column bind all of it
trainData <- cbind(as.data.table(subjectDFTrain), yDFTrain, xDFTrain)

# now merge test and train data by rowbind operation
resultantData = rbind(testData, trainData)

#create the necessary labels and melt the data together
idLabels = c("subject", "Activity_ID", "Activity_Label")
dataLabels = setdiff(colnames(resultantData), idLabels)
combinedData = melt(resultantData, id = idLabels, measure.vars = dataLabels)


# apply the mean through the dcast function to the measured data
cleanData = dcast(combinedData, subject + Activity_Label ~ variable, mean)
write.table(cleanData,file="./tidy_data.txt")

