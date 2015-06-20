#####################################################################################################
#
# INSTRUCTIONS
#
# You should create one R script called run_analysis.R that does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#    of each variable for each activity and each subject.
#
#####################################################################################################

#####################################################################################################
#
# INITIALISATION
#
#####################################################################################################

# Set working directory
# setwd("D:/My Documents/Documents/Coursera/Getting and Cleaning Data")

# get the X data files
xtestfile  <- "./UCI HAR Dataset/test/X_test.txt"
xtrainfile <- "./UCI HAR Dataset/train/X_train.txt"

# get the y files 
ytestfile  <- "./UCI HAR Dataset/test/Y_test.txt"
ytrainfile <- "./UCI HAR Dataset/train/Y_train.txt"

# get the subject files 
subjecttestfile  <- "./UCI HAR Dataset/test/subject_test.txt"
subjecttrainfile <- "./UCI HAR Dataset/train/subject_train.txt"

# the following files contain the headers for the X files
# and the labels for the activities in the Y files
discriptiveNamesfile <- "./UCI HAR Dataset/features.txt"
activitylabelsfile <- "./UCI HAR Dataset/activity_labels.txt"	

# export location
exportfile <- "./AggregatedResults.txt"

#####################################################################################################
#
# GET DATA
# 
# Activty 1. Merges the training and the test sets to create one data set.
#
#####################################################################################################

# Load X files to data frames
xtrain <- read.table(xtrainfile)
xtest <- read.table(xtestfile)
# merge the test and train files together
xcomplete <- rbind(xtest, xtrain)

# Load Y files to data frames
ytrain <- read.table(ytrainfile)
ytest <- read.table(ytestfile)
# merge the test and train files together
ycomplete <- rbind(ytest, ytrain)

# Load subject files to data frames
subjecttrain <- read.table(subjecttrainfile)
subjecttest <- read.table(subjecttestfile)
# merge the test and train files together
subjectcomplete <- rbind(subjecttest, subjecttrain)

activitylabels <- read.table(activitylabelsfile)

#####################################################################################################
#
# EXTRACT REQUIRED MEASUREMENTS
# 
# Activty 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#####################################################################################################


#
# Need to load all the column names with numbers in to a dataframe
# filter out everything but the STD and MEAN columns, get the column numbers
# then filter the xcomplete dataset down to the relevant columns
#
# the resultant data set can then have the descriptive headers applied 
# and processing can continue
#

descriptiveNames <-read.table(discriptiveNamesfile)
# I could not find an elegant way to get grep to find the mean and the std columns in one go :(
# I've used two statements then merged the output using rbind
descriptiveNames <- rbind(descriptiveNames[grep("-std()",descriptiveNames[, 2], fixed = TRUE),  ], descriptiveNames[grep("-mean()",descriptiveNames[, 2], fixed = TRUE),  ])
# sort the descriptive names by column ID 
descriptiveNames <- descriptiveNames[order(descriptiveNames[1]),]

# reduce the xcomplete dataset down to the required columns
xcomplete <- xcomplete[,descriptiveNames[,1]]

#####################################################################################################
#
# MAP CODED VALUES
# 
# Activty 3. Uses descriptive activity names to name the activities in the data set
#####################################################################################################

# Map the activities on to ycomplete
ycomplete <- activitylabels[match(ycomplete[,1],activitylabels[,1]), 2, drop=F]

#####################################################################################################
#
# SET VARIABLE NAMES
# 
# Activty 4. Appropriately labels the data set with descriptive variable names. 
#####################################################################################################

# set the column header names on the Y complete data set
colnames(ycomplete) <- "Activity"

# set the column header names on the X complete data set
colnames(xcomplete) <- descriptiveNames[,2]

# set the column header names on the subject complete data set
colnames(subjectcomplete) <- "SubjectID"

# Merge the Y and X data frames together with the subjects 
complete <- cbind(subjectcomplete, cbind(ycomplete, xcomplete))

#####################################################################################################
#
# AGGREGATE
# 
# Activty 5. From the data set in step 4, creates a second, independent tidy data set with the 
#            average of each variable for each activity and each subject.
#####################################################################################################

#
# Use the lecture notes on dplyr to 
# select, subset and aggregate the data
#
numcols <- count(descriptiveNames)

aggregatedata <- aggregate(complete[,3:as.numeric(numcols)+1],by=complete[c("SubjectID","Activity")] ,FUN=mean )

#####################################################################################################
# EXPORT
#
# Please upload the tidy data set created in step 5 of the instructions. Please upload your data 
# set as a txt file created with write.table() using row.name=FALSE (do not cut and paste a dataset 
# directly into the text box, as this may cause errors saving your submission).
#####################################################################################################

# set row.names to false to avoid the awkward row numbers being printed on each line
write.table(aggregatedata, exportfile, row.names = FALSE)

