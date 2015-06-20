# Getting and Cleaning Data Assessment
# Codebook

## Introduction
The purpose of this exercise is to combine all relavent data from the test and train data sets, extract out the features of interest, in this case all features with a name ending in "-mean()" or "-std()", and to then aggregate the data to find the mean over the subject and activity.

## Data
### Source

The source data comes from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

A direct link for the data can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data will need to be uncompressed in order to be processed

### Description
#### X_test.txt, X_train.txt
The raw data sets of accelerometer sensor readings. The data is unlabeled and requires features.txt to identify the features.

#### Y_test.txt, Y_train.txt
The activities attributed to the data in X_test and X_train coded to 1-6 and maps to the values in activity_labels.txt
The values in these files align exactly to each value in the "X" data sets

#### subject_test.txt, subject_train.txt
The test subjects attributed to the data in X_test and X_train coded to 1-30. To preserve test subject anonymity these values are preserved with no mapping provided
The values in these files align exactly to each value in the "X" data sets

#### activity_labels.txt
The descriptive activity names which correspond to the coded values in Y_test and Y_train
The full set of activities is 
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING


#### features.txt
features.txt contains the column names for the "X" data sets

## Transformations

The dataset pairs are concatenated together:

- X_test and X_train 
- Y_test and Y_train
- subject_test and subject_train

The combined X_test and X_train data set is then filtered so that only the columns ending in -mean() -std() are retained. This is achieved using the names from features.txt, filtered to obtain the column numbers. 

Feature names are added to all three data sets.

The 3 resultant data sets are then merged so that each row in each data set matches with its corresponding row in the other data sets. 

Finally the data set is aggregated to give the average value of each of the variables retained from the "X" datasets by the subject and activity.


## Variables

- SubjectID

        The anonymous ID Of each of the test subjects
  
- Activity

        The textual description of the activity being analysed
  
The following variables are the average values of the features taken from the original data set

- tBodyAcc-mean()-Y
- tBodyAcc-mean()-Z          
- tBodyAcc-std()-X
- tBodyAcc-std()-Y
- tBodyAcc-std()-Z
- tGravityAcc-mean()-X       
- tGravityAcc-mean()-Y
- tGravityAcc-mean()-Z
- tGravityAcc-std()-X
- tGravityAcc-std()-Y        
- tGravityAcc-std()-Z
- tBodyAccJerk-mean()-X
- tBodyAccJerk-mean()-Y
- tBodyAccJerk-mean()-Z      
- tBodyAccJerk-std()-X
- tBodyAccJerk-std()-Y
- tBodyAccJerk-std()-Z
- tBodyGyro-mean()-X         
- tBodyGyro-mean()-Y
- tBodyGyro-mean()-Z
- tBodyGyro-std()-X
- tBodyGyro-std()-Y          
- tBodyGyro-std()-Z
- tBodyGyroJerk-mean()-X
- tBodyGyroJerk-mean()-Y
- tBodyGyroJerk-mean()-Z     
- tBodyGyroJerk-std()-X
- tBodyGyroJerk-std()-Y
- tBodyGyroJerk-std()-Z
- tBodyAccMag-mean()         
- tBodyAccMag-std()
- tGravityAccMag-mean()
- tGravityAccMag-std()
- tBodyAccJerkMag-mean()     
- tBodyAccJerkMag-std()
- tBodyGyroMag-mean()
- tBodyGyroMag-std()
- tBodyGyroJerkMag-mean()    
- tBodyGyroJerkMag-std()
- fBodyAcc-mean()-X
- fBodyAcc-mean()-Y
- fBodyAcc-mean()-Z          
- fBodyAcc-std()-X
- fBodyAcc-std()-Y
- fBodyAcc-std()-Z
- fBodyAccJerk-mean()-X      
- fBodyAccJerk-mean()-Y
- fBodyAccJerk-mean()-Z
- fBodyAccJerk-std()-X
- fBodyAccJerk-std()-Y       
- fBodyAccJerk-std()-Z
- fBodyGyro-mean()-X
- fBodyGyro-mean()-Y
- fBodyGyro-mean()-Z         
- fBodyGyro-std()-X
- fBodyGyro-std()-Y
- fBodyGyro-std()-Z
- fBodyAccMag-mean()         
- fBodyAccMag-std()
- fBodyBodyAccJerkMag-mean()
- fBodyBodyAccJerkMag-std()
- fBodyBodyGyroMag-mean()    
- fBodyBodyGyroMag-std()
- fBodyBodyGyroJerkMag-mean()